import 'package:flutter/material.dart';
import 'package:planza/core/utils/app_date_formatter.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../../core/data/models/goal_model.dart';
import '../../../../../core/locale/app_localizations.dart';
import '../../pages/achievement_details_page.dart';

class CompletedGoalCard extends StatelessWidget {
  final GoalModel goal;
  const CompletedGoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;
    final theme = Theme.of(context);
    final int taskCount = goal.tasks.length;
    final int duration = goal.durationInDays;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AchievementDetailsPage(goal: goal),
        ));
      },
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.amber.shade300, width: 2),
        ),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                theme.colorScheme.surface.withOpacityDouble(1.0),
                theme.colorScheme.surface.withOpacityDouble(0.9),
              ],
              center: Alignment.center,
              radius: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lang.general_achievement,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade600,
                    letterSpacing: 1.5,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  goal.name,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      lang.goalCard_taskCount(taskCount),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.timer_outlined,
                        color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      lang.general_duration_day(duration),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if (goal.completedDate != null)
                  Text(
                    "Completed on ${AppDateFormatter.of(context).formatFullDate(goal.completedDate!)}",
                    style:
                        theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
