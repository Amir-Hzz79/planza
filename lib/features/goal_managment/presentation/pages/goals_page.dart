import 'package:flutter/material.dart';
import 'package:planza/features/goal_managment/presentation/widgets/goal_card.dart';

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
      for (var goal in goals) {
        print(goal.tasks.length);
        print('----');
      }
      return Column(
        /* spacing: 20, */
        children: [
          ...goals.map(
            (goal) => ThematicGoalCard(
              goal: goal,
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ], /* [
            GoalCounterSection(),
            TaskChart(),
          ], */
      );
    });
  }
}
