import 'package:flutter/material.dart';
import 'package:planza/core/design/primitives/index.dart';

class PriorityBadge extends StatelessWidget {
  final int priority;
  final bool showLabel;
  final PlChipStyle style;

  const PriorityBadge({
    super.key,
    required this.priority,
    this.showLabel = true,
    this.style = PlChipStyle.filled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final (label, color, icon) = _getPriorityInfo(priority, colors);

    return PlChip(
      label: showLabel ? label : '',
      icon: showLabel ? icon : null,
      style: style,
      color: style == PlChipStyle.filled ? color.withOpacity(0.15) : null,
      labelColor: color,
      padding: EdgeInsets.symmetric(
        horizontal: showLabel ? PlSpacing.sm : PlSpacing.xs,
        vertical: PlSpacing.xs,
      ),
    );
  }

  (String, Color, IconData) _getPriorityInfo(int priority, dynamic colors) {
    switch (priority) {
      case 1:
        return ('Low', colors.success, Icons.arrow_downward);
      case 2:
        return ('Medium', colors.warning, Icons.remove);
      case 3:
        return ('High', colors.error, Icons.arrow_upward);
      case 4:
        return ('Critical', colors.tertiary, Icons.priority_high);
      default:
        return ('None', colors.outline, Icons.help_outline);
    }
  }
}

class PrioritySelector extends StatelessWidget {
  final int? selectedPriority;
  final ValueChanged<int?> onChanged;
  final bool allowNone;

  const PrioritySelector({
    super.key,
    this.selectedPriority,
    required this.onChanged,
    this.allowNone = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Wrap(
      spacing: PlSpacing.sm,
      runSpacing: PlSpacing.sm,
      children: [
        if (allowNone)
          _PriorityOption(
            priority: null,
            label: 'None',
            color: colors.outline,
            icon: Icons.remove_circle_outline,
            isSelected: selectedPriority == null,
            onTap: () => onChanged(null),
          ),
        ...[1, 2, 3, 4].map((p) => _PriorityOption(
              priority: p,
              label: _getLabel(p),
              color: _getColor(p, colors),
              icon: _getIcon(p),
              isSelected: selectedPriority == p,
              onTap: () => onChanged(p),
            )),
      ],
    );
  }

  String _getLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      case 4:
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  Color _getColor(int priority, dynamic colors) {
    switch (priority) {
      case 1:
        return colors.success;
      case 2:
        return colors.warning;
      case 3:
        return colors.error;
      case 4:
        return colors.tertiary;
      default:
        return colors.outline;
    }
  }

  IconData _getIcon(int priority) {
    switch (priority) {
      case 1:
        return Icons.arrow_downward;
      case 2:
        return Icons.remove;
      case 3:
        return Icons.arrow_upward;
      case 4:
        return Icons.priority_high;
      default:
        return Icons.help_outline;
    }
  }
}

class _PriorityOption extends StatelessWidget {
  final int? priority;
  final String label;
  final Color color;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityOption({
    required this.priority,
    required this.label,
    required this.color,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: PlBorderRadius.radiusFull,
      child: AnimatedContainer(
        duration: PlMotion.fast,
        curve: PlMotion.standard,
        padding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.md, vertical: PlSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: PlBorderRadius.radiusFull,
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 16, color: isSelected ? color : color.withOpacity(0.7)),
            SizedBox(width: PlSpacing.xs),
            Text(
              label,
              style: PlTypography.labelMedium.copyWith(
                color: isSelected ? color : color.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
