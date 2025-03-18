import 'package:flutter/material.dart';

extension ColorExtention on Color {
  Color matchTextColor() {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  Color withLightness(double amount) {
    // Convert the color to HSL
    final hslColor = HSLColor.fromColor(this);

    // Adjust the lightness, clamping it between 0.0 and 1.0
    final adjustedHslColor = hslColor.withLightness(
      (hslColor.lightness + amount).clamp(0.0, 1.0),
    );

    // Convert the adjusted HSL color back to a regular Color
    return adjustedHslColor.toColor();
  }
}
