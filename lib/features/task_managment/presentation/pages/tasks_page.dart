import 'package:flutter/material.dart';
import 'package:planza/features/task_managment/presentation/widgets/date_sorted_task_list.dart';
import 'package:planza/features/task_managment/presentation/widgets/goal_sorted_task_list.dart';
import 'package:planza/features/task_managment/presentation/widgets/sort_list.dart';

import '../../../../core/constants/sort_ordering.dart';

import '../../../../core/widgets/scrollables/scrollable_column.dart';
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
    return ScrollableColumn(
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
              SortOptions(
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
        const SizedBox(
          height: 20,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: selectedSortType == SortTypes.date
              ? DateSortedTaskList(
                  key: ValueKey<SortTypes>(SortTypes.date),
                  sortingOrder: selectedSortOrder,
                  includeDoneTasks: includeDoneTasks,
                )
              : selectedSortType == SortTypes.goal
                  ? GoalSortedTaskList(
                      sortOrdering: selectedSortOrder,
                      includeDoneTasks: includeDoneTasks,
                    )
                  : PrioritySortedTaskList(),
        ),
        const SizedBox(
          height: 200,
        ),
      ],
    );
  }
}
