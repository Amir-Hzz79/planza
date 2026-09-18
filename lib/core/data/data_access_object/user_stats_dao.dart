import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart';

import '../database/tables.dart';
import '../models/user_stats_model.dart';

part 'user_stats_dao.g.dart';

@DriftAccessor(tables: [UserStats])
class UserStatsDao extends DatabaseAccessor<AppDatabase> with _$UserStatsDaoMixin {
  UserStatsDao(super.attachedDatabase);

  Stream<UserStatsModel?> watchUserStats() {
    return select(userStats).watchSingleOrNull().map((row) {
      if (row == null) return null;
      return UserStatsModel.fromEntity(row);
    });
  }

  Future<UserStatsModel?> getUserStats() async {
    final row = await select(userStats).getSingleOrNull();
    if (row == null) return null;
    return UserStatsModel.fromEntity(row);
  }

  Future<int> insertUserStats(UserStatsModel stats) async {
    return await into(userStats).insert(stats.toCompanion());
  }

  Future<bool> updateUserStats(UserStatsModel stats) =>
      update(userStats).replace(stats.toCompanion(nullToAbsent: true));

  Future<int> deleteUserStats() => delete(userStats).go();

  Future<UserStatsModel> getOrCreateUserStats() async {
    final existing = await getUserStats();
    if (existing != null) return existing;

    final newStats = UserStatsModel(
      id: 1,
      xp: 0,
      level: 1,
      currentStreak: 0,
      longestStreak: 0,
      totalTasksCompleted: 0,
      totalGoalsCompleted: 0,
      totalTemplatesCreated: 0,
      unlockedThemes: [0],
      unlockedIcons: [],
      unlockedAnimations: [],
      createdAt: DateTime.now(),
    );

    await insertUserStats(newStats);
    return newStats;
  }

  Future<void> addXp(int amount) async {
    final stats = await getOrCreateUserStats();
    final newXp = stats.xp + amount;
    int newLevel = stats.level;

    while (newXp >= UserStatsModel.xpForLevel(newLevel + 1)) {
      newLevel++;
    }

    final updated = stats.copyWith(
      xp: newXp,
      level: newLevel,
      updatedAt: DateTime.now(),
    );
    await updateUserStats(updated);
  }

  Future<void> updateStreak(bool isActiveToday) async {
    final stats = await getOrCreateUserStats();
    final today = DateTime.now();
    final lastActive = stats.lastActiveDate;

    int newCurrentStreak = stats.currentStreak;
    int newLongestStreak = stats.longestStreak;

    if (lastActive != null) {
      final diff = today.difference(lastActive).inDays;
      if (diff == 1 && isActiveToday) {
        newCurrentStreak += 1;
        if (newCurrentStreak > newLongestStreak) {
          newLongestStreak = newCurrentStreak;
        }
      } else if (diff > 1 && isActiveToday) {
        newCurrentStreak = 1;
      }
    } else if (isActiveToday) {
      newCurrentStreak = 1;
      if (newCurrentStreak > newLongestStreak) {
        newLongestStreak = newCurrentStreak;
      }
    }

    final updated = stats.copyWith(
      currentStreak: newCurrentStreak,
      longestStreak: newLongestStreak,
      lastActiveDate: isActiveToday ? today : lastActive,
      updatedAt: DateTime.now(),
    );
    await updateUserStats(updated);
  }

  Future<void> incrementTasksCompleted() async {
    final stats = await getOrCreateUserStats();
    final updated = stats.copyWith(
      totalTasksCompleted: stats.totalTasksCompleted + 1,
      updatedAt: DateTime.now(),
    );
    await updateUserStats(updated);
  }

  Future<void> incrementGoalsCompleted() async {
    final stats = await getOrCreateUserStats();
    final updated = stats.copyWith(
      totalGoalsCompleted: stats.totalGoalsCompleted + 1,
      updatedAt: DateTime.now(),
    );
    await updateUserStats(updated);
  }

  Future<void> incrementTemplatesCreated() async {
    final stats = await getOrCreateUserStats();
    final updated = stats.copyWith(
      totalTemplatesCreated: stats.totalTemplatesCreated + 1,
      updatedAt: DateTime.now(),
    );
    await updateUserStats(updated);
  }

  Future<void> unlockTheme(int themeId) async {
    final stats = await getOrCreateUserStats();
    if (!stats.unlockedThemes.contains(themeId)) {
      final newThemes = [...stats.unlockedThemes, themeId];
      final updated = stats.copyWith(
        unlockedThemes: newThemes,
        updatedAt: DateTime.now(),
      );
      await updateUserStats(updated);
    }
  }

  Future<void> unlockIcon(int iconId) async {
    final stats = await getOrCreateUserStats();
    if (!stats.unlockedIcons.contains(iconId)) {
      final newIcons = [...stats.unlockedIcons, iconId];
      final updated = stats.copyWith(
        unlockedIcons: newIcons,
        updatedAt: DateTime.now(),
      );
      await updateUserStats(updated);
    }
  }

  Future<void> unlockAnimation(int animationId) async {
    final stats = await getOrCreateUserStats();
    if (!stats.unlockedAnimations.contains(animationId)) {
      final newAnimations = [...stats.unlockedAnimations, animationId];
      final updated = stats.copyWith(
        unlockedAnimations: newAnimations,
        updatedAt: DateTime.now(),
      );
      await updateUserStats(updated);
    }
  }

  Future<void> resetStats() async {
    await deleteUserStats();
    await getOrCreateUserStats();
  }
}