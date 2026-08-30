import 'package:flutter/material.dart';

class PlSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  static const double pagePadding = md;
  static const double sectionGap = lg;
  static const double itemGap = sm;
  static const double inlineGap = xs;

  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: pagePadding);
  static const EdgeInsets pageVertical = EdgeInsets.symmetric(vertical: pagePadding);
  static const EdgeInsets page = EdgeInsets.all(pagePadding);

  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingSm = EdgeInsets.all(sm);
  static const EdgeInsets cardPaddingLg = EdgeInsets.all(lg);

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: lg, vertical: sm);
  static const EdgeInsets buttonPaddingSm = EdgeInsets.symmetric(horizontal: md, vertical: xs);
  static const EdgeInsets buttonPaddingLg = EdgeInsets.symmetric(horizontal: xl, vertical: md);

  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(horizontal: md, vertical: sm);
  static const EdgeInsets listItemPaddingSm = EdgeInsets.symmetric(horizontal: sm, vertical: xs);

  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);
  static const EdgeInsets bottomSheetPadding = EdgeInsets.all(lg);

  static const Radius radiusXs = Radius.circular(4);
  static const Radius radiusSm = Radius.circular(8);
  static const Radius radiusMd = Radius.circular(12);
  static const Radius radiusLg = Radius.circular(16);
  static const Radius radiusXl = Radius.circular(24);
  static const Radius radiusFull = Radius.circular(9999);

  static const BorderRadius borderRadiusXs = BorderRadius.all(radiusXs);
  static const BorderRadius borderRadiusSm = BorderRadius.all(radiusSm);
  static const BorderRadius borderRadiusMd = BorderRadius.all(radiusMd);
  static const BorderRadius borderRadiusLg = BorderRadius.all(radiusLg);
  static const BorderRadius borderRadiusXl = BorderRadius.all(radiusXl);
  static const BorderRadius borderRadiusFull = BorderRadius.all(radiusFull);

  static const BorderRadius topRadiusMd = BorderRadius.vertical(top: radiusMd);
  static const BorderRadius topRadiusLg = BorderRadius.vertical(top: radiusLg);
  static const BorderRadius bottomRadiusMd = BorderRadius.vertical(bottom: radiusMd);
  static const BorderRadius bottomRadiusLg = BorderRadius.vertical(bottom: radiusLg);
}

class PlElevation {
  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 3;
  static const double level3 = 6;
  static const double level4 = 10;
  static const double level5 = 15;

  static const List<BoxShadow> shadow0 = [];
  static const List<BoxShadow> shadow1 = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 2, offset: Offset(0, 1)),
  ];
  static const List<BoxShadow> shadow2 = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
    BoxShadow(color: Color(0x0F000000), blurRadius: 2, offset: Offset(0, 1)),
  ];
  static const List<BoxShadow> shadow3 = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x0F000000), blurRadius: 4, offset: Offset(0, 2)),
  ];
  static const List<BoxShadow> shadow4 = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 20, offset: Offset(0, 8)),
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> shadow5 = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 30, offset: Offset(0, 12)),
    BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 6)),
  ];

  static List<BoxShadow> get(int level) {
    switch (level.clamp(0, 5)) {
      case 0: return shadow0;
      case 1: return shadow1;
      case 2: return shadow2;
      case 3: return shadow3;
      case 4: return shadow4;
      case 5: return shadow5;
      default: return shadow0;
    }
  }
}