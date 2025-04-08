import 'package:drift/drift.dart' show Value;
import 'package:planza/core/data/models/goal_model.dart';

import '../database/database.dart' show Goal, Task, TasksCompanion;

class TaskModel {
  final int? id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final int? priority;
  final int? parentTaskId;
  final GoalModel? goal;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
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
      priority: taskEntity.priority,
      parentTaskId: taskEntity.parentTaskId,
    );
  }

  // Convert a TaskModel to a Task entity
  Task toEntity() {
    return Task(
      id: id ?? -1,
      title: title,
      description: description,
      isCompleted: isCompleted,
      dueDate: dueDate,
      priority: priority,
      parentTaskId: parentTaskId,
    );
  }

  // Convert a TaskModel to a Task entity
  TasksCompanion toInsertCompanion() {
    print('----------- Here -----------------');
    print('----------- goal?.id:${goal?.id} -----------------');
    print('----------- title:$title -----------------');
    return TasksCompanion(
      goalId: Value(goal?.id),
      title: Value(title),
      description: Value(description),
      isCompleted: Value(isCompleted),
      dueDate: Value(dueDate),
      priority: Value(priority),
      parentTaskId: Value(parentTaskId),
    );
  }
}
