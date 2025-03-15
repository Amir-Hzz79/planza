import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/features/goal_managment/presentation/pages/goal_details.dart';

class GoalCounterGridItem extends StatelessWidget {
  const GoalCounterGridItem({
    super.key,
    required this.goal,
    required this.counter,
  });

  final GoalModel goal;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GoalDetails(goal: goal),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: goal.color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                goal.name,
                style: TextStyle(
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Text('$counter'),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
