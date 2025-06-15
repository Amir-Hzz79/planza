part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class TaskLoadingState extends TaskState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class TasksLoadedState extends TaskState {
  final String _stateId = const Uuid().v4();
  final List<TaskModel> tasks;
  final List<TaskModel>? searchResults;
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

  TasksLoadedState(
    this.tasks, {
    this.searchResults,
  });

  @override
  List<Object> get props =>
      [_stateId, tasks, searchResults ?? <List<TaskModel>>[]];

  TasksLoadedState copyWith({
    List<TaskModel>? tasks,
    List<TaskModel>? searchResults,
  }) {
    return TasksLoadedState(
      tasks ?? this.tasks,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class TaskErrorState extends TaskState {
  final String _stateId = const Uuid().v4();

  final String message;

  TaskErrorState(this.message);

  @override
  List<Object> get props => [_stateId, message];
}
