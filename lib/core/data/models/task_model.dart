import 'package:drift/drift.dart' show Value;
import 'package:equatable/equatable.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../database/database.dart' show Goal, Task, TasksCompanion;
import 'tag_model.dart';

class TaskModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        doneDate,
        dueDate,
        priority,
        parentTaskId,
        goal,
        tags
      ];

  final int? id;
  final String title;
  final String? description;
  bool get isCompleted => doneDate != null;
  final DateTime? dueDate;
  final DateTime? doneDate;
  final int? priority;
  final int? parentTaskId;
  final GoalModel? goal;
  final List<TagModel> tags;

  bool get isOverdue {
    if (dueDate == null) {
      return false;
    }
    return doneDate != null
        ? doneDate!.isAfter(dueDate!)
        : dueDate!.isBeforeToday();
  }

  int? get daysLeft => dueDate?.difference(DateTime.now()).inDays;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.doneDate,
    this.priority,
    this.parentTaskId,
    this.goal,
    List<TagModel>? tags,
  }) : tags = tags ?? [];

  factory TaskModel.fromEntity(
    Task taskEntity, {
    Goal? goal,
    List<TagModel>? tags,
  }) {
    return TaskModel(
      id: taskEntity.id,
      goal: goal == null ? null : GoalModel.fromEntity(goal),
      title: taskEntity.title,
      description: taskEntity.description,
      dueDate: taskEntity.dueDate,
      doneDate: taskEntity.doneDate,
      priority: taskEntity.priority,
      parentTaskId: taskEntity.parentTaskId,
      tags: tags,
    );
  }

  Task toEntity() {
    return Task(
      id: id ?? -1,
      goalId: goal?.id,
      title: title,
      description: description,
      dueDate: dueDate,
      doneDate: doneDate,
      priority: priority,
      parentTaskId: parentTaskId,
    );
  }

  TasksCompanion toCompanion() {
    return TasksCompanion(
      id: id == null ? Value.absent() : Value(id!),
      goalId: Value.absentIfNull(goal?.id),
      title: Value(title),
      description: Value(description),
      dueDate: Value(dueDate),
      doneDate: Value(doneDate),
      priority: Value(priority),
      parentTaskId: Value(parentTaskId),
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? doneDate,
    int? priority,
    GoalModel? goal,
    List<TagModel>? tags,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      doneDate: doneDate ?? this.doneDate,
      priority: priority ?? this.priority,
      goal: goal ?? this.goal,
      tags: tags ?? List.from(this.tags),
    );
  }
}
