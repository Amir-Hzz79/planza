import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

class PlTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final PlTooltipPosition position;
  final Duration waitDuration;
  final Duration showDuration;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool preferBelow;
  final bool excludeFromSemantics;

  const PlTooltip({
    super.key,
    required this.child,
    required this.message,
    this.position = PlTooltipPosition.top,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 3),
    this.padding = const EdgeInsets.symmetric(
        horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
    this.margin = const EdgeInsets.symmetric(
        horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
    this.preferBelow = true,
    this.excludeFromSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Tooltip(
      message: message,
      waitDuration: waitDuration,
      showDuration: showDuration,
      padding: padding,
      margin: margin,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: PlBorderRadius.radiusSm,
        boxShadow: PlElevation.shadow2,
      ),
      textStyle:
          PlTypography.bodySmall.copyWith(color: colors.inverseOnSurface),
      verticalOffset: PlSpacing.sm,
      child: child,
    );
  }
}

enum PlTooltipPosition { top, bottom, left, right }
