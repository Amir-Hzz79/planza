import 'package:flutter/material.dart';
import 'package:planza/core/data/models/user_stats_model.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class StatsGrid extends StatelessWidget {
  final UserStatsModel stats;

  const StatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final statItems = [
      _StatItem(
        label: 'Tasks Completed',
        value: stats.totalTasksCompleted.toString(),
        icon: Icons.check_circle,
        color: Colors.green,
      ),
      _StatItem(
        label: 'Goals Completed',
        value: stats.totalGoalsCompleted.toString(),
        icon: Icons.flag,
        color: Colors.blue,
      ),
      _StatItem(
        label: 'Templates Created',
        value: stats.totalTemplatesCreated.toString(),
        icon: Icons.description,
        color: Colors.purple,
      ),
      _StatItem(
        label: 'Current Streak',
        value: '${stats.currentStreak} days',
        icon: Icons.local_fire_department,
        color: Colors.orange,
      ),
      _StatItem(
        label: 'Longest Streak',
        value: '${stats.longestStreak} days',
        icon: Icons.emoji_events,
        color: Colors.amber,
      ),
      _StatItem(
        label: 'Unlockables',
        value: '${stats.unlockedThemes.length + stats.unlockedIcons.length + stats.unlockedAnimations.length}',
        icon: Icons.lock_open,
        color: Colors.pink,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: PlTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: PlSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: PlSpacing.md,
            mainAxisSpacing: PlSpacing.md,
            childAspectRatio: 1.3,
          ),
          itemCount: statItems.length,
          itemBuilder: (context, index) {
            final item = statItems[index];
            return PlCard(
              padding: const EdgeInsets.all(PlSpacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: item.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: PlSpacing.sm),
                  Text(
                    item.value,
                    style: PlTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: PlSpacing.xs),
                  Text(
                    item.label,
                    style: PlTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}