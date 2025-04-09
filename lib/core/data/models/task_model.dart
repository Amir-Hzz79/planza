import 'package:drift/drift.dart' show Value;
import 'package:planza/core/data/models/goal_model.dart';

import '../database/database.dart' show Goal, Task, TasksCompanion;

class TaskModel {
  final int? id;
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime? dueDate;
  DateTime? doneDate;
  final int? priority;
  final int? parentTaskId;
  final GoalModel? goal;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    this.doneDate,
    this.priority,
    this.parentTaskId,
    this.goal,
  });

  // Convert a Task entity to a TaskModel
  factory TaskModel.fromEntity(Task taskEntity, {Goal? goal}) {
    return TaskModel(
      id: taskEntity.id,
      goal: goal == null ? null : GoalModel.fromEntity(goal),
      title: taskEntity.title,
      description: taskEntity.description,
      isCompleted: taskEntity.isCompleted,
      dueDate: taskEntity.dueDate,
      doneDate: taskEntity.doneDate,
      priority: taskEntity.priority,
      parentTaskId: taskEntity.parentTaskId,
    );
  }

  // Convert a TaskModel to a Task entity
  Task toEntity() {
    return Task(
      id: id ?? -1,
      goalId: goal?.id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      doneDate: doneDate,
      priority: priority,
      parentTaskId: parentTaskId,
    );
  }

  // Convert a TaskModel to a Task entity
  TasksCompanion toInsertCompanion() {
    return TasksCompanion(
      goalId: Value(goal?.id),
      title: Value(title),
      description: Value(description),
      isCompleted: Value(isCompleted),
      dueDate: Value(dueDate),
      doneDate: Value(doneDate),
      priority: Value(priority),
      parentTaskId: Value(parentTaskId),
    );
  }
}
