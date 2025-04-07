import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/features/goal_managment/presentation/pages/goal_details.dart';

class GoalCounterItem extends StatelessWidget {
  const GoalCounterItem({super.key, required this.goal, required this.width});

  final GoalModel goal;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GoalDetails(goal: goal),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: width,
              decoration: BoxDecoration(
                color: goal.color,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: (width *
                      goal.tasks
                          .where(
                            (element) => element.isCompleted,
                          )
                          .length) /
                  goal.tasks.length,
              decoration: BoxDecoration(
                color: goal.color.withLightness(-0.1),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Positioned(
              top: 5,
              bottom: 5,
              left: 10,
              right: 5,
              child: SizedBox(
                //color: Colors.red.withOpacity(0.3),
                width: width - 15,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 70,
                      child: Text(
                        goal.name,
                        style: TextStyle(
                          color: goal.color.matchTextColor(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor: goal.color,
                        child: Text('${goal.tasks.length}'),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
