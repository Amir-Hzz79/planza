import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/widgets/color_picker/color_picker.dart';
import 'package:planza/core/widgets/date_picker/date_picker.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';
import 'package:planza/features/task_managment/presentation/widgets/add_task_fields.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/widgets/buttons/circle_back_button.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final TextEditingController _titleController = TextEditingController(text: 'New Goal');
  DateTime? selectedDateTime;
  Color selectedColor = Colors.grey;
  final List<TaskModel> tasks = [];

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final GoalModel goal = GoalModel(
      name: _titleController.text,
      completed: false,
      color: selectedColor,
      deadline: selectedDateTime,
      tasks: tasks,
    );

    context.read<GoalBloc>().add(
          GoalAddedEvent(newGoal: goal),
        );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Goal Added Successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ScrollableColumn(
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppBar(
                  leading: CircleBackButton(),
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      _titleController.text,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text(appLocalizations.translate('title')),
                ),
                onChanged: (value) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.translate('title_validator');
                  }

                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.translate('deadline'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DatePicker(
                    onChange: (newDate) {
                      selectedDateTime = newDate;
                    },
                  ),
                ],
              ),
              Align(
                alignment: Directionality.of(context) == TextDirection.ltr
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Text(
                  'Color',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ColorPicker(
                initialColor: Colors.grey,
                onChange: (newColor) {
                  selectedColor = newColor!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.translate('tasks'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        ModalBottomSheetRoute(
                          showDragHandle: true,
                          builder: (context) => IntrinsicHeight(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: AddTaskFields(
                                showGoalPicker: false,
                                onSubmit: (newTask) {
                                  Navigator.pop(context);

                                  setState(() {
                                    tasks.add(newTask);
                                  });
                                },
                              ),
                            ),
                          ),
                          isScrollControlled: true,
                        ),
                      );
                    },
                    label: Text('Add'),
                    icon: Icon(Icons.add_rounded),
                  ),
                ],
              ),
              if (tasks.isNotEmpty)
                Column(
                  spacing: 10,
                  children: List.generate(
                    tasks.length,
                    (index) => ListTile(
                      tileColor: Theme.of(context).colorScheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            tasks.remove(tasks[index]);
                          });
                        },
                        icon: Icon(Icons.close_rounded),
                      ) /* CircleAvatar(radius: 4) */,
                      title: Text(tasks[index].title),
                      subtitle: tasks[index].description == null
                          ? null
                          : Text(tasks[index].description!),
                      trailing:
                          Text(tasks[index].dueDate?.formatShortDate() ?? ''),
                    ),
                  ),
                )
              else
                Text('No Task Added'),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        height: 50,
        child: FilledButton(
          onPressed: _submit,
          child: Text('Add'),
        ),
      ),
    );
  }
}
