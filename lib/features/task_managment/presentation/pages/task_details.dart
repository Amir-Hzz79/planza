import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/widgets/date_picker/date_picker.dart';
import 'package:planza/core/widgets/text_fields/dynamic_size_text_form_field.dart';
import 'package:planza/features/task_managment/presentation/widgets/goal_selection.dart';

import '../../../../core/widgets/buttons/circle_back_button.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/task_bloc.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

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
                          widget.task.title,
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
                    trailing: widget.task.isCompleted
                        ? Text(widget.task.title)
                        : DynamicSizeTextFormField(
                            titleController: _titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return appLocalization
                                    .translate('title_validator');
                              }

                              return null;
                            },
                            onLeave: (newValue) {
                              print('--------------------newValue:$newValue-----------------------');
                              widget.task.title = newValue!;
                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: widget.task));
                            },
                          ),
                  ),
                  ListTile(
                    leading: Icon(Icons.timelapse_rounded),
                    title: Text(appLocalization.translate('task.dueDate')),
                    trailing: widget.task.isCompleted
                        ? Text(widget.task.dueDate?.formatShortDate() ??
                            appLocalization.translate('no_overdue'))
                        : DatePicker(
                            initialDate: widget.task.dueDate,
                            showRemoveIcon: false,
                            showIconWhenDateSelected: false,
                            onChange: (newDate) {
                              widget.task.dueDate = newDate;
                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: widget.task));
                            },
                          ),
                  ),
                  if (widget.task.doneDate != null)
                    ListTile(
                      leading: Icon(Icons.done_all_rounded),
                      title: Text(appLocalization.translate('task.doneDate')),
                      trailing: Text(widget.task.doneDate!.formatShortDate()),
                    ),
                  ListTile(
                    leading: Icon(Icons.golf_course_rounded),
                    title: Text(appLocalization.translate('goal')),
                    trailing: widget.task.isCompleted
                        ? widget.task.goal == null
                            ? Text(appLocalization.translate('no_goal'))
                            : Row(
                                spacing: 5,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: widget.task.goal!.color,
                                    radius: 5,
                                  ),
                                  Text(
                                    widget.task.goal!.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                        : GoalSelection(
                            initialGoal: widget.task.goal,
                            onChanged: (newGoal) {
                              widget.task.goal = newGoal;
                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: widget.task));
                            },
                          ),
                  ),
                  if (widget.task.dueDate != null)
                    ListTile(
                      leading: Icon(
                        widget.task.daysLeft!.isNegative
                            ? widget.task.isCompleted
                                ? Icons.done_rounded
                                : Icons.warning_rounded
                            : Icons.commit_rounded,
                      ),
                      title: Text(appLocalization.translate('status')),
                      trailing: Text(
                        widget.task.isCompleted
                            ? widget.task.daysLeft!.isNegative
                                ? appLocalization.translate('overdue_done')
                                : appLocalization.translate('done')
                            : widget.task.daysLeft!.isNegative
                                ? '${widget.task.daysLeft!.abs()} ${appLocalization.translate('days_overdue')}'
                                : '${widget.task.daysLeft} ${appLocalization.translate('days_left')}',
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
