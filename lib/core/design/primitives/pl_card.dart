import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class PlCard extends StatelessWidget {
  final Widget child;
  final PlCardStyle style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final List<BoxShadow>? shadows;
  final Border? border;

  const PlCard({
    super.key,
    required this.child,
    this.style = PlCardStyle.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.shadows,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    Color backgroundColor;
    List<BoxShadow> effectiveShadows;
    Border effectiveBorder;

    switch (style) {
      case PlCardStyle.elevated:
        backgroundColor = color ?? colors.surface;
        effectiveShadows = shadows ?? PlElevation.shadow2;
        effectiveBorder = border ?? Border.none;
        break;
      case PlCardStyle.outlined:
        backgroundColor = color ?? colors.surface;
        effectiveShadows = shadows ?? [];
        effectiveBorder = border ?? Border.all(color: colors.outlineVariant, width: 1);
        break;
      case PlCardStyle.filled:
        backgroundColor = color ?? colors.surfaceVariant;
        effectiveShadows = shadows ?? [];
        effectiveBorder = border ?? Border.none;
        break;
      case PlCardStyle.glass:
        backgroundColor = color ?? (isDark ? colors.surface.withOpacity(0.8) : colors.surface.withOpacity(0.6));
        effectiveShadows = shadows ?? PlElevation.shadow1;
        effectiveBorder = border ?? Border.all(color: colors.outlineVariant.withOpacity(0.5), width: 1);
        break;
    }

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: PlBorderRadius.radiusLg,
        boxShadow: effectiveShadows,
        border: effectiveBorder,
      ),
      child: Padding(
        padding: padding ?? PlSpacing.cardPadding,
        child: child,
      ),
    );

    if (onTap != null) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: PlBorderRadius.radiusLg,
          child: card,
        ),
      );
    }

    return Padding(padding: margin ?? EdgeInsets.zero, child: card);
  }
}

enum PlCardStyle { elevated, outlined, filled, glass }
