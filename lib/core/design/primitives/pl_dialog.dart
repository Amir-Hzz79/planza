import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

import 'pl_button.dart';

class PlDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? contentPadding,
    double? maxWidth,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        backgroundColor: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusLg),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null || actions != null)
                Padding(
                  padding: contentPadding ?? PlSpacing.pageHorizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) ...[
                        Text(title,
                            style: PlTypography.titleLarge
                                .copyWith(color: colors.onSurface)),
                        SizedBox(height: PlSpacing.md),
                      ],
                      Flexible(child: child),
                      if (actions != null) ...[
                        SizedBox(height: PlSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: actions,
                        ),
                      ],
                    ],
                  ),
                )
              else
                Padding(
                  padding: contentPadding ?? PlSpacing.page,
                  child: child,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    PlButtonStyle confirmStyle = PlButtonStyle.filled,
    bool isDestructive = false,
  }) {
    return show<bool>(
      context: context,
      title: title,
      child: Text(message, style: PlTypography.bodyMedium),
      actions: [
        PlButton(
          label: cancelText,
          style: PlButtonStyle.text,
          onPressed: () => Navigator.pop(context, false),
        ),
        SizedBox(width: PlSpacing.sm),
        PlButton(
          label: confirmText,
          style: isDestructive ? PlButtonStyle.destructive : confirmStyle,
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  static Future<void> alert({
    required BuildContext context,
    required String title,
    required String message,
    String okText = 'OK',
  }) {
    return show<void>(
      context: context,
      title: title,
      child: Text(message, style: PlTypography.bodyMedium),
      actions: [
        PlButton(
          label: okText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
