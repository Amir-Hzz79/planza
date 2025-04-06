import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/features/task_managment/bloc/task_bloc.dart';
import 'package:planza/features/task_managment/bloc/task_event.dart';

import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/date_picker/date_picker.dart';
import 'goal_selection.dart';

class AddTaskFields extends StatefulWidget {
  const AddTaskFields({super.key});

  @override
  State<AddTaskFields> createState() => _AddTaskFieldsState();
}

class _AddTaskFieldsState extends State<AddTaskFields> {
  void submitTask(BuildContext context) {
    TaskModel task = TaskModel(
      title: _titleController.text,
      description: _descriptionController.text,
      goal: selectedGoal,
      isCompleted: false,
    );

    context.read<TaskBloc>().add(TaskSubmittedEvent(task: task));

    Navigator.pop(context);
  }

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  GoalModel? selectedGoal;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Form(
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
            },
          ),
          DatePicker(
            title: appLocalizations.translate('deadline'),
          ),
          GoalSelection(
            onChanged: (selectedGoal) {
              this.selectedGoal = selectedGoal;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              label: Text(
                appLocalizations.translate('description'),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => submitTask(context),
              child: Text(
                appLocalizations.translate('add'),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
