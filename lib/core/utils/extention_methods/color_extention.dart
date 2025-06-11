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

  /// A non-deprecated way to apply opacity to a Color.
  /// The `withOpacity` method is deprecated due to precision loss.
  /// This method uses the recommended `withAlpha` while still allowing
  /// you to use a familiar double value (0.0 to 1.0).
  Color withOpacityDouble(double opacity) {
    if (opacity < 0.0) opacity = 0.0;
    if (opacity > 1.0) opacity = 1.0;
    return withAlpha((opacity * 255).round());
  }
}
