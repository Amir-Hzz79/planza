import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';

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
            color: Colors.grey[200],
            gradient: LinearGradient(
              /* end: Alignment.topCenter, */
              /* begin: Alignment.bottomCenter, */
              colors: [
                Colors.grey[200]!,
                Colors.grey[300]!,
              ],
            ),
            /* boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                spreadRadius: 2,
                blurStyle: BlurStyle.inner,
                blurRadius: 5,
              ),
            ], */
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
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          maxRadius: spacing * 2.5,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
