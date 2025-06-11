import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/widgets/date_picker/date_picker.dart';
import 'package:planza/core/widgets/text_fields/dynamic_size_text_form_field.dart';
import 'package:planza/features/task_managment/presentation/widgets/goal_selection.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/widgets/buttons/circle_back_button.dart';
import '../../../../core/widgets/scrollables/scrollable_column.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);

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
            TaskModel task = state is TasksLoadedState
                ? widget.task
                : TaskModel(
                    title: 'place holder',
                    description: 'place holder',
                    dueDate: DateTime.now(),
                    goal: GoalModel(
                      name: 'place holder',
                      color: Colors.grey,
                    ),
                  );

            return Skeletonizer(
              enabled: state is! TasksLoadedState,
              child: ScrollableColumn(
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
                    trailing: task.isCompleted
                        ? Text(task.title)
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
                              task = task.copyWith(title: newValue);

                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: task));
                            },
                          ),
                  ),
                  if (!(task.isCompleted && task.description == null))
                    Dismissible(
                      key: Key(DateTime.now().toString()),
                      onDismissed: (direction) {
                        task = task.copyWith(description: null);
                        context
                            .read<TaskBloc>()
                            .add(TaskUpdatedEvent(newTask: task));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.description_rounded,
                        ),
                        title: Text(appLocalization.translate('description')),
                        trailing: task.isCompleted
                            ? Text(task.description ?? '')
                            : DynamicSizeTextFormField(
                                minWidth: 100,
                                hint: appLocalization.translate('description'),
                                titleController: _descriptionController,
                                onLeave: (newValue) {
                                  task = task.copyWith(
                                      description:
                                          newValue!.isEmpty ? null : newValue);

                                  context
                                      .read<TaskBloc>()
                                      .add(TaskUpdatedEvent(newTask: task));
                                },
                              ),
                      ),
                    ),
                  ListTile(
                    leading: Icon(Icons.golf_course_rounded),
                    title: Text(appLocalization.translate('goal')),
                    trailing: task.isCompleted
                        ? task.goal == null
                            ? Text(appLocalization.translate('no_goal'))
                            : Row(
                                spacing: 5,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: task.goal!.color,
                                    radius: 5,
                                  ),
                                  Text(
                                    task.goal!.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                        : GoalSelection(
                            initialGoal: task.goal,
                            onChanged: (newGoal) {
                              task = task.copyWith(goal: newGoal);
                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: task));
                            },
                          ),
                  ),
                  ListTile(
                    leading: Icon(Icons.timelapse_rounded),
                    title: Text(appLocalization.translate('task.dueDate')),
                    trailing: task.isCompleted
                        ? Text(task.dueDate?.formatShortDate() ??
                            appLocalization.translate('no_overdue'))
                        : DatePicker(
                            initialDate: task.dueDate,
                            showRemoveIcon: false,
                            showIconWhenDateSelected: false,
                            onChange: (newDate) {
                              task = task.copyWith(dueDate: newDate);
                              context
                                  .read<TaskBloc>()
                                  .add(TaskUpdatedEvent(newTask: task));
                            },
                          ),
                  ),
                  if (task.doneDate != null)
                    ListTile(
                      leading: Icon(Icons.done_all_rounded),
                      title: Text(appLocalization.translate('task.doneDate')),
                      trailing: Text(task.doneDate!.formatShortDate()),
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            task.isCompleted
                                ? task.daysLeft!.isNegative
                                    ? appLocalization.translate('overdue_done')
                                    : appLocalization.translate('done')
                                : task.daysLeft!.isNegative
                                    ? '${task.daysLeft!.abs()} ${appLocalization.translate('days_overdue')}'
                                    : '${task.daysLeft} ${appLocalization.translate('days_left')}',
                          ),
                          Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) {
                                task = task.copyWith(
                                    doneDate: value! ? DateTime.now() : null);
                                context
                                    .read<TaskBloc>()
                                    .add(TaskUpdatedEvent(newTask: task));
                              })
                        ],
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: task.tags
                          .map(
                            (tag) => Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.tag_rounded,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  Text(tag.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
