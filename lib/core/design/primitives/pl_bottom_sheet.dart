import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

class PlBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
    bool showDragHandle = true,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    PlBottomSheetSize size = PlBottomSheetSize.auto,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor ?? colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: PlBorderRadius.radiusXl.topLeft),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: size.initial,
        minChildSize: size.min,
        maxChildSize: size.max,
        expand: false,
        builder: (context, scrollController) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: padding ?? PlSpacing.pageHorizontal,
                child: Row(
                  children: [
                    Text(title,
                        style: PlTypography.titleLarge
                            .copyWith(color: colors.onSurface)),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: colors.onSurfaceVariant),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            Flexible(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: padding ?? PlSpacing.page,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlBottomSheetSize {
  final double initial;
  final double min;
  final double max;

  const PlBottomSheetSize(
      {required this.initial, required this.min, required this.max});

  static const auto = PlBottomSheetSize(initial: 0.5, min: 0.3, max: 0.9);
  static const half = PlBottomSheetSize(initial: 0.5, min: 0.4, max: 0.6);
  static const full = PlBottomSheetSize(initial: 0.9, min: 0.5, max: 0.95);
  static const small = PlBottomSheetSize(initial: 0.3, min: 0.2, max: 0.4);
}
