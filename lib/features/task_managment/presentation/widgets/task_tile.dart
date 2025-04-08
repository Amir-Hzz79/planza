import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/features/task_managment/bloc/task_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onCompleteStatusChanged});

  final TaskModel task;
  final void Function(bool?)? onCompleteStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        leading: Checkbox(
          value: task.isCompleted,
          activeColor: task.goal?.color,
          onChanged: (value) {
            task.isCompleted = value!;
            context.read<TaskBloc>().add(TaskUpdatedEvent(newTask: task));

            onCompleteStatusChanged?.call(value);
          },
        ),
        title: Text(task.title),
        subtitle: task.description != null ? Text(task.description!) : null,
        trailing: task.dueDate != null
            ? Text(
                task.dueDate!.formatShortDate(),
                style: TextStyle(
                  color: task.dueDate?.isBeforeToday() ?? false
                      ? Theme.of(context).colorScheme.error
                      : null,
                ),
              )
            : null,
      ),
    );
  }
}
