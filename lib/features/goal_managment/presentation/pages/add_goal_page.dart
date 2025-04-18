import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/widgets/color_picker/color_picker.dart';
import 'package:planza/core/widgets/date_picker/date_picker.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';
import 'package:planza/features/goal_managment/bloc/goal_bloc.dart';
import 'package:planza/features/task_managment/bloc/task_bloc.dart';
import 'package:planza/features/task_managment/presentation/widgets/add_task_fields.dart';
import 'package:planza/features/task_managment/presentation/widgets/task_tile.dart';

import '../../../../core/widgets/buttons/circle_back_button.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime? selectedDateTime;
  Color selectedColor = Colors.grey;
  final List<TaskModel> tasks = [];

  void _submit() {
    final GoalModel goal = GoalModel(
      name: _titleController.text,
      completed: false,
      color: selectedColor,
      deadline: selectedDateTime,
    );

    context.read<GoalBloc>().add(
          GoalAddedEvent(newGoal: goal),
        );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
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
                    'Add New Goal',
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                label: Text(appLocalizations.translate('title')),
              ),
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
                selectedColor = newColor;
              },
            ),
            Align(
              alignment: Directionality.of(context) == TextDirection.ltr
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                appLocalizations.translate('deadline'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            DatePicker(
              onChange: (newDate) {
                selectedDateTime = newDate;
              },
            ),
            Align(
              alignment: Directionality.of(context) == TextDirection.ltr
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                appLocalizations.translate('tasks'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (tasks.isNotEmpty)
              Column(
                children: List.generate(
                  tasks.length,
                  (index) => ListTile(
                    title: Text(tasks[index].title),
                    subtitle: tasks[index].description == null
                        ? null
                        : Text(tasks[index].description!),
                    trailing:
                        Text(tasks[index].dueDate?.formatShortDate() ?? ''),
                  ) /* TaskTile(
                    task: tasks[index],
                  ) */
                  ,
                ),
              ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  ModalBottomSheetRoute(
                    showDragHandle: true,
                    builder: (context) => IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
              label: Text('Add Task'),
              icon: Icon(Icons.add_task_rounded),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        height: 50,
        child: FilledButton(
          onPressed: _submit,
          child: Text('Add') /* Icon(Icons.add_task_rounded) */,
        ),
      ),
    );
  }
}
