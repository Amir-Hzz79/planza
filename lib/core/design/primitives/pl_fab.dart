import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

class PlFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? label;
  final PlFABStyle style;
  final PlFABSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;

  const PlFAB({
    super.key,
    this.onPressed,
    this.icon,
    this.label,
    this.style = PlFABStyle.standard,
    this.size = PlFABSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
  }) : assert(icon != null || label != null,
            'Either icon or label must be provided');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final bgColor = backgroundColor ?? colors.primary;
    final fgColor = foregroundColor ?? colors.onBackground;

    final double fabSize = switch (size) {
      PlFABSize.sm => 40,
      PlFABSize.md => 56,
      PlFABSize.lg => 72,
    };

    final double iconSize = switch (size) {
      PlFABSize.sm => 20,
      PlFABSize.md => 24,
      PlFABSize.lg => 28,
    };

    final EdgeInsets padding = label != null
        ? EdgeInsets.symmetric(horizontal: PlSpacing.md, vertical: PlSpacing.sm)
        : EdgeInsets.all(fabSize * 0.15);

    Widget fab;

    switch (style) {
      case PlFABStyle.standard:
        fab = FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          tooltip: tooltip,
          child: label != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: iconSize),
                      SizedBox(width: PlSpacing.xs),
                    ],
                    Text(label!,
                        style:
                            PlTypography.labelLarge.copyWith(color: fgColor)),
                  ],
                )
              : Icon(icon, size: iconSize),
        );
        break;
      case PlFABStyle.extended:
        fab = FloatingActionButton.extended(
          onPressed: onPressed,
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          tooltip: tooltip,
          icon: icon != null ? Icon(icon, size: iconSize) : null,
          label: label != null
              ? Text(label!,
                  style: PlTypography.labelLarge.copyWith(color: fgColor))
              : Text(''),
        );
        break;
      case PlFABStyle.outlined:
        fab = FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.transparent,
          foregroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: PlBorderRadius.radiusFull,
            side: BorderSide(color: bgColor, width: 2),
          ),
          tooltip: tooltip,
          child: Icon(icon, size: iconSize),
        );
        break;
    }

    return fab;
  }
}

enum PlFABStyle { standard, extended, outlined }

enum PlFABSize { sm, md, lg }
