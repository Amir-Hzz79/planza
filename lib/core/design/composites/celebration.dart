import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

enum CelebrationType {
  levelUp,
  streakMilestone,
  taskComplete,
  goalComplete,
  templateCreated,
  unlockable,
}

class CelebrationOverlay extends StatelessWidget {
  final CelebrationType type;
  final String? message;
  final VoidCallback? onComplete;
  final Duration duration;

  const CelebrationOverlay({
    super.key,
    required this.type,
    this.message,
    this.onComplete,
    this.duration = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        color: Colors.black54,
        child: Center(
          child: _CelebrationContent(
            type: type,
            message: message,
            onComplete: onComplete,
            duration: duration,
          ),
        ),
      ),
    );
  }
}

class _CelebrationContent extends StatefulWidget {
  final CelebrationType type;
  final String? message;
  final VoidCallback? onComplete;
  final Duration duration;

  const _CelebrationContent({
    required this.type,
    this.message,
    this.onComplete,
    required this.duration,
  });

  @override
  State<_CelebrationContent> createState() => _CelebrationContentState();
}

class _CelebrationContentState extends State<_CelebrationContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (widget.onComplete != null) {
            widget.onComplete!();
          } else {
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          margin: const EdgeInsets.all(PlSpacing.xl),
          padding: const EdgeInsets.all(PlSpacing.xl),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset(
                  _getAnimationPath(widget.type),
                  repeat: false,
                  animate: true,
                ),
              ),
              const SizedBox(height: PlSpacing.md),
              Text(
                widget.message ?? _getDefaultMessage(widget.type),
                style: PlTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.type == CelebrationType.levelUp) ...[
                const SizedBox(height: PlSpacing.sm),
                Text(
                  'New level unlocked!',
                  style: PlTypography.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (widget.type == CelebrationType.streakMilestone) ...[
                const SizedBox(height: PlSpacing.sm),
                Text(
                  'Keep the fire burning!',
                  style: PlTypography.bodyMedium.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getAnimationPath(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return 'assets/animations/level_up.json';
      case CelebrationType.streakMilestone:
        return 'assets/animations/streak_milestone.json';
      case CelebrationType.taskComplete:
        return 'assets/animations/task_complete.json';
      case CelebrationType.goalComplete:
        return 'assets/animations/level_up.json';
      case CelebrationType.templateCreated:
        return 'assets/animations/level_up.json';
      case CelebrationType.unlockable:
        return 'assets/animations/level_up.json';
    }
  }

  String _getDefaultMessage(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return 'Level Up!';
      case CelebrationType.streakMilestone:
        return 'Streak Milestone!';
      case CelebrationType.taskComplete:
        return 'Task Completed!';
      case CelebrationType.goalComplete:
        return 'Goal Achieved!';
      case CelebrationType.templateCreated:
        return 'Template Created!';
      case CelebrationType.unlockable:
        return 'New Unlockable!';
    }
  }
}

class CelebrationBanner extends StatelessWidget {
  final CelebrationType type;
  final String message;
  final VoidCallback? onDismiss;

  const CelebrationBanner({
    super.key,
    required this.type,
    required this.message,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(PlSpacing.md),
        padding: const EdgeInsets.all(PlSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _getTypeColor(type).withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getTypeColor(type).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Lottie.asset(
                _getAnimationPath(type),
                repeat: false,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: PlSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getTypeTitle(type),
                    style: PlTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getTypeColor(type),
                    ),
                  ),
                  const SizedBox(height: PlSpacing.xs),
                  Text(
                    message,
                    style: PlTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            if (onDismiss != null)
              IconButton(
                icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                onPressed: onDismiss,
              ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return Colors.amber;
      case CelebrationType.streakMilestone:
        return Colors.orange;
      case CelebrationType.taskComplete:
        return Colors.green;
      case CelebrationType.goalComplete:
        return Colors.blue;
      case CelebrationType.templateCreated:
        return Colors.purple;
      case CelebrationType.unlockable:
        return Colors.pink;
    }
  }

  String _getTypeTitle(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return 'Level Up!';
      case CelebrationType.streakMilestone:
        return 'Streak Milestone!';
      case CelebrationType.taskComplete:
        return 'Task Completed!';
      case CelebrationType.goalComplete:
        return 'Goal Achieved!';
      case CelebrationType.templateCreated:
        return 'Template Created!';
      case CelebrationType.unlockable:
        return 'New Unlockable!';
    }
  }

  String _getAnimationPath(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return 'assets/animations/level_up.json';
      case CelebrationType.streakMilestone:
        return 'assets/animations/streak_milestone.json';
      case CelebrationType.taskComplete:
        return 'assets/animations/task_complete.json';
      case CelebrationType.goalComplete:
        return 'assets/animations/level_up.json';
      case CelebrationType.templateCreated:
        return 'assets/animations/level_up.json';
      case CelebrationType.unlockable:
        return 'assets/animations/level_up.json';
    }
  }
}

class InlineCelebration extends StatelessWidget {
  final CelebrationType type;
  final String message;
  final double size;

  const InlineCelebration({
    super.key,
    required this.type,
    required this.message,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Lottie.asset(
            _getAnimationPath(type),
            repeat: false,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: PlSpacing.sm),
        Text(
          message,
          style: PlTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: _getTypeColor(type),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getTypeColor(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return Colors.amber;
      case CelebrationType.streakMilestone:
        return Colors.orange;
      case CelebrationType.taskComplete:
        return Colors.green;
      case CelebrationType.goalComplete:
        return Colors.blue;
      case CelebrationType.templateCreated:
        return Colors.purple;
      case CelebrationType.unlockable:
        return Colors.pink;
    }
  }

  String _getAnimationPath(CelebrationType type) {
    switch (type) {
      case CelebrationType.levelUp:
        return 'assets/animations/level_up.json';
      case CelebrationType.streakMilestone:
        return 'assets/animations/streak_milestone.json';
      case CelebrationType.taskComplete:
        return 'assets/animations/task_complete.json';
      case CelebrationType.goalComplete:
        return 'assets/animations/level_up.json';
      case CelebrationType.templateCreated:
        return 'assets/animations/level_up.json';
      case CelebrationType.unlockable:
        return 'assets/animations/level_up.json';
    }
  }
}