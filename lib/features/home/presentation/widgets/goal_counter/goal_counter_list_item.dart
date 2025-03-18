import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/features/goal_managment/presentation/pages/goal_details.dart';

class GoalCounterListItem extends StatelessWidget {
  const GoalCounterListItem(
      {super.key, required this.goal, required this.width});

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
                    /* SizedBox(
                      width: 15,
                    ), */
                    Expanded(
                      flex: 3,
                      child: Text(
                        goal.name,
                        style: TextStyle(
                          color: goal.color.matchTextColor(),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    /* SizedBox(
                      width: 15,
                    ), */
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        foregroundColor: goal.color,
                        child: Text('${goal.tasks.length}'),
                      ),
                    ),
                    /* SizedBox(
                      width: 5,
                    ), */
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
