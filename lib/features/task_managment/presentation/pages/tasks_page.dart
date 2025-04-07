import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/models/task_model.dart';
import '../../../../core/locale/app_localization.dart';
import '../../bloc/task_bloc.dart';
import '../widgets/task_tile.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state is TasksLoadedState) {
        final List<TaskModel> selectedDayTasks =
            state.filterOnDate(selectedDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EasyDateTimeLinePicker(
              focusedDate: selectedDate,
              firstDate: DateTime(DateTime.now().year, 1, 1),
              lastDate: DateTime(DateTime.now().year, 12, 31),
              onDateChange: (date) {
                setState(
                  () {
                    selectedDate = date;
                  },
                );
              },
              selectionMode: SelectionMode.autoCenter(),
              ignoreUserInteractionOnAnimating: true,
              locale: AppLocalizations.of(context).locale,
            ),
            const SizedBox(
              height: 20,
            ),
            ...List<Widget>.generate(
              selectedDayTasks.length,
              (index) => TaskTile(
                task: selectedDayTasks[index],
              ),
            ),
            const SizedBox(
              height: 1000,
            ),
          ],
        );
      } else {
        return Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(25),
          ),
        );
      }
    });
  }
}
