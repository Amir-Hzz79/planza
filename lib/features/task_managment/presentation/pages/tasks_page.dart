import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/data/bloc/tag_bloc/tag_bloc_builder.dart';

import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/features/task_managment/presentation/widgets/grouped_task_list_view.dart';
import 'package:planza/features/task_managment/presentation/widgets/calendar_task_view.dart';
import 'package:planza/features/task_managment/presentation/widgets/filter_sheet.dart';

import '../../../../core/data/models/goal_model.dart';
import '../../../../core/data/models/tag_model.dart';
import '../../../../core/locale/app_localizations.dart';
import '../../../../core/widgets/appbar/general_app_bar.dart';
import '../../../home/presentation/widgets/drawer/drawer_section.dart';
import '../widgets/filter_pill.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // State for UI views
  bool _isCalendarView = false;
  bool _isSearching = false;
  final _searchController = TextEditingController();

  // State for active filters
  bool _showCompleted = false;
  Set<int> _goalIds = {};
  Set<int> _tagIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterPanel() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterSheet(
        initialShowCompleted: _showCompleted,
        initialGoalIds: _goalIds,
        initialTagIds: _tagIds,
      ),
    );

    if (result != null) {
      setState(() {
        _showCompleted = result['showCompleted'];
        _goalIds = result['goalIds'];
        _tagIds = result['tagIds'];
      });
    }
  }

  Widget _buildActiveFiltersBar(
      List<GoalModel> allGoals, List<TagModel> allTags) {
    final Lang lang = Lang.of(context)!;

    bool hasFilters =
        _showCompleted || _goalIds.isNotEmpty || _tagIds.isNotEmpty;
    if (!hasFilters) return const SizedBox.shrink();

    final List<Widget> filterPills = [];
    if (_showCompleted) {
      filterPills.add(FilterPill(
          label: lang.tasksPage_pills_completed,
          onDeleted: () => setState(() => _showCompleted = false)));
    }
    for (int goalId in _goalIds) {
      final goal = allGoals.firstWhere(
        (g) => g.id == goalId,
      );
      filterPills.add(
        FilterPill(
          label: goal.name,
          icon: goal.icon,
          color: goal.color,
          onDeleted: () => setState(
            () => _goalIds.remove(goalId),
          ),
        ),
      );
    }
    for (int tagId in _tagIds) {
      final tag = allTags.firstWhere(
        (t) => t.id == tagId,
      );
      filterPills.add(FilterPill(
          label: "#${tag.name}",
          onDeleted: () => setState(() => _tagIds.remove(tagId))));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: filterPills),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return PopScope(
      canPop: !_isSearching,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_isSearching) setState(() => _isSearching = false);
      },
      child: GoalBlocBuilder(
        onDataLoaded: (allGoals) {
          return TagBlocBuilder(
            onDataLoaded: (allTags) {
              return TaskBlocBuilder(
                onDataLoaded: (allTasks) {
                  return Scaffold(
                    drawer: DrawerSection(),
                    appBar: AppBar(
                      leading: GeneralAppBar(),
                      title: _isSearching
                          ? TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: lang.tasksPage_search_hint,
                                  border: InputBorder.none),
                              onChanged: (query) => setState(() {}),
                            )
                          : Text(
                              lang.tasksPage_title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      actions: _isSearching
                          ? [
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => setState(
                                  () => _isSearching = false,
                                ),
                              )
                            ]
                          : [
                              IconButton(
                                icon: Icon(
                                  _isCalendarView
                                      ? Icons.view_list_outlined
                                      : Icons.calendar_month_outlined,
                                ),
                                onPressed: () => setState(
                                  () => _isCalendarView = !_isCalendarView,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.filter_alt_rounded),
                                onPressed: _showFilterPanel,
                              ),
                              IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () => setState(
                                  () => _isSearching = true,
                                ),
                              ),
                            ],
                    ),
                    body: Column(
                      children: [
                        _buildActiveFiltersBar(allGoals, allTags),
                        Expanded(
                          child: BlocBuilder<TaskBloc, TaskState>(
                            builder: (context, state) {
                              if (state is! TasksLoadedState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              // --- Filtering and Searching Logic ---
                              List<TaskModel> tasksToShow =
                                  state.tasks.where((task) {
                                final isCompletedMatch =
                                    _showCompleted || !task.isCompleted;
                                final goalMatch = _goalIds.isEmpty ||
                                    (_goalIds.contains(task.goal?.id));
                                final tagMatch = _tagIds.isEmpty ||
                                    task.tags
                                        .any((tag) => _tagIds.contains(tag.id));
                                return isCompletedMatch &&
                                    goalMatch &&
                                    tagMatch;
                              }).toList();

                              if (_isSearching &&
                                  _searchController.text.isNotEmpty) {
                                final query =
                                    _searchController.text.toLowerCase();
                                tasksToShow = tasksToShow.where((task) {
                                  return task.title
                                          .toLowerCase()
                                          .contains(query) ||
                                      (task.description
                                              ?.toLowerCase()
                                              .contains(query) ??
                                          false) ||
                                      (task.goal?.name
                                              .toLowerCase()
                                              .contains(query) ??
                                          false);
                                }).toList();
                              }

                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _isCalendarView
                                    ? CalendarTaskView(
                                        key: const ValueKey('calendar'),
                                        tasks: tasksToShow,
                                      )
                                    : GroupedTaskListView(
                                        key: const ValueKey('list'),
                                        tasks: tasksToShow,
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
