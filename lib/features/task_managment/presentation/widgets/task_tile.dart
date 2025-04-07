import 'package:flutter/material.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {},
      ),
      title: Text(task.title),
      subtitle: task.description != null ? Text(task.description!) : null,
      trailing:
          task.dueDate != null ? Text(task.dueDate!.formatShortDate()) : null,
    );
  }
}
