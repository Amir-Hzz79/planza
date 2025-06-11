import 'package:flutter/material.dart';
import 'package:planza/core/constants/sort_ordering.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/goal_list_extention.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';

import '../../../../core/data/models/goal_model.dart';
import 'task_tile.dart';

class GoalSortedTaskList extends StatefulWidget {
  const GoalSortedTaskList({
    super.key,
    required this.sortOrdering,
    required this.includeDoneTasks,
  });

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
    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        goals.sortByName(widget.sortOrdering);
        return ScrollableColumn(
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
                          (taskIndex) {
                            tasks[taskIndex] =
                                tasks[taskIndex].copyWith(goal: goal);

                            return TaskTile(task: tasks[taskIndex]);
                          },
                        ),
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
