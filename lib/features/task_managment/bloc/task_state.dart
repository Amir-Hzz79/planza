part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TasksLoadedState extends TaskState {
  final List<TaskModel> tasks;

  /*  List<TaskModel> filterOnDate(DateTime date) {
    return tasks
        .where(
          (element) =>
              element.dueDate == null ? false : element.dueDate!.sameDay(date),
        )
        .toList();
  }

  List<TaskModel> get pastTasks => tasks
      .where(
        (task) => task.dueDate?.isBeforeToday() ?? false,
      )
      .toList();

  List<TaskModel> get todayTasks => tasks
      .where(
        (task) => task.dueDate?.isToday() ?? false,
      )
      .toList();

  List<TaskModel> get futureTasks => tasks
      .where(
        (task) => task.dueDate?.isAfterToday() ?? false,
      )
      .toList(); */

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
