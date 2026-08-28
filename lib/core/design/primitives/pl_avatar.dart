import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class PlAvatar extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final IconData? icon;
  final PlAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  const PlAvatar({
    super.key,
    this.name,
    this.imageUrl,
    this.icon,
    this.size = PlAvatarSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final double radius = switch (size) {
      PlAvatarSize.xs => 12,
      PlAvatarSize.sm => 16,
      PlAvatarSize.md => 24,
      PlAvatarSize.lg => 32,
      PlAvatarSize.xl => 40,
      PlAvatarSize.xxl => 56,
    };

    final double fontSize = radius * 0.55;

    final bgColor = backgroundColor ?? colors.primaryContainer;
    final fgColor = foregroundColor ?? colors.primaryDark;

    Widget avatar;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatar = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: bgColor,
      );
    } else if (name != null && name!.isNotEmpty) {
      final initials = _getInitials(name!);
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: bgColor,
        child: Text(
          initials,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: fgColor,
          ),
        ),
      );
    } else {
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: bgColor,
        child: Icon(icon ?? Icons.person, size: fontSize * 1.2, color: fgColor),
      );
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: avatar,
      );
    }

    return avatar;
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

enum PlAvatarSize { xs, sm, md, lg, xl, xxl }
