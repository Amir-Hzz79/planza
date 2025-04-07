part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TasksLoadedState extends TaskState {
  final List<TaskModel> tasks;

  List<TaskModel> filterOnDate(DateTime date) {
    return tasks
        .where(
          (element) =>
              element.dueDate == null ? false : element.dueDate!.sameDay(date),
        )
        .toList();
  }

  TasksLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
