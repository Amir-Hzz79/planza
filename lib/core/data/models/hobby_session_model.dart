import 'package:drift/drift.dart';
import 'package:planza/core/data/database/database.dart' show HobbySession, HobbySessionsCompanion;

class HobbySessionModel {
  final int id;
  final int hobbyId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final int? mood;
  final String? notes;
  final DateTime createdAt;

  const HobbySessionModel({
    required this.id,
    required this.hobbyId,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    this.mood,
    this.notes,
    required this.createdAt,
  });

  HobbySessionModel copyWith({
    int? id,
    int? hobbyId,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    int? mood,
    String? notes,
    DateTime? createdAt,
  }) {
    return HobbySessionModel(
      id: id ?? this.id,
      hobbyId: hobbyId ?? this.hobbyId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      mood: mood ?? this.mood,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hobbyId': hobbyId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'durationMinutes': durationMinutes,
      'mood': mood,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static HobbySessionModel fromJson(Map<String, dynamic> json) {
    return HobbySessionModel(
      id: json['id'] as int,
      hobbyId: json['hobbyId'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      durationMinutes: json['durationMinutes'] as int?,
      mood: json['mood'] as int?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  factory HobbySessionModel.fromEntity(HobbySession entity) {
    return HobbySessionModel(
      id: entity.id,
      hobbyId: entity.hobbyId ?? 0,
      startTime: entity.startTime,
      endTime: entity.endTime,
      durationMinutes: entity.durationMinutes,
      mood: entity.mood,
      notes: entity.notes,
      createdAt: entity.createdAt,
    );
  }

  HobbySession toEntity() {
    return HobbySession(
      id: id,
      hobbyId: hobbyId,
      startTime: startTime,
      endTime: endTime,
      durationMinutes: durationMinutes,
      mood: mood,
      notes: notes,
      createdAt: createdAt,
    );
  }

  HobbySessionsCompanion toInsertCompanion() {
    return HobbySessionsCompanion(
      hobbyId: Value(hobbyId),
      startTime: Value(startTime),
      endTime: endTime != null ? Value(endTime!) : const Value.absent(),
      durationMinutes: durationMinutes != null ? Value(durationMinutes!) : const Value.absent(),
      mood: mood != null ? Value(mood!) : const Value.absent(),
      notes: notes != null ? Value(notes!) : const Value.absent(),
      createdAt: Value(createdAt),
    );
  }

  HobbySessionsCompanion toUpdateCompanion() {
    return HobbySessionsCompanion(
      id: Value(id),
      hobbyId: Value(hobbyId),
      startTime: Value(startTime),
      endTime: endTime != null ? Value(endTime!) : const Value.absent(),
      durationMinutes: durationMinutes != null ? Value(durationMinutes!) : const Value.absent(),
      mood: mood != null ? Value(mood!) : const Value.absent(),
      notes: notes != null ? Value(notes!) : const Value.absent(),
    );
  }
}