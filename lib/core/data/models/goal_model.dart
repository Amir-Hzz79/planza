import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show Color;
import 'package:planza/core/data/models/task_model.dart';

import '../database/database.dart' show Goal, GoalsCompanion, Task;

class GoalModel {
  int? id;
  final String name;
  final String? description;
  final DateTime? deadline;
  final Color color;
  final List<TaskModel> tasks;
  bool get isCompleted => !tasks.any(
        (task) => !task.isCompleted,
      );

  GoalModel({
    this.id,
    required this.name,
    this.description,
    this.deadline,
    required this.color,
    this.tasks = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalModel &&
          runtimeType == other.runtimeType &&
          id == other.id; // Ensure uniqueness based on ID

  @override
  int get hashCode => id.hashCode;

  // Convert a Goal entity to a GoalModel
  factory GoalModel.fromEntity(Goal goalEntity, {List<Task> tasks = const []}) {
    List<Task> sortTasks = [...tasks];
    sortTasks.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) {
        return 0;
      } else if (a.dueDate == null) {
        return 1; // Null values go to the end
      } else if (b.dueDate == null) {
        return -1; // Null values go to the end
      }
      return a.dueDate!.compareTo(b.dueDate!); // Compare non-null dates
    });

    return GoalModel(
      id: goalEntity.id,
      name: goalEntity.name,
      description: goalEntity.description,
      deadline: goalEntity.deadline,
      color: Color(goalEntity.color),
      tasks: sortTasks.map((task) => TaskModel.fromEntity(task)).toList(),
    );
  }

  // Convert a GoalModel to a Goal entity
  Goal toEntity() {
    return Goal(
      id: id ?? -1,
      name: name,
      description: description,
      deadline: deadline,
      color: color.toARGB32(),
    );
  }

  GoalsCompanion toInsertCompanion() {
    return GoalsCompanion(
      name: Value(name),
      color: Value(color.toARGB32()),
      deadline: Value(deadline),
      description: Value(description),
    );
  }
}
