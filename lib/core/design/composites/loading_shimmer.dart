import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class LoadingShimmer extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;

  const LoadingShimmer({
    super.key,
    required this.child,
    this.isLoading = true,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: PlMotion.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final baseColor = widget.baseColor ?? colors.surfaceVariant;
    final highlightColor = widget.highlightColor ?? colors.surfaceContainerHighest;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final PlShimmerShape shape;

  const ShimmerPlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = PlShimmerShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    Widget placeholder;

    switch (shape) {
      case PlShimmerShape.rectangle:
        placeholder = Container(
          width: width,
          height: height ?? 16,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: borderRadius ?? PlBorderRadius.radiusMd,
          ),
        );
        break;
      case PlShimmerShape.circle:
        placeholder = Container(
          width: width ?? 40,
          height: height ?? 40,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            shape: BoxShape.circle,
          ),
        );
        break;
      case PlShimmerShape.rounded:
        placeholder = Container(
          width: width,
          height: height ?? 16,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: PlBorderRadius.radiusFull,
          ),
        );
        break;
    }

    return LoadingShimmer(child: placeholder);
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final double spacing;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    required this.itemBuilder,
    this.spacing = PlSpacing.xs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index == itemCount - 1 ? 0 : spacing),
          child: itemBuilder(index),
        );
      }),
    );
  }
}

enum PlShimmerShape { rectangle, circle, rounded }
