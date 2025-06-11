import 'package:flutter/material.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import '../widgets/thematic_goal_card.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return GoalBlocBuilder(onDataLoaded: (goals) {
      return TaskBlocBuilder(
        onDataLoaded: (tasks) => Column(
          children: [
            ...goals.map(
              (goal) => ThematicGoalCard(
                goal: goal,
              ),
            ),
          ],
        ),
      );
    });
  }
}
