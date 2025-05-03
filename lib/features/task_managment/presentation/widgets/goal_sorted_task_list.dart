import 'package:flutter/material.dart';
import 'package:planza/core/constants/sort_ordering.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/goal_list_extention.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';
import 'package:planza/features/goal_managment/bloc/goal_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/data/models/goal_model.dart';
import 'task_tile.dart';

class GoalSortedTaskList extends StatefulWidget {
  const GoalSortedTaskList({
    super.key,
    required this.goalState,
    required this.sortOrdering,
    required this.includeDoneTasks,
  });

  final GoalState goalState;
  final SortOrdering sortOrdering;
  final bool includeDoneTasks;

  @override
  State<GoalSortedTaskList> createState() => _GoalSortedTaskListState();
}

class _GoalSortedTaskListState extends State<GoalSortedTaskList> {
  final Duration recentDuration = Duration(days: 7);
  GoalModel? selectedGoal;

  @override
  Widget build(BuildContext context) {
    final List<GoalModel> goals = widget.goalState is GoalsLoadedState
        ? (widget.goalState as GoalsLoadedState).goals
        : List.generate(
            5,
            (index) => GoalModel(
              id: index,
              name: 'place holder',
              completed: false,
              color: Colors.grey,
              deadline: DateTime.now()
                  .subtract(Duration(days: 5))
                  .add(Duration(days: index)),
              tasks: [
                TaskModel(title: 'place holder'),
              ],
            ),
          );

    goals.sortByName(widget.sortOrdering);

    return Skeletonizer(
      enabled: widget.goalState is! GoalsLoadedState,
      child: ScrollableColumn(
        spacing: 10,
        children: List.generate(
          goals.length,
          (goalIndex) {
            final GoalModel goal = goals[goalIndex];

            final List<TaskModel> tasks = widget.includeDoneTasks
                ? goal.tasks
                : goal.tasks.incompleteTasks;

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: tasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: tasks.isEmpty
                  ? const SizedBox()
                  : ExpansionTile(
                      initiallyExpanded: false,
                      leading: CircleAvatar(
                        backgroundColor: goal.color,
                        radius: 7,
                      ),
                      title: Text(
                        goal.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      children: List.generate(
                        tasks.length,
                        (taskIndex) =>
                            TaskTile(task: tasks[taskIndex]..goal = goal),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
