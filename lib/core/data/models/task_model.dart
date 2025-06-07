import 'package:drift/drift.dart' show Value;
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../database/database.dart' show Goal, Task, TasksCompanion;
import 'tag_model.dart';

class TaskModel {
  final int? id;
  String title;
  String? description;
  bool get isCompleted => doneDate != null;
  DateTime? dueDate;
  DateTime? doneDate;
  final int? priority;
  final int? parentTaskId;
  GoalModel? goal;
  List<TagModel> tags;

  bool get isOverdue {
    if (dueDate == null) {
      return false;
    }
    return doneDate != null
        ? doneDate!.isAfter(dueDate!)
        : dueDate!.isBeforeToday();
  }

  int? get daysLeft => dueDate?.difference(DateTime.now()).inDays;

  // This constructor is correct.
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

  // --- THE FIX IS APPLIED HERE ---
  factory TaskModel.fromEntity(
    Task taskEntity, {
    Goal? goal,
    // The parameter is now nullable, removing the `const []` default.
    List<TagModel>? tags,
  }) {
    // Now, when the 'tags' parameter is omitted, it will be null.
    // This null value gets passed to the main constructor, which then correctly
    // initializes `this.tags` with a new, modifiable empty list `[]`.
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

  // No other changes are needed below this line.
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

  TasksCompanion toInsertCompanion() {
    return TasksCompanion(
      goalId: Value(goal?.id),
      title: Value(title),
      description: Value(description),
      dueDate: Value(dueDate),
      doneDate: Value(doneDate),
      priority: Value(priority),
      parentTaskId: Value(parentTaskId),
    );
  }
}