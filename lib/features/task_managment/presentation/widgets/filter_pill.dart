import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;
  final IconData? icon;
  final Color? color;

  const FilterPill({
    super.key,
    required this.label,
    required this.onDeleted,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isThemed = color != null;

    final Color foregroundColor =
        isThemed ? Colors.white : theme.colorScheme.onSurface;
    final BoxDecoration decoration;

    if (isThemed) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [color!, color!.withOpacityDouble(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withOpacityDouble(0.3),
        ),
      );
    } else {
      decoration = BoxDecoration(
        color: theme.colorScheme.onSurface.withOpacityDouble(0.1),
        borderRadius: BorderRadius.circular(20.0),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 34,
            decoration: decoration,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null)
                        Icon(icon, color: foregroundColor, size: 16),
                      if (icon != null) const SizedBox(width: 6),
                      Text(
                        label,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foregroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: onDeleted,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.cancel,
                            size: 18.0,
                            color: foregroundColor.withOpacityDouble(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
