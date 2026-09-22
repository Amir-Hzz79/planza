import 'package:flutter/material.dart';

class PlSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const PlSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? colorScheme.primary,
      inactiveThumbColor: inactiveColor ?? colorScheme.outline,
      inactiveTrackColor: colorScheme.surfaceContainerHighest,
      activeTrackColor: colorScheme.primaryContainer,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}