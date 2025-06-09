import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Assuming you have these models from our previous discussions
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback? onTap;
  final ValueChanged<bool?>? onStatusChanged;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    // --- Calculations for Progress ---
    final int totalTasks = goal.tasks.length;
    final int completedTasks = goal.tasks.where((task) => task.isCompleted).length;
    final double progress = totalTasks > 0 ? completedTasks / totalTasks : 0;

    return Card(
      elevation: 4.0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Row(
          children: [
            // 1. Color Accent Bar
            _buildColorAccent(),
            // 2. Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Header: Title and Checkbox --
                    _buildHeader(context),
                    const SizedBox(height: 16.0),
                    // -- Progress Indicator --
                    _buildProgressIndicator(context, progress, completedTasks, totalTasks),
                    const SizedBox(height: 16.0),
                    // -- Footer: Deadline and Description --
                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDER HELPERS ---

  Widget _buildColorAccent() {
    return Container(
      width: 6.0,
      height: 120.0, // Adjust height as needed or leave null to expand
      decoration: BoxDecoration(
        color: goal.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            goal.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(width: 8),
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: goal.isCompleted,
            onChanged: onStatusChanged,
            shape: const CircleBorder(),
            activeColor: goal.color,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(BuildContext context, double progress, int completedTasks, int totalTasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8.0,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(goal.color),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          totalTasks > 0 ? "$completedTasks of $totalTasks tasks" : "No tasks yet",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final deadlineInfo = _getDeadlineInfo(goal.deadline);
    
    return Row(
      children: [
        // -- Deadline Info --
        if (goal.deadline != null)
          Icon(
            Icons.calendar_today_outlined,
            size: 16.0,
            color: deadlineInfo.color,
          ),
        if (goal.deadline != null) const SizedBox(width: 6.0),
        if (goal.deadline != null)
          Text(
            deadlineInfo.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: deadlineInfo.color,
                  fontWeight: FontWeight.w500,
                ),
          ),
        // -- Description Snippet --
        if (goal.description?.isNotEmpty ?? false) Expanded(
          child: Text(
            " - ${goal.description!}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic
            )
          ),
        ),
      ],
    );
  }

  // --- HELPER LOGIC ---

  ({String text, Color color}) _getDeadlineInfo(DateTime? deadline) {
    if (deadline == null) {
      return (text: '', color: Colors.grey);
    }
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);
    final difference = deadlineDate.difference(today).inDays;
    
    if (difference < 0) {
      return (text: "Overdue", color: Colors.red.shade700);
    }
    if (difference == 0) {
      return (text: "Due today", color: Colors.orange.shade800);
    }
    if (difference == 1) {
      return (text: "Due tomorrow", color: Colors.orange.shade800);
    }
    return (text: "Due in $difference days", color: Colors.green.shade800);
  }
}