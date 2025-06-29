part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartWatchingTasksEvent extends TaskEvent {}

class TasksUpdatedEvent extends TaskEvent {
  final List<TaskModel> tasks;

  TasksUpdatedEvent({required this.tasks});
}

class TaskAddedEvent extends TaskEvent {
  final TaskModel newTask;

  TaskAddedEvent({required this.newTask});
}

class TaskUpdatedEvent extends TaskEvent {
  final TaskModel newTask;

  TaskUpdatedEvent({required this.newTask});
}

class TaskDeletedEvent extends TaskEvent {
  final TaskModel task;

  TaskDeletedEvent({required this.task});
}

class SearchTasksRequested extends TaskEvent {
  final String query;
  SearchTasksRequested(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearch extends TaskEvent {}
