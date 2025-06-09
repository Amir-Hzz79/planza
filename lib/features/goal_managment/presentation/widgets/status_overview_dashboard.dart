import 'package:flutter/material.dart';

// Import your models and the MetricCard
import 'package:planza/core/data/models/goal_model.dart';
import 'metric_card.dart';

class StatusOverviewDashboard extends StatelessWidget {
  final GoalModel goal;

  const StatusOverviewDashboard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final int totalTasks = goal.tasks.length;
    final int completedTasks = goal.tasks.where((t) => t.isCompleted).length;
    final int remainingTasks = totalTasks - completedTasks;
    final double progress = totalTasks > 0 ? completedTasks / totalTasks : 0;

    final deadlineInfo = _getDeadlineInfo(goal.deadline);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            // Donut Chart Metric
            MetricCard(
              label: "Progress",
              child: _buildDonutChart(context, progress),
            ),
            const SizedBox(width: 12),
            // Tasks Remaining Metric
            MetricCard(
              label: "Tasks Left",
              child: Text(
                remainingTasks.toString(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            // Days Left Metric
            MetricCard(
              label: deadlineInfo.label,
              child: deadlineInfo.isIcon
                  ? Icon(deadlineInfo.icon, size: 40, color: deadlineInfo.color)
                  : Text(
                      deadlineInfo.text,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: deadlineInfo.color,
                          ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChart(BuildContext context, double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: 1.0, // The background track
            strokeWidth: 8,
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
            color: goal.color,
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          "${(progress * 100).toInt()}%",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  ({String text, String label, Color color, IconData? icon, bool isIcon}) _getDeadlineInfo(DateTime? deadline) {
    if (deadline == null) {
      return (text: '-', label: 'No Deadline', color: Colors.grey, icon: null, isIcon: false);
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);
    final difference = deadlineDate.difference(today).inDays;

    if (goal.isCompleted) {
      return (text: 'Done', label: 'Completed', color: Colors.green, icon: Icons.check_circle, isIcon: true);
    }
    if (difference < 0) {
      return (text: "${-difference}", label: 'Days Overdue', color: Colors.red.shade400, icon: null, isIcon: false);
    }
    if (difference == 0) {
      return (text: '!', label: 'Due Today', color: Colors.orange.shade400, icon: null, isIcon: false);
    }
    return (text: "$difference", label: 'Days Left', color: Colors.green.shade700, icon: null, isIcon: false);
  }
}