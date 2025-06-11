import 'package:flutter/material.dart';
import 'package:planza/core/constants/sort_ordering.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';
import 'package:planza/features/task_managment/presentation/widgets/glassy_task_tile.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';

class DateSortedTaskList extends StatefulWidget {
  const DateSortedTaskList({
    super.key,
    required this.sortingOrder,
    required this.includeDoneTasks,
  });

  final SortOrdering sortingOrder;
  final bool includeDoneTasks;

  @override
  State<DateSortedTaskList> createState() => _DateSortedTaskListState();
}

class _DateSortedTaskListState extends State<DateSortedTaskList> {
  DateTime selectedDate = DateTime.now();

  bool pastExpanded = true;
  bool todayExpanded = true;
  bool futureExpanded = true;
  bool recentCompletedExpand = true;

  final Duration recentDuration = Duration(days: 7);

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);

    return TaskBlocBuilder(
      onDataLoaded: (tasks) {
        tasks.sort(
          (a, b) => widget.sortingOrder == SortOrdering.ascending
              ? (a.dueDate?.isAfter(b.dueDate ?? DateTime(2000)) ?? false
                  ? 1
                  : -1)
              : (a.dueDate?.isBefore(b.dueDate ?? DateTime(2000)) ?? false
                  ? 1
                  : -1),
        );
        if (!widget.includeDoneTasks) {
          tasks = tasks.incompleteTasks;
        }

        final List<TaskModel> noDueDateTasks = tasks.noDueDateTasks;
        final List<TaskModel> pastTasks = tasks.overdueTasks.incompleteTasks;
        final List<TaskModel> todayTasks = tasks.tasksDueToday.incompleteTasks;
        final List<TaskModel> futureTasks = tasks.upcomingTasks.incompleteTasks;
        final List<TaskModel> recentCompletedTasks =
            tasks.recentTasks(recentDuration).completedTasks;

        final List<Widget> children = [
          if (noDueDateTasks.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(
                  begin: 0, end: noDueDateTasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  appLocalization.translate('no_dueDate'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                children: List.generate(
                  noDueDateTasks.length,
                  (index) => GlassyTaskCard(task: noDueDateTasks[index]),
                ),
              ),
            ),
          if (pastTasks.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: pastTasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  appLocalization.translate('past'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                children: List.generate(
                  pastTasks.length,
                  (index) => GlassyTaskCard(task: pastTasks[index]),
                ),
              ),
            ),
          if (todayTasks.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween:
                  Tween<double>(begin: 0, end: todayTasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  appLocalization.translate('today'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                children: List.generate(
                  todayTasks.length,
                  (index) => GlassyTaskCard(task: todayTasks[index]),
                ),
              ),
            ),
          if (futureTasks.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween:
                  Tween<double>(begin: 0, end: futureTasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  appLocalization.translate('future'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                children: List.generate(
                  futureTasks.length,
                  (index) => GlassyTaskCard(task: futureTasks[index]),
                ),
              ),
            ),
          if (recentCompletedTasks.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(
                  begin: 0, end: recentCompletedTasks.isNotEmpty ? 1 : 0),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  appLocalization.translate('recent_done_tasks'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                children: List.generate(
                  recentCompletedTasks.length,
                  (index) => GlassyTaskCard(task: recentCompletedTasks[index]),
                ),
              ),
            ),
        ];

        return ScrollableColumn(
          spacing: 10,
          children: widget.sortingOrder == SortOrdering.ascending
              ? children
              : children.reversed.toList(),
        );
      },
    );
  }
}
