import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart' show UserStat, UserStatsCompanion;

class UserStatsModel {
  final int id;
  final int xp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastActiveDate;
  final int totalTasksCompleted;
  final int totalGoalsCompleted;
  final int totalTemplatesCreated;
  final List<int> unlockedThemes;
  final List<int> unlockedIcons;
  final List<int> unlockedAnimations;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserStatsModel({
    required this.id,
    required this.xp,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    this.lastActiveDate,
    required this.totalTasksCompleted,
    required this.totalGoalsCompleted,
    required this.totalTemplatesCreated,
    required this.unlockedThemes,
    required this.unlockedIcons,
    required this.unlockedAnimations,
    required this.createdAt,
    this.updatedAt,
  });

  UserStatsModel copyWith({
    int? id,
    int? xp,
    int? level,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastActiveDate,
    int? totalTasksCompleted,
    int? totalGoalsCompleted,
    int? totalTemplatesCreated,
    List<int>? unlockedThemes,
    List<int>? unlockedIcons,
    List<int>? unlockedAnimations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserStatsModel(
      id: id ?? this.id,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      totalTasksCompleted: totalTasksCompleted ?? this.totalTasksCompleted,
      totalGoalsCompleted: totalGoalsCompleted ?? this.totalGoalsCompleted,
      totalTemplatesCreated: totalTemplatesCreated ?? this.totalTemplatesCreated,
      unlockedThemes: unlockedThemes ?? this.unlockedThemes,
      unlockedIcons: unlockedIcons ?? this.unlockedIcons,
      unlockedAnimations: unlockedAnimations ?? this.unlockedAnimations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'xp': xp,
      'level': level,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
      'totalTasksCompleted': totalTasksCompleted,
      'totalGoalsCompleted': totalGoalsCompleted,
      'totalTemplatesCreated': totalTemplatesCreated,
      'unlockedThemes': unlockedThemes,
      'unlockedIcons': unlockedIcons,
      'unlockedAnimations': unlockedAnimations,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static UserStatsModel fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      id: json['id'] as int,
      xp: json['xp'] as int,
      level: json['level'] as int,
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.parse(json['lastActiveDate'] as String)
          : null,
      totalTasksCompleted: json['totalTasksCompleted'] as int,
      totalGoalsCompleted: json['totalGoalsCompleted'] as int,
      totalTemplatesCreated: json['totalTemplatesCreated'] as int,
      unlockedThemes: (json['unlockedThemes'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      unlockedIcons: (json['unlockedIcons'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      unlockedAnimations: (json['unlockedAnimations'] as List<dynamic>?)?.map((e) => e as int).toList() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  factory UserStatsModel.fromEntity(UserStat entity) {
    return UserStatsModel(
      id: entity.id,
      xp: entity.xp,
      level: entity.level,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      lastActiveDate: entity.lastActiveDate,
      totalTasksCompleted: entity.totalTasksCompleted,
      totalGoalsCompleted: entity.totalGoalsCompleted,
      totalTemplatesCreated: entity.totalTemplatesCreated,
      unlockedThemes: _decodeIntList(entity.unlockedThemes),
      unlockedIcons: _decodeIntList(entity.unlockedIcons),
      unlockedAnimations: _decodeIntList(entity.unlockedAnimations),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserStat toEntity() {
    return UserStat(
      id: id,
      xp: xp,
      level: level,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastActiveDate: lastActiveDate,
      totalTasksCompleted: totalTasksCompleted,
      totalGoalsCompleted: totalGoalsCompleted,
      totalTemplatesCreated: totalTemplatesCreated,
      unlockedThemes: _encodeIntList(unlockedThemes),
      unlockedIcons: _encodeIntList(unlockedIcons),
      unlockedAnimations: _encodeIntList(unlockedAnimations),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserStatsCompanion toCompanion({bool nullToAbsent = false}) {
    return UserStatsCompanion(
      id: Value(id),
      xp: Value(xp),
      level: Value(level),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastActiveDate: lastActiveDate != null ? Value(lastActiveDate!) : (nullToAbsent ? const Value.absent() : Value(null)),
      totalTasksCompleted: Value(totalTasksCompleted),
      totalGoalsCompleted: Value(totalGoalsCompleted),
      totalTemplatesCreated: Value(totalTemplatesCreated),
      unlockedThemes: Value(_encodeIntList(unlockedThemes)),
      unlockedIcons: Value(_encodeIntList(unlockedIcons)),
      unlockedAnimations: Value(_encodeIntList(unlockedAnimations)),
      createdAt: Value(createdAt),
      updatedAt: updatedAt != null ? Value(updatedAt!) : (nullToAbsent ? const Value.absent() : Value(null)),
    );
  }

  static List<int> _decodeIntList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonString);
      return (decoded as List).map((e) => e as int).toList();
    } catch (_) {
      return [];
    }
  }

  static String _encodeIntList(List<int> list) {
    return jsonEncode(list);
  }

  int get xpForCurrentLevel {
    return xpForLevel(level);
  }

  int get xpForNextLevel {
    return xpForLevel(level + 1);
  }

  int get xpProgressInCurrentLevel {
    return xp - xpForCurrentLevel;
  }

  int get xpNeededForNextLevel {
    return xpForNextLevel - xpForCurrentLevel;
  }

  double get levelProgress {
    final needed = xpNeededForNextLevel;
    if (needed <= 0) return 1.0;
    return (xpProgressInCurrentLevel / needed).clamp(0.0, 1.0);
  }

  static int xpForLevel(int level) {
    if (level <= 1) return 0;
    return 100 * (level - 1) * level ~/ 2;
  }

  String get levelTitle {
    if (level < 5) return 'Beginner';
    if (level < 10) return 'Explorer';
    if (level < 20) return 'Achiever';
    if (level < 35) return 'Master';
    if (level < 50) return 'Grandmaster';
    return 'Legend';
  }
}