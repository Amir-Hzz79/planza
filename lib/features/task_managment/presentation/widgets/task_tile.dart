import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/features/task_managment/presentation/pages/task_details.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onStatusChanged});

  final TaskModel task;
  final void Function(bool?)? onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Stack(
        children: [
          if (task.isCompleted)
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Divider(
                indent: 20,
                endIndent: 20,
              ),
            ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TaskDetails(task: task),
                ),
              );
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Task'),
                    content: Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<TaskBloc>()
                              .add(TaskDeletedEvent(task: task));
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Checkbox(
                value: task.isCompleted,
                activeColor: task.goal?.color,
                onChanged: (value) {
                  context.read<TaskBloc>().add(
                        TaskUpdatedEvent(
                          newTask: task.copyWith(
                            doneDate: value! ? DateTime.now() : null,
                          ),
                        ),
                      );

                  onStatusChanged?.call(value);
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: task.goal?.color ?? Colors.grey,
                    radius: 5,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              /* subtitle: task.description != null ? Text(task.description!) : null, */
              trailing: task.dueDate != null
                  ? Text(
                      task.dueDate!.formatShortDate(),
                      style: TextStyle(
                        color: task.isOverdue
                            ? Theme.of(context).colorScheme.error
                            : null,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
