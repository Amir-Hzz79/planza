import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color, Colors, IconData, Icons;

import '../database/database.dart' show Template, TemplatesCompanion;
import 'goal_model.dart';
import 'task_model.dart';
import 'tag_model.dart';

class TemplateModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        icon,
        color,
        payloadJson,
        isBuiltin,
        createdAt,
        updatedAt,
      ];

  const TemplateModel({
    this.id,
    required this.name,
    this.description,
    required this.category,
    this.icon,
    this.color,
    required this.payloadJson,
    this.isBuiltin = false,
    required this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String name;
  final String? description;
  final String category;
  final IconData? icon;
  final Color? color;
  final String payloadJson;
  final bool isBuiltin;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Convert Template entity to TemplateModel
  factory TemplateModel.fromEntity(Template templateEntity) {
    return TemplateModel(
      id: templateEntity.id,
      name: templateEntity.name,
      description: templateEntity.description,
      category: templateEntity.category,
      icon: templateEntity.icon != null
          ? IconData(templateEntity.icon!, fontFamily: 'MaterialIcons')
          : null,
      color: templateEntity.color != null
          ? Color(templateEntity.color!)
          : null,
      payloadJson: templateEntity.payloadJson,
      isBuiltin: templateEntity.isBuiltin,
      createdAt: templateEntity.createdAt,
      updatedAt: templateEntity.updatedAt,
    );
  }

  // Convert TemplateModel to Template entity
  Template toEntity() {
    return Template(
      id: id ?? -1,
      name: name,
      description: description,
      category: category,
      icon: icon?.codePoint ?? Icons.extension.codePoint,
      color: color?.toARGB32() ?? Colors.grey.toARGB32(),
      payloadJson: payloadJson,
      isBuiltin: isBuiltin,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Convert TemplateModel to TemplatesCompanion for insertion
  TemplatesCompanion toInsertCompanion() {
    return TemplatesCompanion(
      name: Value(name),
      description: Value(description),
      category: Value(category),
      icon: Value(icon?.codePoint ?? Icons.extension.codePoint),
      color: Value(color?.toARGB32() ?? Colors.grey.toARGB32()),
      payloadJson: Value(payloadJson),
      isBuiltin: Value(isBuiltin),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  // Create a copy with updated fields
  TemplateModel copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    IconData? icon,
    Color? color,
    String? payloadJson,
    bool? isBuiltin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TemplateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      payloadJson: payloadJson ?? this.payloadJson,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Deserialize payloadJson to GoalModel + Tasks + Tags
  // This would be used when applying a template
  Map<String, dynamic> get decodedPayload {
    // In a real implementation, this would decode the JSON
    // For now, returning empty map as placeholder
    return {};
  }
}

// Category constants for built-in templates
class TemplateCategory {
  static const String habit = 'habit';
  static const String project = 'project';
  static const String learning = 'learning';
  static const String fitness = 'fitness';
  static const String custom = 'custom';

  static const List<String> all = [
    habit,
    project,
    learning,
    fitness,
    custom,
  ];
}