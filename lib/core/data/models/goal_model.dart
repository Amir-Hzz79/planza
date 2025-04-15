import 'package:flutter/material.dart' show Color;
import 'package:planza/core/data/models/task_model.dart';

import '../database/database.dart' show Goal, Task;

class GoalModel {
  final int id;
  final String name;
  final String? description;
  final DateTime? deadline;
  final bool completed;
  final Color color;
  final List<TaskModel> tasks;

  GoalModel({
    required this.id,
    required this.name,
    this.description,
    this.deadline,
    required this.completed,
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
      completed: goalEntity.completed,
      color: Color(goalEntity.color),
      tasks: sortTasks.map((task) => TaskModel.fromEntity(task)).toList(),
    );
  }

  // Convert a GoalModel to a Goal entity
  Goal toEntity() {
    return Goal(
      id: id,
      name: name,
      description: description,
      deadline: deadline,
      completed: completed,
      color: color.toARGB32(),
    );
  }
}
