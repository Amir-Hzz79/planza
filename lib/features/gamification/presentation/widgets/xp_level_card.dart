import 'package:flutter/material.dart';
import 'package:planza/core/data/models/user_stats_model.dart';
import 'package:planza/core/design/composites/progress_ring.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class XpLevelCard extends StatelessWidget {
  final UserStatsModel stats;

  const XpLevelCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.lg),
      child: Column(
        children: [
          // Level & Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Level ${stats.level}',
                style: PlTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: PlSpacing.md),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: PlSpacing.md, vertical: PlSpacing.xs),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: PlSpacing.borderRadiusFull,
                ),
                child: Text(
                  stats.levelTitle,
                  style: PlTypography.labelLarge.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: PlSpacing.lg),

          // XP Progress Ring
          Stack(
            alignment: Alignment.center,
            children: [
              ProgressRing(
                progress: stats.levelProgress,
                size: 140,
                strokeWidth: 12,
                progressColor: colorScheme.primary,
                backgroundColor: colorScheme.surfaceContainerHighest,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${stats.xpProgressInCurrentLevel}',
                    style: PlTypography.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/ ${stats.xpNeededForNextLevel} XP',
                    style: PlTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: PlSpacing.lg),

          // XP Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total XP: ${stats.xp}',
                    style: PlTypography.titleMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Next level at ${stats.xpForNextLevel} XP',
                    style: PlTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: PlSpacing.sm),
              SizedBox(
                height: 8,
                child: ClipRRect(
                  borderRadius: PlSpacing.borderRadiusFull,
                  child: LinearProgressIndicator(
                    value: stats.levelProgress,
                    minHeight: 8,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: PlSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level ${stats.level} (${stats.xpForCurrentLevel} XP)',
                    style: PlTypography.bodySmall.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  Text(
                    'Level ${stats.level + 1} (${stats.xpForNextLevel} XP)',
                    style: PlTypography.bodySmall.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}