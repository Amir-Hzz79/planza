import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/task_model.dart';
import 'task_bloc.dart';

class TaskBlocBuilder extends StatelessWidget {
  const TaskBlocBuilder({
    super.key,
    required this.onDataLoaded,
  });

  final Widget Function(List<TaskModel> tasks) onDataLoaded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<TaskModel> tasks = state is TasksLoadedState
            ? state.tasks
            : List.generate(
                9,
                (index) => TaskModel(
                  id: index,
                  title: 'place holder',
                  dueDate: DateTime.now()
                      .subtract(Duration(days: 4))
                      .add(Duration(days: index)),
                ),
              );

        return Skeletonizer(
          enabled: state is! TasksLoadedState /* true */,
          child: onDataLoaded.call(tasks),
        );
      },
    );
  }
}
