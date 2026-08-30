import 'package:flutter/material.dart';
import '../../primitives/index.dart';
import '../../tokens/index.dart';
import '../../../data/models/goal_model.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showProgress;
  final bool compact;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showProgress = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    return PlCard(
      style: PlCardStyle.glass,
      onTap: onTap,
      padding: compact ? PlSpacing.cardPaddingSm : PlSpacing.cardPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(compact ? PlSpacing.xs : PlSpacing.sm),
                decoration: BoxDecoration(
                  color: goal.color.withOpacity(0.15),
                  borderRadius: PlBorderRadius.radiusMd,
                ),
                child: Icon(goal.icon, color: goal.color, size: compact ? 20 : 24),
              ),
              SizedBox(width: PlSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.name,
                      style: PlTypography.titleMedium.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (goal.description != null && !compact) ...[
                      SizedBox(height: PlSpacing.xs),
                      Text(
                        goal.description!,
                        style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (onEdit != null || onDelete != null)
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: colors.onSurfaceVariant),
                  onSelected: (value) {
                    if (value == 'edit') onEdit?.call();
                    if (value == 'delete') onDelete?.call();
                  },
                  itemBuilder: (context) => [
                    if (onEdit != null)
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 18, color: colors.onSurfaceVariant),
                            SizedBox(width: PlSpacing.sm),
                            Text('Edit'),
                          ],
                        ),
                      ),
                    if (onDelete != null)
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: colors.error),
                            SizedBox(width: PlSpacing.sm),
                            Text('Delete', style: TextStyle(color: colors.error)),
                          ],
                        ),
                      ),
                  ],
                ),
            ],
          ),
          if (showProgress && goal.tasks.isNotEmpty && !compact) ...[
            SizedBox(height: PlSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(goal.progress * 100).round()}% complete',
                      style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
                    ),
                    Text(
                      '${goal.tasks.where((t) => t.isCompleted).length}/${goal.tasks.length} tasks',
                      style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
                SizedBox(height: PlSpacing.xs),
                ClipRRect(
                  borderRadius: PlBorderRadius.radiusFull,
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    minHeight: 6,
                    backgroundColor: colors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                    borderRadius: PlBorderRadius.radiusFull,
                  ),
                ),
              ],
            ),
          ],
          if (goal.deadline != null && !compact) ...[
            SizedBox(height: PlSpacing.sm),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: colors.onSurfaceVariant),
                SizedBox(width: PlSpacing.xs),
                Text(
                  _formatDeadline(context, goal.deadline!),
                  style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDeadline(BuildContext context, DateTime deadline) {
    final now = DateTime.now();
    final diff = deadline.difference(now).inDays;
    if (diff < 0) return 'Overdue';
    if (diff == 0) return 'Due today';
    if (diff == 1) return 'Due tomorrow';
    return 'Due in $diff days';
  }
}
