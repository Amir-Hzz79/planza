import 'package:flutter/material.dart';

class PlBorderRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double full = 9999;

  static const BorderRadius radiusNone = BorderRadius.zero;
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusFull = BorderRadius.all(Radius.circular(full));

  static const BorderRadius topSm = BorderRadius.vertical(top: Radius.circular(sm));
  static const BorderRadius topMd = BorderRadius.vertical(top: Radius.circular(md));
  static const BorderRadius topLg = BorderRadius.vertical(top: Radius.circular(lg));
  static const BorderRadius topXl = BorderRadius.vertical(top: Radius.circular(xl));

  static const BorderRadius bottomSm = BorderRadius.vertical(bottom: Radius.circular(sm));
  static const BorderRadius bottomMd = BorderRadius.vertical(bottom: Radius.circular(md));
  static const BorderRadius bottomLg = BorderRadius.vertical(bottom: Radius.circular(lg));
  static const BorderRadius bottomXl = BorderRadius.vertical(bottom: Radius.circular(xl));

  static const BorderRadius leftMd = BorderRadius.horizontal(left: Radius.circular(md));
  static const BorderRadius rightMd = BorderRadius.horizontal(right: Radius.circular(md));

  static BorderRadius only({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    return BorderRadius.only(
      topLeft: topLeft != null ? Radius.circular(topLeft) : Radius.zero,
      topRight: topRight != null ? Radius.circular(topRight) : Radius.zero,
      bottomLeft: bottomLeft != null ? Radius.circular(bottomLeft) : Radius.zero,
      bottomRight: bottomRight != null ? Radius.circular(bottomRight) : Radius.zero,
    );
  }

  static BorderRadius symmetric({double horizontal = 0, double vertical = 0}) {
    return BorderRadius.only(
      topLeft: horizontal > 0 || vertical > 0 ? Radius.circular(horizontal) : Radius.zero,
      topRight: horizontal > 0 || vertical > 0 ? Radius.circular(horizontal) : Radius.zero,
      bottomLeft: horizontal > 0 || vertical > 0 ? Radius.circular(horizontal) : Radius.zero,
      bottomRight: horizontal > 0 || vertical > 0 ? Radius.circular(horizontal) : Radius.zero,
    );
  }
}
