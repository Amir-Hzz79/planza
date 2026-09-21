import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/features/hobbies_habits/presentation/bloc/hobbies_bloc.dart';

import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/design/primitives/index.dart';
import 'package:planza/core/utils/recurrence_engine.dart';
import 'package:planza/features/hobbies_habits/presentation/widgets/index.dart';
import 'package:planza/features/hobbies_habits/presentation/pages/hobby_create_edit_page.dart';
import 'package:planza/features/hobbies_habits/presentation/pages/hobby_detail_page.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key});

  @override
  State<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage>
    with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';
  late TabController _tabController;

  final _filters = ['All', 'Active', 'Daily', 'Weekly', 'Custom'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<HobbiesBloc>().add(LoadHobbies());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlAppBar(
        title: 'Hobbies & Habits',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateHobbyDialog,
            tooltip: 'Create Hobby',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  PlSpacing.md,
                  0,
                  PlSpacing.md,
                  PlSpacing.sm,
                ),
                child: PlTextField(
                  controller: _searchController,
                  hint: 'Search hobbies...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: colorScheme.primary,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: PlTypography.labelLarge
                    .copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: PlTypography.labelLarge,
                tabs: const [
                  Tab(text: 'All Hobbies'),
                  Tab(text: 'Due Today'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHobbiesList(),
          _buildDueToday(),
        ],
      ),
      floatingActionButton: PlFAB(
        onPressed: _showCreateHobbyDialog,
        icon: Icons.add,
      ),
    );
  }

  Widget _buildHobbiesList() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: PlSpacing.md),
          child: Row(
            children: _filters.map((f) {
              final isSelected = _selectedFilter == f;
              return Padding(
                padding: const EdgeInsets.only(right: PlSpacing.sm),
                child: FilterChip(
                  label: Text(f),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedFilter = f),
                  selectedColor: colorScheme.primaryContainer,
                  checkmarkColor: colorScheme.onPrimaryContainer,
                ),
              );
            }).toList(),
          ),
        ),
        BlocConsumer<HobbiesBloc, HobbiesState>(
          listener: (context, state) {
            if (state is HobbiesActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is HobbiesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: Theme.of(context).colorScheme.error),
              );
            }
          },
          builder: (context, state) {
            if (state is HobbiesLoading) {
              return _buildLoadingState();
            } else if (state is HobbiesLoaded) {
              final filtered = _filterHobbies(state.hobbies);
              if (filtered.isEmpty) {
                return _buildEmptyState();
              }
              return _buildHobbyGrid(filtered);
            } else if (state is HobbiesError) {
              return _buildErrorState(state.message);
            }
            return _buildEmptyState();
          },
        ),
      ],
    );
  }

  Widget _buildDueToday() {
    return BlocBuilder<HobbiesBloc, HobbiesState>(
      builder: (context, state) {
        if (state is HobbiesLoaded) {
          final dueToday = state.hobbies
              .where((h) => h.isActive && RecurrenceEngine.isDueToday(h))
              .toList();

          if (dueToday.isEmpty) {
            return _buildEmptyDueState();
          }

          return _buildHobbyGrid(dueToday);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: const EdgeInsets.all(PlSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: PlSpacing.md,
        mainAxisSpacing: PlSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return PlCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(PlSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 20,
                    width: double.infinity,
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest),
                const SizedBox(height: PlSpacing.xs),
                Container(
                    height: 14,
                    width: 150,
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest),
                const SizedBox(height: PlSpacing.md),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 36,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest)),
                    const SizedBox(width: PlSpacing.sm),
                    Expanded(
                        child: Container(
                            height: 36,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest)),
                    const SizedBox(width: PlSpacing.sm),
                    Expanded(
                        child: Container(
                            height: 36,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isNotEmpty ? Icons.search_off : Icons.track_changes,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No hobbies found for "$_searchQuery"'
                  : 'No hobbies yet',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'Create your first hobby to get started',
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton.primary(
              label: _searchQuery.isNotEmpty ? 'Clear Search' : 'Create Hobby',
              onPressed: _searchQuery.isNotEmpty
                  ? () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    }
                  : _showCreateHobbyDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDueState() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              'All caught up!',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              'No hobbies due today. Enjoy your free time!',
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              'Error Loading Hobbies',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              message,
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton.primary(
              label: 'Retry',
              onPressed: () {
                context.read<HobbiesBloc>().add(RefreshHobbies());
              },
            ),
          ],
        ),
      ),
    );
  }

  List<HobbyModel> _filterHobbies(List<HobbyModel> hobbies) {
    var filtered = hobbies.where((h) {
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final nameMatch = h.name.toLowerCase().contains(query);
        final descMatch = h.description?.toLowerCase().contains(query) ?? false;
        final catMatch = h.category.toLowerCase().contains(query);
        if (!(nameMatch || descMatch || catMatch)) return false;
      }

      switch (_selectedFilter) {
        case 'Active':
          return h.isActive;
        case 'Daily':
          return h.frequency == 'daily';
        case 'Weekly':
          return h.frequency == 'weekly';
        case 'Custom':
          return h.frequency == 'custom';
        default:
          return true;
      }
    }).toList();

    return filtered;
  }

  Widget _buildHobbyGrid(List<HobbyModel> hobbies) {
    return GridView.builder(
      padding: const EdgeInsets.all(PlSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: PlSpacing.md,
        mainAxisSpacing: PlSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: hobbies.length,
      itemBuilder: (context, index) {
        final hobby = hobbies[index];
        return HobbyCard(
          hobby: hobby,
          onTap: () => _showHobbyDetail(hobby),
          onStartSession: () => _startHobbySession(hobby),
        );
      },
    );
  }

  void _showCreateHobbyDialog() {
    showDialog(
      context: context,
      builder: (context) => HobbyCreateEditDialog(
        onSave: (hobby) {
          context.read<HobbiesBloc>().add(AddHobby(hobby));
        },
      ),
    );
  }

  void _showHobbyDetail(HobbyModel hobby) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HobbyDetailPage(hobby: hobby),
      ),
    );
  }

  void _startHobbySession(HobbyModel hobby) {
    context.read<HobbiesBloc>().add(StartHobbySession(hobby.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Started session for ${hobby.name}')),
    );
  }
}
