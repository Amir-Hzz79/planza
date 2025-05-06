import 'package:flutter/material.dart';

import '../widgets/goal_counter/goal_counter_section.dart';
import '../widgets/task_chart/task_chart.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        GoalCounterSection(),
        TaskChart(),
      ],
    );
  }
}
