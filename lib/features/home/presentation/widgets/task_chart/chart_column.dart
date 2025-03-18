import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/features/goal_managment/presentation/pages/goal_details.dart';

import 'chart_slice.dart';

class ChartColumn extends StatelessWidget {
  const ChartColumn({
    super.key,
    required this.height,
    /* required this.width, */
    required this.text,
    required this.goals,
    required this.spacing,
  });

  final double height;
  /*  final double width; */
  final double spacing;
  final String text;
  final List<GoalModel> goals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int totalTaskCount = 0;
    for (var goal in goals) {
      totalTaskCount += goal.tasks.length;
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: spacing),
          decoration: BoxDecoration(
            color: theme.colorScheme.onInverseSurface,
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.onInverseSurface,
                theme.colorScheme.onInverseSurface.withAlpha(128),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              goals.length,
              (index) {
                int goalTaskCount =
                    goals[index].tasks.isEmpty ? 1 : goals[index].tasks.length;

                double columnHeight = (height * goalTaskCount) / totalTaskCount;

                return ChartSlice(
                  color: goals[index].color,
                  height: columnHeight,
                  bottomRadius: index == goals.length - 1,
                  topRadius: index == 0,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GoalDetails(goal: goals[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          backgroundColor: theme.colorScheme.onInverseSurface,
          maxRadius: spacing * 2.5,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                /* fontWeight: FontWeight.bold, */
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
