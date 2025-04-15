import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';

import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/date_picker/date_picker.dart';
import '../../../../core/widgets/text_fields/removable_text_field.dart';
import '../../bloc/task_bloc.dart';
import 'goal_selection.dart';

class AddTaskFields extends StatefulWidget {
  const AddTaskFields({super.key});

  @override
  State<AddTaskFields> createState() => _AddTaskFieldsState();
}

class _AddTaskFieldsState extends State<AddTaskFields> {
  void submitTask(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(context);

    TaskModel task = TaskModel(
      title: _titleController.text,
      dueDate: selectedDateTime,
      description: _descriptionController.text,
      goal: selectedGoal,
      isCompleted: false,
    );

    context.read<TaskBloc>().add(TaskAddedEvent(newTask: task));
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  GoalModel? selectedGoal;
  DateTime? selectedDateTime;
  bool showDescription = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.translate('add_task'),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              label: Text(
                appLocalizations.translate('title'),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'title can\'t be empty';
              }

              return null;
            },
          ),
          Row(
            spacing: 5,
            children: [
              DatePicker(
                title: appLocalizations.translate('deadline'),
                onChange: (selectedDate) => selectedDateTime = selectedDate,
              ),
              GoalSelection(
                onChanged: (selectedGoal) {
                  this.selectedGoal = selectedGoal;
                },
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    showDescription = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 15,
                      ),
                      Text(
                        appLocalizations.translate('description'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (widget, animation) =>
                FadeTransition(opacity: animation, child: widget),
            child: showDescription
                ? RemovableTextField(
                    key: ValueKey<bool>(showDescription),
                    controller: _descriptionController,
                    hintText: appLocalizations.translate('description'),
                    onRemove: () {
                      setState(() {
                        showDescription = false;
                      });
                    },
                  )
                : null,
          ),
          /* if (showDescription)
            RemovableTextField(
              controller: _descriptionController,
              hintText: appLocalizations.translate('description'),
              onRemove: () {
                setState(() {
                  showDescription = false;
                });
              },
            ), */
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => submitTask(context),
              child: Text(
                appLocalizations.translate('add'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
