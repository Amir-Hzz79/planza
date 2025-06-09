import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../models/goal_model.dart';
import '../../models/task_model.dart';
import 'goal_bloc.dart';

class GoalBlocBuilder extends StatelessWidget {
  const GoalBlocBuilder({super.key, required this.onDataLoaded});

  final Widget Function(List<GoalModel> goals) onDataLoaded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, state) {
        List<GoalModel> goals = state is GoalsLoadedState
            ? state.goals
            : List.generate(
                8,
                (index) => GoalModel(
                  id: index,
                  color: Colors.grey,
                  name: 'place holder',
                  tasks: [
                    TaskModel(
                      id: index,
                      title: 'place holder',
                      dueDate: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                    ),
                    TaskModel(
                      id: index,
                      title: 'place holder',
                      dueDate: DateTime.now()
                          .subtract(Duration(days: 5))
                          .add(Duration(days: index)),
                    ),
                  ],
                ),
              );

        return Skeletonizer(
          enabled: state is! GoalsLoadedState /* true */,
          child: onDataLoaded.call(goals),
        );
      },
    );
  }
}
