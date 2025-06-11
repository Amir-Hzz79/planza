import 'package:flutter/material.dart';

// Import your models and page routes
import 'package:planza/core/data/models/goal_model.dart';

import '../../../goal_managment/presentation/pages/goal_details.dart';

class GoalsCarousel extends StatelessWidget {
  final List<GoalModel> goals;
  const GoalsCarousel({super.key, required this.goals});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.88),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            return _FeaturedGoalCard(goal: goals[index]);
          },
        ),
      ),
    );
  }
}

class _FeaturedGoalCard extends StatelessWidget {
  final GoalModel goal;
  const _FeaturedGoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    // This is a larger, more impactful version of your thematic card
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GoalDetailsPage(goalId: goal.id!))),
      child: Card(
        elevation: 6.0,
        shadowColor: goal.color.withOpacity(0.3),
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
                    colors: [goal.color.withOpacity(0.8), goal.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                right: -25,
                bottom: -25,
                child: Icon(Icons.fitness_center_rounded,
                    size: 140.0, color: Colors.white.withOpacity(0.15)),
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
                    if (goal.tasks.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: LinearProgressIndicator(
                          value: goal.progress,
                          minHeight: 8.0,
                          backgroundColor: Colors.white.withOpacity(0.2),
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
