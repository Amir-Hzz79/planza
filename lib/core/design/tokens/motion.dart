import 'package:flutter/material.dart';

class PlMotion {
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fastest = Duration(milliseconds: 50);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 700);
  static const Duration slowest = Duration(milliseconds: 1000);

  static const Curve linear = Curves.linear;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;

  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve fastLinearToSlowEaseIn = Curves.fastLinearToSlowEaseIn;
  static const Curve slowMiddle = Curves.slowMiddle;

  static const Curve decelerate = Cubic(0.0, 0.0, 0.2, 1.0);
  static const Curve accelerate = Cubic(0.4, 0.0, 1.0, 1.0);
  static const Curve standard = Cubic(0.4, 0.0, 0.2, 1.0);
  static const Curve emphasized = Cubic(0.4, 0.0, 0.0, 1.0);

  static const Curve spring = Curves.elasticOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve overshoot = Curves.elasticOut;

  static const Duration pageTransition = medium;
  static const Curve pageTransitionCurve = standard;

  static const Duration modalTransition = medium;
  static const Curve modalTransitionCurve = standard;

  static const Duration fabTransition = fast;
  static const Curve fabTransitionCurve = emphasized;

  static const Duration listReorder = medium;
  static const Curve listReorderCurve = standard;

  static const Duration expansion = medium;
  static const Curve expansionCurve = standard;

  static const Duration fadeIn = fast;
  static const Duration fadeOut = fast;

  static const Duration scaleIn = fast;
  static const Curve scaleInCurve = emphasized;
  static const Duration scaleOut = fastest;
  static const Curve scaleOutCurve = accelerate;

  static const Duration slideIn = medium;
  static const Curve slideInCurve = decelerate;
  static const Duration slideOut = fast;
  static const Curve slideOutCurve = accelerate;

  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration pulse = Duration(milliseconds: 2000);
  static const Duration celebration = Duration(milliseconds: 3000);

  static const Duration microTap = fastest;
  static const Duration microHover = fast;
  static const Duration microPress = fastest;
  static const Duration microRelease = fast;

  static Tween<double> get fadeTween => Tween<double>(begin: 0.0, end: 1.0);
  static Tween<double> get scaleTween => Tween<double>(begin: 0.95, end: 1.0);
  static Tween<Offset> get slideUpTween => Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero);
  static Tween<Offset> get slideDownTween => Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero);
  static Tween<Offset> get slideLeftTween => Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero);
  static Tween<Offset> get slideRightTween => Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero);
}

class PlAnimationPresets {
  static Animation<double> fadeIn({
    required TickerProvider vsync,
    Duration duration = PlMotion.fadeIn,
    Curve curve = PlMotion.easeOut,
  }) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: vsync.animationController(duration: duration), curve: curve),
    );
  }

  static Animation<double> scaleIn({
    required TickerProvider vsync,
    Duration duration = PlMotion.scaleIn,
    Curve curve = PlMotion.scaleInCurve,
  }) {
    return Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: vsync.animationController(duration: duration), curve: curve),
    );
  }

  static Animation<Offset> slideUp({
    required TickerProvider vsync,
    Duration duration = PlMotion.slideIn,
    Curve curve = PlMotion.slideInCurve,
  }) {
    return Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: vsync.animationController(duration: duration), curve: curve),
    );
  }

  static Animation<double> shimmer({
    required TickerProvider vsync,
    Duration duration = PlMotion.shimmer,
  }) {
    return Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: vsync.animationController(duration: duration, reverseDuration: duration),
        curve: PlMotion.linear,
      ),
    );
  }
}

extension TickerProviderExtensions on TickerProvider {
  AnimationController animationController({
    Duration duration = PlMotion.medium,
    Duration? reverseDuration,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    String? debugLabel,
  }) {
    return AnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
      lowerBound: lowerBound,
      upperBound: upperBound,
      vsync: this,
      debugLabel: debugLabel,
    );
  }
}