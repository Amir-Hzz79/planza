import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../../../../core/widgets/buttons/circle_back_button.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/task_bloc.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksLoadedState) {
              return ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AppBar(
                      leading: CircleBackButton(),
                      title: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(
                          task.title,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(Icons.title_rounded),
                    title: Text('Title'),
                    trailing: Text(task.title),
                  ),
                  if (task.dueDate != null)
                    ListTile(
                      leading: Icon(Icons.timelapse_rounded),
                      title: Text('DueDate'),
                      trailing: Text(task.dueDate!.formatShortDate()),
                    ),
                  ListTile(
                    leading: Icon(Icons.timelapse_rounded),
                    title: Text('DoneDate'),
                    trailing:
                        Text(task.doneDate?.formatShortDate() ?? 'In progress'),
                  ),
                  ListTile(
                    leading: Icon(Icons.golf_course_rounded),
                    title: Text('Goal'),
                    trailing: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 5,
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: task.goal?.color,
                          ),
                          Text(task.goal?.name ?? ''),
                        ],
                      ),
                    ),
                  ),
                  if (task.dueDate != null)
                    ListTile(
                      leading: Icon(
                        task.daysLeft!.isNegative
                            ? task.isCompleted
                                ? Icons.done_rounded
                                : Icons.warning_rounded
                            : Icons.commit_rounded,
                      ),
                      title: Text('Status'),
                      trailing: Text(
                        task.isCompleted
                            ? task.daysLeft!.isNegative
                                ? 'Overdue Done'
                                : 'Done'
                            : task.daysLeft!.isNegative
                                ? '${task.daysLeft!.abs()} Days Overdue'
                                : '${task.daysLeft} Days Left',
                      ),
                    ),
                ],
              );
            } else {
              return Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
