import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:planza/core/data/models/task_model.dart';

import '../../../../core/locale/app_localizations.dart';
import 'glassy_task_tile.dart';

class GroupedTaskListView extends StatelessWidget {
  final List<TaskModel> tasks;
  const GroupedTaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    final groupedTasks = _groupTasksByDate(tasks);
    if (groupedTasks.isEmpty) {
      return Center(child: Text(lang.tasksPage_grouped_empty));
    }

    final groupKeys = groupedTasks.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: groupKeys.length,
      itemBuilder: (context, index) {
        final groupName = groupKeys[index];
        final tasksInGroup = groupedTasks[groupName]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                groupName,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ),
            ...tasksInGroup.map((task) => GlassyTaskCard(task: task)),
          ],
        );
      },
    );
  }

  Map<String, List<TaskModel>> _groupTasksByDate(List<TaskModel> tasks) {
    final Map<String, List<TaskModel>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    for (final task in tasks.where((t) => !t.isCompleted)) {
      String groupKey;
      if (task.dueDate == null) {
        groupKey = "No Date";
      } else {
        final dueDate = DateTime(
            task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
        if (dueDate.isBefore(today)) {
          groupKey = "Overdue";
        } else if (dueDate == today) {
          groupKey = "Today";
        } else if (dueDate == tomorrow) {
          groupKey = "Tomorrow";
        } else {
          groupKey = DateFormat.MMMMd().format(dueDate);
        }
      }
      grouped.putIfAbsent(groupKey, () => []).add(task);
    }

    // Custom sort order for groups
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        const order = {"Overdue": 0, "Today": 1, "Tomorrow": 2};
        return (order[a] ?? 99).compareTo(order[b] ?? 99);
      });

    return {for (var key in sortedKeys) key: grouped[key]!};
  }
}
