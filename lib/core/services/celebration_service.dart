import 'package:flutter/material.dart';
import 'package:planza/core/design/composites/celebration.dart';
import 'package:planza/core/data/models/user_stats_model.dart';

class CelebrationService {
  static final CelebrationService _instance = CelebrationService._internal();
  factory CelebrationService() => _instance;
  CelebrationService._internal();

  BuildContext? _context;

  void initialize(BuildContext context) {
    _context = context;
  }

  void checkAndShowCelebrations({
    required UserStatsModel previousStats,
    required UserStatsModel currentStats,
  }) {
    if (_context == null) return;

    // Check for level up
    if (currentStats.level > previousStats.level) {
      _showLevelUpCelebration(currentStats.level);
      return;
    }

    // Check for streak milestones
    final currentStreak = currentStats.currentStreak;
    final previousStreak = previousStats.currentStreak;

    if (currentStreak > previousStreak) {
      final milestones = [3, 7, 14, 30, 60, 100, 365];
      for (final milestone in milestones) {
        if (previousStreak < milestone && currentStreak >= milestone) {
          _showStreakMilestoneCelebration(currentStreak);
          return;
        }
      }
    }

    // Check for unlockables
    _checkUnlockables(previousStats, currentStats);
  }

  void _showLevelUpCelebration(int newLevel) {
    if (_context == null) return;
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (context) => CelebrationOverlay(
        type: CelebrationType.levelUp,
        message: 'You reached Level $newLevel!',
        duration: const Duration(seconds: 4),
        onComplete: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _showStreakMilestoneCelebration(int streak) {
    if (_context == null) return;
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (context) => CelebrationOverlay(
        type: CelebrationType.streakMilestone,
        message: '$streak Day Streak!',
        duration: const Duration(seconds: 4),
        onComplete: () => Navigator.of(context).pop(),
      ),
    );
  }

  void showTaskCompleteCelebration() {
    if (_context == null) return;
    ScaffoldMessenger.of(_context!).showMaterialBanner(
      MaterialBanner(
        content: CelebrationBanner(
          type: CelebrationType.taskComplete,
          message: 'Task completed! +10 XP',
          onDismiss: () => ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner(),
        ),
        leading: const SizedBox.shrink(),
        actions: const [],
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (_context != null) {
        ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner();
      }
    });
  }

  void showGoalCompleteCelebration() {
    if (_context == null) return;
    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (context) => CelebrationOverlay(
        type: CelebrationType.goalComplete,
        message: 'Goal Achieved! +100 XP',
        duration: const Duration(seconds: 4),
        onComplete: () => Navigator.of(context).pop(),
      ),
    );
  }

  void showTemplateCreatedCelebration() {
    if (_context == null) return;
    ScaffoldMessenger.of(_context!).showMaterialBanner(
      MaterialBanner(
        content: CelebrationBanner(
          type: CelebrationType.templateCreated,
          message: 'Template created successfully!',
          onDismiss: () => ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner(),
        ),
        leading: const SizedBox.shrink(),
        actions: const [],
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (_context != null) {
        ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner();
      }
    });
  }

  void _checkUnlockables(UserStatsModel previous, UserStatsModel current) {
    // Check for new themes unlocked
    for (final themeId in current.unlockedThemes) {
      if (!previous.unlockedThemes.contains(themeId)) {
        _showUnlockableCelebration('New Theme Unlocked!', CelebrationType.unlockable);
        break;
      }
    }

    // Check for new icons unlocked
    for (final iconId in current.unlockedIcons) {
      if (!previous.unlockedIcons.contains(iconId)) {
        _showUnlockableCelebration('New Icon Unlocked!', CelebrationType.unlockable);
        break;
      }
    }

    // Check for new animations unlocked
    for (final animId in current.unlockedAnimations) {
      if (!previous.unlockedAnimations.contains(animId)) {
        _showUnlockableCelebration('New Animation Unlocked!', CelebrationType.unlockable);
        break;
      }
    }
  }

  void _showUnlockableCelebration(String message, CelebrationType type) {
    if (_context == null) return;
    ScaffoldMessenger.of(_context!).showMaterialBanner(
      MaterialBanner(
        content: CelebrationBanner(
          type: type,
          message: message,
          onDismiss: () => ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner(),
        ),
        leading: const SizedBox.shrink(),
        actions: const [],
      ),
    );
    Future.delayed(const Duration(seconds: 4), () {
      if (_context != null) {
        ScaffoldMessenger.of(_context!).hideCurrentMaterialBanner();
      }
    });
  }
}