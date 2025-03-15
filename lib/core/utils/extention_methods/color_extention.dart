import 'package:flutter/material.dart';

extension ColorExtention on Color {
  Color matchTextColor() {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
