import 'package:flutter/material.dart';
import '../../primitives/index.dart';
import '../../tokens/index.dart';
import '../../../data/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showGoal;
  final bool showTags;
  final bool compact;

  const TaskTile({
    super.key,
    required this.task,
    this.onTap,
    this.onToggle,
    this.onEdit,
    this.onDelete,
    this.showGoal = true,
    this.showTags = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    return PlCard(
      style: PlCardStyle.outlined,
      onTap: onTap,
      padding: compact ? PlSpacing.listItemPaddingSm : PlSpacing.listItemPadding,
      margin: const EdgeInsets.only(bottom: PlSpacing.xs),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: PlMotion.fast,
              curve: PlMotion.standard,
              width: compact ? 20 : 24,
              height: compact ? 20 : 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: task.isCompleted
                      ? colors.success
                      : (task.priority != null ? _priorityColor(task.priority!, colors) : colors.outline),
                  width: 2,
                ),
                color: task.isCompleted ? colors.success : Colors.transparent,
              ),
              child: task.isCompleted
                  ? Icon(Icons.check, size: compact ? 12 : 16, color: colors.onBackground)
                  : null,
            ),
          ),
          SizedBox(width: PlSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: (compact ? PlTypography.bodyMedium : PlTypography.bodyLarge).copyWith(
                          color: task.isCompleted ? colors.onSurfaceVariant : colors.onSurface,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (task.priority != null && !compact)
                      PriorityBadge(priority: task.priority!),
                  ],
                ),
                if (task.description != null && task.description!.isNotEmpty && !compact) ...[
                  SizedBox(height: PlSpacing.xs),
                  Text(
                    task.description!,
                    style: PlTypography.bodySmall.copyWith(color: colors.onSurfaceVariant),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: PlSpacing.xs),
                Wrap(
                  spacing: PlSpacing.xs,
                  runSpacing: PlSpacing.xs,
                  children: [
                    if (showGoal && task.goal != null)
                      _InfoChip(
                        icon: task.goal!.icon,
                        color: task.goal!.color,
                        label: task.goal!.name,
                      ),
                    if (task.dueDate != null)
                      _InfoChip(
                        icon: Icons.calendar_today_outlined,
                        color: _dueDateColor(task.dueDate!, colors),
                        label: _formatDueDate(context, task.dueDate!),
                      ),
                    if (showTags && task.tags.isNotEmpty)
                      ...task.tags.take(2).map((tag) => TagChip(tag: tag)),
                    if (showTags && task.tags.length > 2)
                      PlChip(
                        label: '+${task.tags.length - 2}',
                        style: PlChipStyle.outlined,
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (onEdit != null || onDelete != null)
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: colors.onSurfaceVariant, size: 20),
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
    );
  }

  Color _priorityColor(int priority, dynamic colors) {
    switch (priority) {
      case 1: return colors.success; // Low
      case 2: return colors.warning; // Medium
      case 3: return colors.error; // High
      case 4: return colors.tertiary; // Critical
      default: return colors.outline;
    }
  }

  Color _dueDateColor(DateTime dueDate, dynamic colors) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final diff = due.difference(today).inDays;

    if (diff < 0) return colors.error;
    if (diff == 0) return colors.warning;
    if (diff <= 2) return colors.warning;
    return colors.onSurfaceVariant;
  }

  String _formatDueDate(BuildContext context, DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final diff = due.difference(today).inDays;

    if (diff < 0) return 'Overdue';
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff <= 7) return 'In $diff days';
    return '${dueDate.day}/${dueDate.month}/${dueDate.year}';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return PlChip(
      label: label,
      icon: icon,
      style: PlChipStyle.filled,
      color: color.withOpacity(0.15),
      labelColor: color,
      padding: const EdgeInsets.symmetric(horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
    );
  }
}
