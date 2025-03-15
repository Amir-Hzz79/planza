import 'package:flutter/material.dart';
import 'package:planza/features/home/presentation/widgets/goal_counter/goal_counter_grid_item.dart';

class GoalCounterGrid extends StatelessWidget {
  const GoalCounterGrid({super.key, required this.taskCounters});

  final List<GoalCounterGridItem> taskCounters;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: false,
      children: taskCounters,
    );
  }
}
