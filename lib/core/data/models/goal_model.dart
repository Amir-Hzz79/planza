import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Color, Colors, IconData, Icons;
import 'package:planza/core/data/models/task_model.dart';

import '../database/database.dart' show Goal, GoalsCompanion;

class GoalModel extends Equatable {
  @override
  List<Object?> get props =>
      [id, name, description, deadline, icon, color, tasks];

  const GoalModel({
    this.id,
    required this.name,
    this.description,
    this.deadline,
    this.icon = Icons.golf_course_rounded,
    this.color = Colors.grey,
    this.tasks = const [],
  });

  final int? id;
  final String name;
  final String? description;
  final DateTime? deadline;
  final Color color;
  final IconData icon;
  final List<TaskModel> tasks;
  bool get isCompleted =>
      tasks.isNotEmpty &&
      !tasks.any(
        (task) => !task.isCompleted,
      );

  double get progress {
    if (tasks.isEmpty) return 0.0;
    return tasks.where((t) => t.isCompleted).length / tasks.length;
  }

  // A getter to find the completion date (the date of the last completed task)
  DateTime? get completedDate {
    if (!isCompleted || tasks.isEmpty) return null;
    DateTime? lastDate;
    for (final task in tasks) {
      if (task.doneDate != null) {
        if (lastDate == null || task.doneDate!.isAfter(lastDate)) {
          lastDate = task.doneDate;
        }
      }
    }
    return lastDate;
  }

  int get durationInDays {
    if (tasks.isEmpty) return 0;

    /* DateTime? earliestStart;
    DateTime? latestEnd;

    for (final task in tasks) {
      if (task.createdAt != null) {
        if (earliestStart == null || task.createdAt!.isBefore(earliestStart)) {
          earliestStart = task.createdAt;
        }
      }
      if (task.doneDate != null) {
        if (latestEnd == null || task.doneDate!.isAfter(latestEnd)) {
          latestEnd = task.doneDate;
        }
      }
    }

    if (earliestStart != null && latestEnd != null) {
      return latestEnd.difference(earliestStart).inDays;
    } */
    return 2;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalModel &&
          runtimeType == other.runtimeType &&
          id == other.id; // Ensure uniqueness based on ID

  @override
  int get hashCode => id.hashCode;

  // Convert a Goal entity to a GoalModel
  factory GoalModel.fromEntity(Goal goalEntity,
      {List<TaskModel> tasks = const []}) {
    List<TaskModel> sortTasks = [...tasks];
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
      icon: IconData(goalEntity.icon, fontFamily: 'MaterialIcons'),
      color: Color(goalEntity.color),
      tasks: sortTasks,
    );
  }

  // Convert a GoalModel to a Goal entity
  Goal toEntity() {
    return Goal(
      id: id ?? -1,
      name: name,
      description: description,
      deadline: deadline,
      icon: icon.codePoint,
      color: color.toARGB32(),
    );
  }

  GoalsCompanion toInsertCompanion() {
    return GoalsCompanion(
      name: Value(name),
      icon: Value(icon.codePoint),
      color: Value(color.toARGB32()),
      deadline: Value(deadline),
      description: Value(description),
    );
  }
}
