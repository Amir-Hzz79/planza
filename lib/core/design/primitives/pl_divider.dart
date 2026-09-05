import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

class PlDivider extends StatelessWidget {
  final PlDividerDirection direction;
  final double thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;

  const PlDivider({
    super.key,
    this.direction = PlDividerDirection.horizontal,
    this.thickness = 1,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final dividerColor = color ?? colors.outlineVariant;

    if (direction == PlDividerDirection.horizontal) {
      return Padding(
        padding: margin ?? const EdgeInsets.symmetric(vertical: PlSpacing.sm),
        child: Divider(
          height: thickness,
          thickness: thickness,
          color: dividerColor,
          indent: indent,
          endIndent: endIndent,
        ),
      );
    } else {
      return Padding(
        padding: margin ?? const EdgeInsets.symmetric(horizontal: PlSpacing.sm),
        child: VerticalDivider(
          width: thickness,
          thickness: thickness,
          color: dividerColor,
          indent: indent ?? 0,
          endIndent: endIndent ?? 0,
        ),
      );
    }
  }
}

enum PlDividerDirection { horizontal, vertical }









