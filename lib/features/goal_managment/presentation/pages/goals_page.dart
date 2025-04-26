import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/goal_bloc.dart';
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
      children: [
        BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state is GoalsLoadedState) {
              return GoalCounterSection(
                goals: state.goals,
              );
            } else if (state is GoalErrorState) {
              return Text('Error: ${state.message}');
            } else {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<GoalBloc, GoalState>(
          builder: (context, state) {
            if (state is GoalsLoadedState) {
              return TaskChart(
                goals: state.goals,
              );
            } else if (state is GoalErrorState) {
              return Text('Error: ${state.message}');
            } else {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
