import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';

import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/date_picker/date_picker.dart';
import '../../../../core/widgets/scrollables/scrollable_row.dart';
import '../../../../core/widgets/text_fields/removable_text_field.dart';
import 'goal_selection.dart';

class AddTaskFields extends StatefulWidget {
  const AddTaskFields({
    super.key,
    required this.onSubmit,
    this.showDatePicker = true,
    this.showGoalPicker = true,
  });

  final bool showDatePicker;
  final bool showGoalPicker;
  final void Function(TaskModel newTask) onSubmit;

  @override
  State<AddTaskFields> createState() => _AddTaskFieldsState();
}

class _AddTaskFieldsState extends State<AddTaskFields> {
  void submitTask(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    /* Navigator.pop(context); */

    TaskModel task = TaskModel(
      title: _titleController.text,
      dueDate: selectedDateTime,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      goal: selectedGoal,
    );

    widget.onSubmit.call(task);
    /* context.read<TaskBloc>().add(TaskAddedEvent(newTask: task)); */
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
        spacing: 15,
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
          ScrollableRow(
            spacing: 10,
            children: [
              if (widget.showGoalPicker)
                GoalSelection(
                  iconMode: true,
                  onChanged: (selectedGoal) {
                    this.selectedGoal = selectedGoal;
                  },
                ),
              if (widget.showDatePicker)
                DatePicker(
                  showSelectedDate: false,
                  showIconWhenDateSelected: true,
                  showRemoveIcon: false,
                  onChange: (selectedDate) => selectedDateTime = selectedDate,
                ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    showDescription = !showDescription;
                    _descriptionController.text = '';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: showDescription
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ),
              )
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
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
