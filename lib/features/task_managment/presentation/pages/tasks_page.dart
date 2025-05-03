import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/features/goal_managment/bloc/goal_bloc.dart';
import 'package:planza/features/task_managment/presentation/widgets/date_sorted_task_list.dart';
import 'package:planza/features/task_managment/presentation/widgets/goal_sorted_task_list.dart';
import 'package:planza/features/task_managment/presentation/widgets/sort_list.dart';

import '../../../../core/constants/sort_ordering.dart';

import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/task_bloc.dart';
import '../widgets/priority_sorted_task_list.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  SortTypes selectedSortType = SortTypes.date;
  SortOrdering selectedSortOrder = SortOrdering.ascending;
  bool includeDoneTasks = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        return BlocBuilder<GoalBloc, GoalState>(
          builder: (context, goalsState) {
            return ScrollableColumn(
              /* spacing: 20, */
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CheckboxMenuButton(
                        value: includeDoneTasks,
                        onChanged: (value) {
                          setState(() {
                            includeDoneTasks = value!;
                          });
                        },
                        child: Text('Done tasks'),
                      ),
                      /*  CheckboxListTile(
                        value: true,
                        onChanged: (value) {},
                        title: Text('Done tasks'),
                      ), */
                      SortList(
                        onChange: (newSortType, newSortOrder) {
                          setState(() {
                            selectedSortType = newSortType;
                            selectedSortOrder = newSortOrder;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                /* const Divider(
                  color: Colors.grey,
                ), */
                const SizedBox(
                  height: 20,
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: selectedSortType == SortTypes.date
                      ? DateSortedTaskList(
                          key: ValueKey<SortTypes>(SortTypes.date),
                          sortingOrder: selectedSortOrder,
                          includeDoneTasks: includeDoneTasks,
                          taskState: taskState,
                        )
                      : selectedSortType == SortTypes.goal
                          ? GoalSortedTaskList(
                              sortOrdering: selectedSortOrder,
                              includeDoneTasks: includeDoneTasks,
                              goalState: goalsState,
                            )
                          : PrioritySortedTaskList(),
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
