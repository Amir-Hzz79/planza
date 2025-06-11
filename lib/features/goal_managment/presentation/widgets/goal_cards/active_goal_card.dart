import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../../core/data/models/goal_model.dart';
import '../../pages/goal_details.dart';

class ActiveGoalCard extends StatelessWidget {
  final GoalModel goal;
  const ActiveGoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = goal.progress;
    final int completedTasks = goal.tasks.where((t) => t.isCompleted).length;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        /* side:
            BorderSide(color: theme.colorScheme.outline.withOpacityDouble(0.2)), */
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GoalDetailsPage(goalId: goal.id!))),
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        goal.color.withOpacityDouble(0.15),
                        goal.color.withOpacityDouble(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -15,
                bottom: -15,
                child: Icon(/* goal.icon */ Icons.fitness_center_rounded,
                    size: 80, color: goal.color.withOpacityDouble(0.1)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fitness_center_rounded,
                            color: goal.color, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            goal.name,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 10,
                              color: goal.color,
                              backgroundColor:
                                  goal.color.withOpacityDouble(0.2),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "$completedTasks / ${goal.tasks.length}",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
