import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../../../../core/widgets/buttons/circle_back_button.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/task_bloc.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);

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
                    title: Text(appLocalization.translate('task.title')),
                    trailing: Text(task.title),
                  ),
                  if (task.dueDate != null)
                    ListTile(
                      leading: Icon(Icons.timelapse_rounded),
                      title: Text(appLocalization.translate('task.dueDate')),
                      trailing: Text(task.dueDate!.formatShortDate()),
                    ),
                  if (task.doneDate != null)
                    ListTile(
                      leading: Icon(Icons.timelapse_rounded),
                      title: Text(appLocalization.translate('task.doneDate')),
                      trailing: Text(task.doneDate!.formatShortDate()),
                    ),
                  ListTile(
                    leading: Icon(Icons.golf_course_rounded),
                    title: Text(appLocalization.translate('goal')),
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
                      title: Text(appLocalization.translate('status')),
                      trailing: Text(
                        task.isCompleted
                            ? task.daysLeft!.isNegative
                                ? appLocalization.translate('overdue_done')
                                : appLocalization.translate('done')
                            : task.daysLeft!.isNegative
                                ? '${task.daysLeft!.abs()} ${appLocalization.translate('days_overdue')}'
                                : '${task.daysLeft} ${appLocalization.translate('days_left')}',
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
