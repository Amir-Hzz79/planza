import 'package:equatable/equatable.dart';

import '../../../core/data/models/task_model.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;

  TaskLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
