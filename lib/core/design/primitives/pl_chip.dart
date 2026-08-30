import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class PlChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool isSelected;
  final PlChipStyle style;
  final Color? color;
  final Color? labelColor;
  final EdgeInsetsGeometry? padding;

  const PlChip({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.onDeleted,
    this.isSelected = false,
    this.style = PlChipStyle.standard,
    this.color,
    this.labelColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    Color backgroundColor;
    Color foregroundColor;
    Border? border;

    if (widget.color != null) {
      backgroundColor = widget.color!;
      foregroundColor = widget.labelColor ?? _getContrastColor(widget.color!);
    } else if (isSelected) {
      backgroundColor = colors.primaryContainer;
      foregroundColor = colors.primaryDark;
    } else {
      switch (style) {
        case PlChipStyle.standard:
          backgroundColor = colors.surfaceVariant;
          foregroundColor = colors.onSurfaceVariant;
          break;
        case PlChipStyle.outlined:
          backgroundColor = Colors.transparent;
          foregroundColor = colors.onSurfaceVariant;
          border = Border.all(color: colors.outline, width: 1.5);
          break;
        case PlChipStyle.filled:
          backgroundColor = colors.primaryContainer;
          foregroundColor = colors.primaryDark;
          break;
      }
    }

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: foregroundColor),
          SizedBox(width: PlSpacing.xs),
        ],
        Text(label, style: PlTypography.labelMedium.copyWith(color: foregroundColor)),
        if (onDeleted != null) ...[
          SizedBox(width: PlSpacing.xs),
          GestureDetector(
            onTap: onDeleted,
            child: Icon(Icons.close, size: 16, color: foregroundColor.withOpacity(0.7)),
          ),
        ],
      ],
    );

    final chip = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: PlBorderRadius.radiusFull,
        border: border,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: PlBorderRadius.radiusFull,
        child: chip,
      );
    }

    return chip;
  }

  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

enum PlChipStyle { standard, outlined, filled }
