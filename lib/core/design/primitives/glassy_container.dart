import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/border_radius.dart';

import '../tokens/index.dart';

/// A translucent, blurred glass surface — the core building block of the
/// Liquid Glass design language.
///
/// Renders a [BackdropFilter] blur behind a semi-transparent surface with
/// refined shadow and large soft corner radius. Used for floating panels,
/// bottom sheets, dialogs, FAB menus, and highlighted strips.
class GlassyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final double opacity;
  final Color? tintColor;
  final List<BoxShadow>? shadows;
  final BorderRadius? borderRadius;
  final Border? border;
  final VoidCallback? onTap;
  final bool clipContent;

  const GlassyContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.blur = 24.0,
    this.opacity = 0.55,
    this.tintColor,
    this.shadows,
    this.borderRadius,
    this.border,
    this.onTap,
    this.clipContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final colorScheme = isDark ? darkColors : lightColors;

    final effectiveTint = tintColor ??
        (isDark
            ? colorScheme.surfaceContainerHighest.withOpacity(0.12)
            : colorScheme.surfaceContainer.withOpacity(0.35));

    final effectiveRadius = borderRadius ?? PlBorderRadius.radiusLiquid;

    final effectiveShadows = shadows ?? _glassShadows(isDark, colorScheme);

    Widget glass = Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: effectiveTint,
              borderRadius: effectiveRadius,
              border: Border.all(
                color: isDark
                    ? colorScheme.outlineVariant.withOpacity(0.4)
                    : colorScheme.outlineVariant.withOpacity(0.25),
                width: 0.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: padding ?? EdgeInsets.all(PlSpacing.md),
          child: child,
        ),
      ],
    );

    if (clipContent) {
      glass = ClipRRect(
        borderRadius: effectiveRadius,
        child: glass,
      );
    }

    if (onTap != null) {
      glass = InkWell(
        onTap: onTap,
        borderRadius: effectiveRadius,
        child: glass,
      );
    }

    return Container(
      margin: margin,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: effectiveRadius,
                boxShadow: effectiveShadows,
              ),
            ),
          ),
          glass,
        ],
      ),
    );
  }

  static List<BoxShadow> _glassShadows(bool isDark, PlColorScheme colors) {
    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 6),
          blurRadius: 24,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];
    }
    return [
      BoxShadow(
        color: colors.shadow.withOpacity(0.18),
        offset: const Offset(0, 8),
        blurRadius: 30,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: colors.shadow.withOpacity(0.08),
        offset: const Offset(0, 2),
        blurRadius: 10,
        spreadRadius: 0,
      ),
    ];
  }
}

/// A glass-style card — a [GlassyContainer] with card padding and an optional tap handler.
class GlassyCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final double opacity;
  final Color? tintColor;
  final VoidCallback? onTap;
  final Border? border;

  const GlassyCard({
    super.key,
    required this.child,
    this.margin,
    this.blur = 20.0,
    this.opacity = 0.5,
    this.tintColor,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return GlassyContainer(
      blur: blur,
      opacity: opacity,
      tintColor: tintColor,
      borderRadius: PlBorderRadius.radiusLiquid,
      padding: EdgeInsets.all(PlSpacing.md),
      margin: margin,
      shadows: [
        BoxShadow(
          color: colors.shadow.withOpacity(isDark ? 0.22 : 0.15),
          offset: const Offset(0, 6),
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ],
      onTap: onTap,
      child: child,
    );
  }
}

/// A glass-style chip — a small, rounded, translucent pill.
/// Use for filters, badges, and tags.
class GlassyChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
  final IconData? icon;
  final int? count;

  const GlassyChip({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
    this.icon,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final effectiveOpacity = isActive ? 0.6 : 0.35;
    final effectiveTint = isActive
        ? colors.primary.withOpacity(0.15)
        : colors.surfaceContainer.withOpacity(0.3);

    return GlassyContainer(
      blur: 10,
      opacity: effectiveOpacity,
      tintColor: effectiveTint,
      borderRadius: PlBorderRadius.radiusLiquidSm,
      padding: const EdgeInsets.symmetric(
          horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
      onTap: onTap,
      shadows: isActive
          ? [
              BoxShadow(
                color: colors.primary.withOpacity(0.18),
                offset: const Offset(0, 2),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ]
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: isActive ? colors.primary : colors.onSurfaceVariant,
            ),
            const SizedBox(width: PlSpacing.xs),
          ],
          Expanded(
            child: Text(
              label,
              style: PlTypography.labelMedium.copyWith(
                color: isActive ? colors.primary : colors.onSurfaceVariant,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: PlSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                count.toString(),
                style: PlTypography.labelSmall.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
