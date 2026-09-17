import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/index.dart';

class PlAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;
  final PlAppBarStyle style;

  const PlAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = false,
    this.style = PlAppBarStyle.standard,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final bgColor = backgroundColor ?? (style == PlAppBarStyle.transparent ? Colors.transparent : colors.surface);
    final fgColor = foregroundColor ?? colors.onSurface;

    return AppBar(
      title: title != null
          ? Text(title!, style: PlTypography.titleLarge.copyWith(color: fgColor))
          : null,
      leading: leading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      elevation: elevation,
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: style == PlAppBarStyle.standard ? 1 : 0,
    );
  }
}

enum PlAppBarStyle { standard, transparent, elevated }









