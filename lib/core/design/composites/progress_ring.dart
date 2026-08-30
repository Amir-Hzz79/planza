import 'package:flutter/material.dart';
import '../../tokens/index.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final Widget? centerChild;
  final bool showPercentage;
  final PlProgressRingStyle style;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 64,
    this.strokeWidth = 6,
    this.progressColor,
    this.backgroundColor,
    this.centerChild,
    this.showPercentage = false,
    this.style = PlProgressRingStyle.standard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? PlDarkColors : PlColors;

    final bgColor = backgroundColor ?? colors.surfaceVariant;
    final fgColor = progressColor ?? colors.primary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (style == PlProgressRingStyle.standard || style == PlProgressRingStyle.gradient)
            CustomPaint(
              size: Size(size, size),
              painter: _ProgressRingPainter(
                progress: progress.clamp(0.0, 1.0),
                strokeWidth: strokeWidth,
                backgroundColor: bgColor,
                progressColor: fgColor,
                style: style,
                gradientColors: style == PlProgressRingStyle.gradient
                    ? [fgColor, fgColor.withOpacity(0.7)]
                    : null,
              ),
            ),
          if (style == PlProgressRingStyle.segmented)
            CustomPaint(
              size: Size(size, size),
              painter: _SegmentedProgressPainter(
                progress: progress.clamp(0.0, 1.0),
                strokeWidth: strokeWidth,
                backgroundColor: bgColor,
                progressColor: fgColor,
                segments: 12,
              ),
            ),
          if (centerChild != null)
            centerChild!
          else if (showPercentage)
            Text(
              '${(progress * 100).round()}%',
              style: PlTypography.numberSmall.copyWith(
                color: colors.onSurface,
                fontSize: size * 0.25,
              ),
            ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final PlProgressRingStyle style;
  final List<Color>? gradientColors;

  _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.style,
    this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (style == PlProgressRingStyle.gradient && gradientColors != null) {
      fgPaint.shader = SweepGradient(
        startAngle: -3.14159 / 2,
        endAngle: 3 * 3.14159 / 2,
        colors: gradientColors!,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      fgPaint.color = progressColor;
    }

    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _ProgressRingPainter &&
        oldDelegate.progress != progress &&
        oldDelegate.progressColor != progressColor;
  }
}

class _SegmentedProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final int segments;

  _SegmentedProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    required this.segments,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final segmentAngle = 2 * 3.14159 / segments;
    const gapAngle = 0.05;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final fgPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final filledSegments = (progress * segments).floor();

    for (int i = 0; i < segments; i++) {
      final startAngle = -3.14159 / 2 + i * segmentAngle + gapAngle / 2;
      final sweepAngle = segmentAngle - gapAngle;

      if (i < filledSegments) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          fgPaint,
        );
      } else {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          bgPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _SegmentedProgressPainter &&
        oldDelegate.progress != progress;
  }
}

enum PlProgressRingStyle { standard, gradient, segmented }
