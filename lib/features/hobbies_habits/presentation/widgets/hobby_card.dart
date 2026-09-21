import 'package:flutter/material.dart';
import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/core/utils/recurrence_engine.dart';

class HobbyCard extends StatelessWidget {
  final HobbyModel hobby;
  final VoidCallback? onTap;
  final VoidCallback? onStartSession;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const HobbyCard({
    super.key,
    required this.hobby,
    this.onTap,
    this.onStartSession,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color hobbyColor = hobby.color != null
        ? Color(hobby.color!)
        : colorScheme.primary;
    final IconData hobbyIcon = hobby.icon != null
        ? IconData(hobby.icon!)
        : Icons.track_changes;

    return PlCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: hobbyColor.withValues(alpha: 0.15),
              borderRadius: PlSpacing.topRadiusMd,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    hobbyIcon,
                    size: 48,
                    color: hobbyColor,
                  ),
                ),
                Positioned(
                  top: PlSpacing.sm,
                  right: PlSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.9),
                      borderRadius: PlSpacing.borderRadiusSm,
                    ),
                    child: Text(
                      RecurrenceEngine.frequencyToString(
                          hobby.frequency, hobby.customFrequencyJson),
                      style: PlTypography.labelSmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(PlSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hobby.name,
                  style: PlTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (hobby.description != null &&
                    hobby.description!.isNotEmpty) ...[
                  const SizedBox(height: PlSpacing.xs),
                  Text(
                    hobby.description!,
                    style: PlTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: PlSpacing.md),
                Row(
                  children: [
                    if (hobby.targetDurationMinutes != null) ...[
                      Icon(Icons.timer,
                          size: 16, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: PlSpacing.xs),
                      Text(
                        '${hobby.targetDurationMinutes} min',
                        style: PlTypography.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (hobby.targetDurationMinutes != null &&
                        hobby.goalId != null)
                      const SizedBox(width: PlSpacing.md),
                    if (hobby.goalId != null) ...[
                      Icon(Icons.flag, size: 16, color: colorScheme.primary),
                      const SizedBox(width: PlSpacing.xs),
                      Text(
                        'Goal #${hobby.goalId}',
                        style: PlTypography.bodySmall.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: PlSpacing.md),
                Row(
                  children: [
                    if (hobby.isActive) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onStartSession ?? () {},
                          icon: const Icon(Icons.play_arrow, size: 18),
                          label: const Text('Start'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: PlSpacing.sm),
                          ),
                        ),
                      ),
                      if (onEdit != null || onDelete != null)
                        const SizedBox(width: PlSpacing.sm),
                    ],
                    if (onEdit != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onEdit,
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: PlSpacing.sm),
                          ),
                        ),
                      ),
                    if (onDelete != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text('Delete'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: PlSpacing.sm),
                            foregroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
