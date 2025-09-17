import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../../core/data/models/goal_model.dart';
import '../../pages/goal_details.dart';

class FeaturedGoalCard extends StatelessWidget {
  final GoalModel goal;
  const FeaturedGoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    // This is essentially your ThematicGoalCard, perhaps slightly larger.
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GoalDetailsPage(goalId: goal.id!))),
      child: Card(
        elevation: 6.0,
        shadowColor: goal.color.withOpacityDouble(0.3),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [goal.color.withOpacityDouble(0.8), goal.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                right: -25,
                bottom: -25,
                child: Icon(
                  goal.icon,
                  size: 140.0,
                  color: Colors.white.withOpacityDouble(0.15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: LinearProgressIndicator(
                        value: goal.progress,
                        minHeight: 8.0,
                        backgroundColor: Colors.white.withOpacityDouble(0.2),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
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
