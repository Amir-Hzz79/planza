import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/core/utils/extention_methods/goal_list_extention.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';
import 'package:planza/features/goal_managment/bloc/goal_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/task_bloc.dart';
import '../widgets/task_tile.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DateTime selectedDate = DateTime.now();

  bool pastExpanded = true;
  bool todayExpanded = true;
  bool futureExpanded = true;
  bool recentCompletedExpand = true;

  GoalModel? selectedGoal;
  final Duration recentDuration = Duration(days: 7);

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        return BlocBuilder<GoalBloc, GoalState>(
          builder: (context, goalsState) {
            final List<TaskModel> tasks = taskState is TasksLoadedState
                ? taskState.tasks
                : List.generate(
                    8,
                    (index) => TaskModel(
                      id: index,
                      title: 'fake data',
                      dueDate: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                    ),
                  );
            final List<GoalModel> goals = goalsState is GoalsLoadedState
                ? goalsState.goals
                : List.generate(
                    5,
                    (index) => GoalModel(
                      id: index,
                      name: 'fake data',
                      completed: false,
                      color: Colors.grey,
                      deadline: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                      tasks: tasks,
                    ),
                  );

            final List<TaskModel> filteredTasksOnGoal =
                tasks.filterOnGoal(selectedGoal?.id);

            final List<TaskModel> noOverdueTasks =
                filteredTasksOnGoal.noDueDateTasks;
            final List<TaskModel> pastTasks =
                filteredTasksOnGoal.overdueTasks.incompleteTasks;
            final List<TaskModel> todayTasks =
                filteredTasksOnGoal.tasksDueToday.incompleteTasks;
            final List<TaskModel> futureTasks =
                filteredTasksOnGoal.upcomingTasks.incompleteTasks;
            final List<TaskModel> recentCompletedTasks =
                filteredTasksOnGoal.recentTasks(recentDuration).completedTasks;

            final List<GoalModel> incompleteTaskGoals =
                goals.incompleteTaskGoals;
            final List<GoalModel> recentCompletedTaskGoals =
                goals.recentCompletedTaskGoals(recentDuration);
            final List<GoalModel> showingGoals =
                (incompleteTaskGoals + recentCompletedTaskGoals)
                    .toSet()
                    .toList();
            showingGoals.sort(
              (a, b) => a.id!.compareTo(b.id!),
            );

            return Skeletonizer(
              enabled: taskState is! TasksLoadedState ||
                  goalsState is! GoalsLoadedState,
              child: ScrollableColumn(
                spacing: 5,
                children: [
                  ScrollableRow(
                    spacing: 5,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      ...List.generate(
                        showingGoals.length,
                        (index) => FilledButton(
                          onPressed: () {
                            setState(
                              () {
                                if (selectedGoal == showingGoals[index]) {
                                  selectedGoal = null;
                                } else {
                                  selectedGoal = showingGoals[index];
                                }
                              },
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                selectedGoal?.id == showingGoals[index].id
                                    ? showingGoals[index].color
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                            foregroundColor:
                                selectedGoal?.id == showingGoals[index].id
                                    ? showingGoals[index].color.matchTextColor()
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer
                                        .matchTextColor(),
                            minimumSize: Size(100, 45),
                          ),
                          child: Text(showingGoals[index].name),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  if (noOverdueTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (noOverdueTasks.isNotEmpty)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        appLocalization.translate('no_dueDate'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      children: List.generate(
                        noOverdueTasks.length,
                        (index) => TaskTile(
                          task: noOverdueTasks[index],
                        ),
                      ),
                    ),
                  if (pastTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (pastTasks.isNotEmpty)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        appLocalization.translate('past'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      children: List.generate(
                        pastTasks.length,
                        (index) => TaskTile(
                          task: pastTasks[index],
                        ),
                      ),
                    ),
                  if (todayTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (todayTasks.isNotEmpty)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        appLocalization.translate('today'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      children: List.generate(
                        todayTasks.length,
                        (index) => TaskTile(
                          task: todayTasks[index],
                        ),
                      ),
                    ),
                  if (futureTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (futureTasks.isNotEmpty)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        appLocalization.translate('future'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      children: List.generate(
                        futureTasks.length,
                        (index) => TaskTile(
                          task: futureTasks[index],
                        ),
                      ),
                    ),
                  if (recentCompletedTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (recentCompletedTasks.isNotEmpty)
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        appLocalization.translate('recent_done_tasks'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      children: List.generate(
                        recentCompletedTasks.length,
                        (index) => TaskTile(
                          task: recentCompletedTasks[index],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 500,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
