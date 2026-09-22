import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/data/models/hobby_session_model.dart';
import 'package:planza/core/design/primitives/pl_app_bar.dart';
import 'package:planza/core/design/primitives/pl_button.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/features/hobbies_habits/presentation/bloc/hobbies_bloc.dart';
import 'package:planza/features/hobbies_habits/presentation/widgets/session_card.dart';
import 'package:planza/core/utils/recurrence_engine.dart';
import 'package:planza/core/utils/hobby_stats.dart';
import 'package:planza/features/hobbies_habits/presentation/pages/hobby_create_edit_page.dart';

class HobbyDetailPage extends StatefulWidget {
  final HobbyModel hobby;

  const HobbyDetailPage({super.key, required this.hobby});

  @override
  State<HobbyDetailPage> createState() => _HobbyDetailPageState();
}

class _HobbyDetailPageState extends State<HobbyDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<HobbiesBloc>().add(LoadHobbySessions(widget.hobby.id));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hobbyColor = widget.hobby.color != null
        ? Color(widget.hobby.color!)
        : colorScheme.primary;
    final hobbyIcon = widget.hobby.icon != null
        ? IconData(widget.hobby.icon!)
        : Icons.track_changes;

    return Scaffold(
      appBar: PlAppBar(
        title: widget.hobby.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
            tooltip: 'Edit Hobby',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _showDeleteConfirmation,
            tooltip: 'Delete Hobby',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TabBar(
            controller: _tabController,
            indicatorColor: colorScheme.primary,
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            labelStyle: PlTypography.labelLarge.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: PlTypography.labelLarge,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Sessions'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildSessionsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startSession,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start Session'),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return BlocBuilder<HobbiesBloc, HobbiesState>(
      builder: (context, state) {
        if (state is HobbiesLoaded) {
          final hobby = state.hobbies.firstWhere(
            (h) => h.id == widget.hobby.id,
            orElse: () => widget.hobby,
          );
          final stats = _stats;
          return _buildOverviewContent(hobby, stats);
        }
        if (state is HobbySessionsLoaded) {
          final hobby = widget.hobby;
          final stats = state.stats;
          _stats = stats;
          return _buildOverviewContent(hobby, stats);
        }
        return _buildLoadingState();
      },
    );
  }

  HobbyStats? _stats;

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonSection(),
          const SizedBox(height: PlSpacing.lg),
          _buildSkeletonSection(),
          const SizedBox(height: PlSpacing.lg),
          _buildSkeletonSection(),
        ],
      ),
    );
  }

  Widget _buildSkeletonSection() {
    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 150,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          const SizedBox(height: PlSpacing.md),
          Container(
            height: 100,
            width: double.infinity,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewContent(HobbyModel hobby, HobbyStats? stats) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hobbyColor = hobby.color != null
        ? Color(hobby.color!)
        : colorScheme.primary;
    final hobbyIcon = hobby.icon != null
        ? IconData(hobby.icon!)
        : Icons.track_changes;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlCard(
            padding: const EdgeInsets.all(PlSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: hobbyColor.withValues(alpha: 0.15),
                        borderRadius: PlSpacing.borderRadiusLg,
                      ),
                      child: Icon(
                        hobbyIcon,
                        size: 36,
                        color: hobbyColor,
                      ),
                    ),
                    const SizedBox(width: PlSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hobby.name,
                            style: PlTypography.headlineMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: PlSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: PlSpacing.sm,
                              vertical: PlSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: PlSpacing.borderRadiusSm,
                            ),
                            child: Text(
                              RecurrenceEngine.frequencyToString(
                                widget.hobby.frequency,
                                widget.hobby.customFrequencyJson,
                              ),
                              style: PlTypography.labelMedium.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: PlSpacing.md),
                if (widget.hobby.targetDurationMinutes != null) ...[
                  Row(
                    children: [
                      Icon(Icons.timer, size: 20, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: PlSpacing.xs),
                      Text(
                        'Target: ${widget.hobby.targetDurationMinutes} min/session',
                        style: PlTypography.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PlSpacing.md),
                ],
                if (widget.hobby.goalId != null) ...[
                  Row(
                    children: [
                      Icon(Icons.flag, size: 20, color: colorScheme.primary),
                      const SizedBox(width: PlSpacing.xs),
                      Text(
                        'Linked to Goal ID: ${widget.hobby.goalId}',
                        style: PlTypography.bodyMedium.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PlSpacing.md),
                ],
                Text(
                  'Frequency: ${RecurrenceEngine.frequencyToString(widget.hobby.frequency, widget.hobby.customFrequencyJson)}',
                  style: PlTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: PlSpacing.md),
          _buildStatsGrid(),
          const SizedBox(height: PlSpacing.md),
          _buildNextDueDate(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final s = _stats;
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: PlSpacing.md,
      mainAxisSpacing: PlSpacing.md,
      childAspectRatio: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          'Total Sessions',
          '${s?.totalSessions ?? 0}',
          Icons.repeat,
          Theme.of(context).colorScheme.primary,
        ),
        _buildStatCard(
          'Total Time',
          s?.totalTimeDisplay ?? '0 min',
          Icons.timer,
          Theme.of(context).colorScheme.secondary,
        ),
        _buildStatCard(
          'Current Streak',
          '${s?.currentStreak ?? 0} days',
          Icons.local_fire_department,
          Colors.orange,
        ),
        _buildStatCard(
          'Longest Streak',
          '${s?.longestStreak ?? 0} days',
          Icons.emoji_events,
          Colors.amber,
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: PlSpacing.sm),
          Text(
            value,
            style: PlTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: PlSpacing.xs),
          Text(
            label,
            style: PlTypography.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNextDueDate() {
    final nextDue = RecurrenceEngine.getNextDueDate(
      widget.hobby,
      DateTime.now(),
    );

    if (nextDue == null) return const SizedBox.shrink();

    final isToday = DateTime.now().difference(nextDue).inDays == 0;
    final isTomorrow = nextDue.difference(DateTime.now()).inDays == 1;

    String label;
    if (isToday) {
      label = 'Due Today!';
    } else if (isTomorrow) {
      label = 'Due Tomorrow';
    } else {
      label = 'Next Due';
    }

    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.md),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: PlSpacing.borderRadiusMd,
            ),
            child: Icon(
              isToday ? Icons.today : Icons.event,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: PlSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: PlTypography.labelLarge.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${nextDue.day}/${nextDue.month}/${nextDue.year}',
                  style: PlTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsTab() {
    return BlocBuilder<HobbiesBloc, HobbiesState>(
      builder: (context, state) {
        if (state is HobbiesLoaded) {
          return BlocBuilder<HobbiesBloc, HobbiesState>(
            builder: (context, state) {
              if (state is HobbySessionsLoaded) {
                if (state.sessions.isEmpty) {
                  return _buildEmptySessionsState();
                }
                return _buildSessionsList(state.sessions);
              }
              return _buildLoadingState();
            },
          );
        }
        return _buildLoadingState();
      },
    );
  }

  Widget _buildEmptySessionsState() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              'No Sessions Yet',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              'Complete your first session to see it here',
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton.primary(
              label: 'Start First Session',
              onPressed: _startSession,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionsList(List<HobbySessionModel> sessions) {
    final sorted = [...sessions]
      ..sort((a, b) => b.startTime.compareTo(a.startTime));

    return ListView.builder(
      padding: const EdgeInsets.all(PlSpacing.md),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sorted[index];
        return SessionCard(
          session: session,
          onTap: () => _showSessionDetail(session),
        );
      },
    );
  }

  void _startSession() {
    context.read<HobbiesBloc>().add(StartHobbySession(widget.hobby.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Started session for ${widget.hobby.name}')),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => HobbyCreateEditDialog(
        hobby: widget.hobby,
        onSave: (hobby) {
          context.read<HobbiesBloc>().add(UpdateHobby(hobby));
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Delete ${widget.hobby.name}?', style: PlTypography.headlineSmall),
        content: Text(
          'This will delete the hobby and all its sessions. This action cannot be undone.',
          style: PlTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel', style: PlTypography.labelLarge),
          ),
          PlButton.destructive(
            label: 'Delete',
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<HobbiesBloc>().add(DeleteHobby(widget.hobby.id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSessionDetail(HobbySessionModel session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => _SessionDetailSheet(session: session),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _moodToEmoji(int mood) {
    const emojis = ['😭', '😞', '😐', '😊', '😍'];
    if (mood >= 1 && mood <= 5) return emojis[mood - 1];
    return '';
  }
}

class _SessionDetailSheet extends StatelessWidget {
  final HobbySessionModel session;

  const _SessionDetailSheet({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (scrollContext, scrollController) {
        return Container(
          padding: const EdgeInsets.all(PlSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: PlSpacing.lg),
              Text('Session Details', style: PlTypography.headlineSmall),
              const SizedBox(height: PlSpacing.lg),
              _buildDetailRow(context, 'Start Time', _formatDateTime(session.startTime)),
              if (session.endTime != null)
                _buildDetailRow(context, 'End Time', _formatDateTime(session.endTime!)),
              if (session.durationMinutes != null)
                _buildDetailRow(context, 'Duration', '${session.durationMinutes} min'),
              if (session.mood != null)
                _buildDetailRow(context, 'Mood', _moodToEmoji(session.mood!)),
              if (session.notes != null && session.notes!.isNotEmpty) ...[
                _buildDetailRow(context, 'Notes', ''),
                const SizedBox(height: PlSpacing.xs),
                Text(
                  session.notes!,
                  style: PlTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              _buildDetailRow(context, 'Created', _formatDateTime(session.createdAt)),
            ],
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _moodToEmoji(int mood) {
    const emojis = ['😭', '😞', '😐', '😊', '😍'];
    if (mood >= 1 && mood <= 5) return emojis[mood - 1];
    return '';
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: PlTypography.labelLarge.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: PlTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
