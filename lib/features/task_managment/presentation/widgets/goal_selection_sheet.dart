import 'package:flutter/material.dart';

import '../../../../core/data/models/goal_model.dart';

class GoalSelectionSheet extends StatelessWidget {
  final List<GoalModel> allGoals;
  final GoalModel? initialGoal;
  const GoalSelectionSheet(
      {super.key, required this.allGoals, this.initialGoal});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          ListTile(
            title: const Text("No Goal",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => Navigator.of(context)
                .pop(null), 
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: allGoals.length,
              itemBuilder: (context, index) {
                final goal = allGoals[index];
                return ListTile(
                  title: Text(goal.name),
                  leading: Icon(/* goal.icon */ Icons.fitness_center_rounded,
                      color: goal.color),
                  onTap: () => Navigator.of(context).pop(goal),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
