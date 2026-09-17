import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/motion.dart';

class PlPageTransition extends PageRouteBuilder {
  final Widget child;
  final PlPageTransitionType type;
  final Duration duration;
  final Curve curve;

  PlPageTransition({
    required this.child,
    this.type = PlPageTransitionType.fadeScale,
    this.duration = PlMotion.pageTransition,
    this.curve = PlMotion.pageTransitionCurve,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: curve);
            return _buildTransition(type, curved, child);
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
        );

  static Widget _buildTransition(
      PlPageTransitionType type, Animation<double> animation, Widget child) {
    switch (type) {
      case PlPageTransitionType.fade:
        return FadeTransition(opacity: animation, child: child);
      case PlPageTransitionType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
              .animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      case PlPageTransitionType.slideRight:
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
                  .animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      case PlPageTransitionType.scale:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      case PlPageTransitionType.fadeScale:
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
            child: child,
          ),
        );
      case PlPageTransitionType.slideFadeScale:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
              .animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
              child: child,
            ),
          ),
        );
    }
  }
}

class PlSharedAxisTransition extends PageRouteBuilder {
  final Widget child;
  final SharedAxisTransitionType transitionType;
  final Duration duration;
  final Curve curve;

  PlSharedAxisTransition({
    required this.child,
    this.transitionType = SharedAxisTransitionType.horizontal,
    this.duration = PlMotion.pageTransition,
    this.curve = PlMotion.pageTransitionCurve,
    RouteSettings? settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: curve);
            return _SharedAxisTransition(
              animation: curved,
              transitionType: transitionType,
              child: child,
            );
          },
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          settings: settings,
        );
}

class _SharedAxisTransition extends StatelessWidget {
  final Animation<double> animation;
  final SharedAxisTransitionType transitionType;
  final Widget child;

  const _SharedAxisTransition({
    required this.animation,
    required this.transitionType,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double translateX = 0;
        double translateY = 0;
        double scale = 1;
        double opacity = animation.value;

        switch (transitionType) {
          case SharedAxisTransitionType.horizontal:
            translateX = (1 - animation.value) *
                300 *
                (animation.status == AnimationStatus.reverse ? -1 : 1);
            break;
          case SharedAxisTransitionType.vertical:
            translateY = (1 - animation.value) *
                300 *
                (animation.status == AnimationStatus.reverse ? -1 : 1);
            break;
          case SharedAxisTransitionType.scaled:
            scale = 0.9 + 0.1 * animation.value;
            break;
        }

        return Transform.translate(
          offset: Offset(translateX, translateY),
          child: Transform.scale(
            scale: scale,
            child: Opacity(opacity: opacity, child: this.child),
          ),
        );
      },
      child: child,
    );
  }
}

enum PlPageTransitionType {
  fade,
  slideUp,
  slideRight,
  scale,
  fadeScale,
  slideFadeScale,
}

enum SharedAxisTransitionType { horizontal, vertical, scaled }



