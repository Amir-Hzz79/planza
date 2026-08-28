import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class PlButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? trailingIcon;
  final PlButtonStyle style;
  final PlButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;

  const PlButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.trailingIcon,
    this.style = PlButtonStyle.filled,
    this.size = PlButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;

    switch (style) {
      case PlButtonStyle.filled:
        backgroundColor = colors.primary;
        foregroundColor = colors.onBackground;
        break;
      case PlButtonStyle.filledTonal:
        backgroundColor = colors.primaryContainer;
        foregroundColor = colors.primaryDark;
        break;
      case PlButtonStyle.outlined:
        backgroundColor = Colors.transparent;
        foregroundColor = colors.primary;
        borderColor = colors.outline;
        break;
      case PlButtonStyle.text:
        backgroundColor = Colors.transparent;
        foregroundColor = colors.primary;
        break;
      case PlButtonStyle.destructive:
        backgroundColor = colors.error;
        foregroundColor = colors.onBackground;
        break;
    }

    final effectivePadding = padding ??
        (size == PlButtonSize.sm
            ? PlSpacing.buttonPaddingSm
            : size == PlButtonSize.lg
                ? PlSpacing.buttonPaddingLg
                : PlSpacing.buttonPadding);

    final textStyle = size == PlButtonSize.sm
        ? PlTypography.buttonSmall
        : size == PlButtonSize.lg
            ? PlTypography.buttonLarge
            : PlTypography.buttonMedium;

    Widget child = isLoading
        ? SizedBox(
            width: size == PlButtonSize.sm ? 16 : 20,
            height: size == PlButtonSize.sm ? 16 : 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: size == PlButtonSize.sm ? 16 : 20, color: foregroundColor),
                SizedBox(width: PlSpacing.xs),
              ],
              Text(label, style: textStyle.copyWith(color: foregroundColor)),
              if (trailingIcon != null) ...[
                SizedBox(width: PlSpacing.xs),
                Icon(trailingIcon, size: size == PlButtonSize.sm ? 16 : 20, color: foregroundColor),
              ],
            ],
          );

    final button = DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: PlBorderRadius.radiusFull,
        border: borderColor != null ? Border.all(color: borderColor, width: 1.5) : null,
        boxShadow: style == PlButtonStyle.filled || style == PlButtonStyle.filledTonal
            ? PlElevation.shadow1
            : null,
      ),
      child: Padding(padding: effectivePadding, child: child),
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

enum PlButtonStyle { filled, filledTonal, outlined, text, destructive }

enum PlButtonSize { sm, md, lg }
