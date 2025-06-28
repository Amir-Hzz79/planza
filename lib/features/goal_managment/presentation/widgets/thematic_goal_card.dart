import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/locale/app_localizations.dart';
import '../pages/goal_details.dart';

class ThematicGoalCard extends StatelessWidget {
  final GoalModel goal;
  final bool previewMode;

  const ThematicGoalCard({
    super.key,
    required this.goal,
    this.previewMode = false,
  });

  @override
  Widget build(BuildContext context) {
    // --- Calculations for Progress ---
    final int totalTasks = goal.tasks.length;
    final int completedTasks =
        goal.tasks.where((task) => task.isCompleted).length;
    final double progress = totalTasks > 0 ? completedTasks / totalTasks : 0;
    final bool isCompleted = goal.isCompleted;

    return Card(
      elevation: 6.0,
      shadowColor: goal.color.withOpacityDouble(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      // ClipRRect ensures the gradient and icons are contained within the card's rounded corners.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: previewMode
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GoalDetailsPage(goalId: goal.id!),
                    ),
                  );
                },
          child: Stack(
            children: [
              // Layer 1: The Gradient Background
              _buildGradientBackground(),
              // Layer 2: The large, faded background Icon
              _buildBackgroundIcon(),
              // Layer 3: The main information overlay
              _buildInfoOverlay(context, completedTasks, totalTasks, progress),
              // Layer 4: A "Completed" overlay that shows when the goal is done
              if (isCompleted && !previewMode && goal.tasks.isNotEmpty)
                _buildCompletedOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- STACK LAYERS AND HELPERS ---

  Widget _buildGradientBackground() {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [goal.color.withOpacityDouble(0.8), goal.color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildBackgroundIcon() {
    return Positioned(
      right: -25,
      bottom: -25,
      child: Icon(
        Icons.fitness_center_rounded,
        size: 140.0,
        color: Colors.white.withOpacityDouble(0.15),
      ),
    );
  }

  Widget _buildInfoOverlay(
      BuildContext context, int completed, int total, double progress) {
    final Lang lang = Lang.of(context)!;

    return Container(
      height: 150.0,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Top Section: Goal Name --
          Text(
            goal.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          // -- Bottom Section: Progress Text and Bar --
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                total > 0
                    ? lang.goalCard_tasksProgress(completed, total)
                    : lang.goalCard_noTasks,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacityDouble(0.9),
                    ),
              ),
              const SizedBox(height: 8.0),
              _buildProgressBar(progress),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 6.0,
        backgroundColor: Colors.white.withOpacityDouble(0.2),
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildCompletedOverlay(BuildContext context) {
    final Lang lang = Lang.of(context)!;

    // This widget covers the entire card when the goal is completed.
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
          color: Colors.black.withOpacityDouble(0.4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 48),
                const SizedBox(height: 8),
                Text(
                  lang.goalCard_completed_title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
