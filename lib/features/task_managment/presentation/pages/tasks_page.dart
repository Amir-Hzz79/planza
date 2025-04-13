import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/core/utils/extention_methods/goal_list_extention.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';
import 'package:planza/features/goal_managment/bloc/goal_bloc.dart';

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
            if (taskState is TasksLoadedState &&
                goalsState is GoalsLoadedState) {
              final List<TaskModel> pastTasks = taskState.tasks
                  .filterOnGoal(selectedGoal?.id)
                  .overdueTasks
                  .incompleteTasks;
              final List<TaskModel> todayTasks = taskState.tasks
                  .filterOnGoal(selectedGoal?.id)
                  .tasksDueToday
                  .incompleteTasks;
              final List<TaskModel> futureTasks = taskState.tasks
                  .filterOnGoal(selectedGoal?.id)
                  .upcomingTasks
                  .incompleteTasks;
              final List<TaskModel> recentCompletedTasks = taskState.tasks
                  .filterOnGoal(selectedGoal?.id)
                  .recentTasks(recentDuration)
                  .completedTasks;

              final List<GoalModel> incompleteTaskGoals =
                  goalsState.goals.incompleteTaskGoals;
              final List<GoalModel> recentCompletedTaskGoals =
                  goalsState.goals.recentCompletedTaskGoals(recentDuration);
              final List<GoalModel> showingGoals =
                  incompleteTaskGoals + recentCompletedTaskGoals;

              return ScrollableColumn(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ScrollableRow(
                      spacing: 5,
                      children: List.generate(
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
                    ),
                  ),
                  if (pastTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (pastTasks.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          pastExpanded = !pastExpanded;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          appLocalization.translate('past'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          pastExpanded
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                  if (pastTasks.isNotEmpty && pastExpanded)
                    ...List.generate(
                      pastTasks.length,
                      (index) => TaskTile(
                        task: pastTasks[index],
                      ),
                    ),
                  if (todayTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (todayTasks.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          todayExpanded = !todayExpanded;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          appLocalization.translate('today'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          todayExpanded
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                  if (todayTasks.isNotEmpty && todayExpanded)
                    ...List.generate(
                      todayTasks.length,
                      (index) => TaskTile(
                        task: todayTasks[index],
                      ),
                    ),
                  if (futureTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (futureTasks.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          futureExpanded = !futureExpanded;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          appLocalization.translate('future'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          futureExpanded
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                  if (futureTasks.isNotEmpty && futureExpanded)
                    ...List.generate(
                      futureTasks.length,
                      (index) => TaskTile(
                        task: futureTasks[index],
                      ),
                    ),
                  if (recentCompletedTasks.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (recentCompletedTasks.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          recentCompletedExpand = !recentCompletedExpand;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          appLocalization.translate('recent_done_tasks'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Icon(
                          recentCompletedExpand
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                  if (recentCompletedTasks.isNotEmpty && recentCompletedExpand)
                    ...List.generate(
                      recentCompletedTasks.length,
                      (index) => TaskTile(
                        task: recentCompletedTasks[index],
                      ),
                    ),
                  const SizedBox(
                    height: 500,
                  ),
                ],
              );
            } else {
              return Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
              );
            }
          },
        );
      },
    );
  }
}
