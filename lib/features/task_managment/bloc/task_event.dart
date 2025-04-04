import 'package:equatable/equatable.dart';
import 'package:planza/core/data/models/task_model.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class TaskSubmittedEvent extends TaskEvent {
  final TaskModel task;

  TaskSubmittedEvent({required this.task});
}
