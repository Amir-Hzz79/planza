import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart'
    show Hobby, HobbiesCompanion, HobbySession, HobbySessionsCompanion;
import 'package:uuid/uuid.dart';

class HobbyModel {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String frequency;
  final String? customFrequencyJson;
  final int? targetDurationMinutes;
  final int? goalId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const HobbyModel({
    required this.id,
    required this.name,
    this.description,
    required this.category,
    this.icon,
    this.color,
    required this.frequency,
    this.customFrequencyJson,
    this.targetDurationMinutes,
    this.goalId,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  HobbyModel copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    int? icon,
    int? color,
    String? frequency,
    String? customFrequencyJson,
    int? targetDurationMinutes,
    int? goalId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HobbyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      frequency: frequency ?? this.frequency,
      customFrequencyJson: customFrequencyJson ?? this.customFrequencyJson,
      targetDurationMinutes:
          targetDurationMinutes ?? this.targetDurationMinutes,
      goalId: goalId ?? this.goalId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'icon': icon,
      'color': color,
      'frequency': frequency,
      'customFrequencyJson': customFrequencyJson,
      'targetDurationMinutes': targetDurationMinutes,
      'goalId': goalId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static HobbyModel fromJson(Map<String, dynamic> json) {
    return HobbyModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      icon: json['icon'] as int?,
      color: json['color'] as int?,
      frequency: json['frequency'] as String,
      customFrequencyJson: json['customFrequencyJson'] as String,
      targetDurationMinutes: json['targetDurationMinutes'] as int?,
      goalId: json['goalId'] as int?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  factory HobbyModel.fromEntity(Hobby entity) {
    return HobbyModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      category: entity.category,
      icon: entity.icon,
      color: entity.color,
      frequency: entity.frequency,
      customFrequencyJson: entity.customFrequencyJson,
      targetDurationMinutes: entity.targetDurationMinutes,
      goalId: entity.goalId,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Hobby toEntity() {
    return Hobby(
      id: id,
      name: name,
      description: description,
      category: category,
      icon: icon,
      color: color,
      frequency: frequency,
      customFrequencyJson: customFrequencyJson,
      targetDurationMinutes: targetDurationMinutes,
      goalId: goalId,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  HobbiesCompanion toInsertCompanion() {
    return HobbiesCompanion(
      name: Value(name),
      description: Value(description),
      category: Value(category),
      icon: Value(icon),
      color: Value(color),
      frequency: Value(frequency),
      customFrequencyJson: customFrequencyJson != null
          ? Value(customFrequencyJson!)
          : const Value.absent(),
      targetDurationMinutes: targetDurationMinutes != null
          ? Value(targetDurationMinutes!)
          : const Value.absent(),
      goalId: goalId != null ? Value(goalId!) : const Value.absent(),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  HobbiesCompanion toUpdateCompanion() {
    return HobbiesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      category: Value(category),
      icon: Value(icon),
      color: Value(color),
      frequency: Value(frequency),
      customFrequencyJson: customFrequencyJson != null
          ? Value(customFrequencyJson!)
          : const Value.absent(),
      targetDurationMinutes: targetDurationMinutes != null
          ? Value(targetDurationMinutes!)
          : const Value.absent(),
      goalId: goalId != null ? Value(goalId!) : const Value.absent(),
      isActive: Value(isActive),
      updatedAt: Value(DateTime.now()),
    );
  }
}
