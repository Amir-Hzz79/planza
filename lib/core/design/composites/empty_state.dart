import 'package:flutter/material.dart';
import '../../primitives/index.dart';
import '../../tokens/index.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final Widget? action;
  final String? actionLabel;
  final VoidCallback? onAction;
  final PlEmptyStateStyle style;
  final double? iconSize;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.action,
    this.actionLabel,
    this.onAction,
    this.style = PlEmptyStateStyle.standard,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final defaultIcon = icon ?? _getDefaultIcon(style);
    final defaultIconSize = iconSize ?? 64;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(defaultIconSize * 0.3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.primaryContainer.withOpacity(0.3),
          ),
          child: Icon(
            defaultIcon,
            size: defaultIconSize,
            color: colors.primary,
          ),
        ),
        SizedBox(height: PlSpacing.lg),
        Text(
          title,
          style: PlTypography.titleLarge.copyWith(color: colors.onSurface),
          textAlign: TextAlign.center,
        ),
        if (message != null) ...[
          SizedBox(height: PlSpacing.sm),
          Text(
            message!,
            style: PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
        if (action != null || (actionLabel != null && onAction != null)) ...[
          SizedBox(height: PlSpacing.lg),
          action ??
              PlButton(
                label: actionLabel!,
                onPressed: onAction,
                icon: Icons.add,
                style: PlButtonStyle.filled,
                size: PlButtonSize.md,
              ),
        ],
      ],
    );

    switch (style) {
      case PlEmptyStateStyle.standard:
        return Center(child: content);
      case PlEmptyStateStyle.card:
        return PlCard(
          style: PlCardStyle.filled,
          padding: PlSpacing.cardPaddingLg,
          child: content,
        );
      case PlEmptyStateStyle.fullscreen:
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: content,
          ),
        );
    }
  }

  IconData _getDefaultIcon(PlEmptyStateStyle style) {
    switch (style) {
      case PlEmptyStateStyle.standard:
      case PlEmptyStateStyle.card:
      case PlEmptyStateStyle.fullscreen:
        return Icons.inbox_outlined;
    }
  }
}

class EmptyStateIllustration extends StatelessWidget {
  final String illustration;
  final String title;
  final String? message;
  final Widget? action;

  const EmptyStateIllustration({
    super.key,
    required this.illustration,
    required this.title,
    this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          illustration,
          style: TextStyle(fontSize: 80),
        ),
        SizedBox(height: PlSpacing.lg),
        Text(
          title,
          style: PlTypography.titleLarge.copyWith(color: colors.onSurface),
          textAlign: TextAlign.center,
        ),
        if (message != null) ...[
          SizedBox(height: PlSpacing.sm),
          Text(
            message!,
            style: PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
        if (action != null) ...[
          SizedBox(height: PlSpacing.lg),
          action!,
        ],
      ],
    );
  }
}

enum PlEmptyStateStyle { standard, card, fullscreen }
