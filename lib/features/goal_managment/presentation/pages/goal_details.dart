import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/widgets/buttons/circle_back_button.dart';

class GoalDetails extends StatelessWidget {
  const GoalDetails({
    super.key,
    required this.goal,
  });

  final GoalModel goal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleBackButton(),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: goal.color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            goal.name,
            style: TextStyle(
              color: goal.color.computeLuminance() < 5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
