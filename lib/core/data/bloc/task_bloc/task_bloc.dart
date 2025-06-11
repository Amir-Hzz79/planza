import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/task_dao.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskDao _taskDao = GetIt.instance.get<TaskDao>();
  StreamSubscription<List<TaskModel>>? _subscription;

  TaskBloc() : super(TaskInitial()) {
    on<StartWatchingTasksEvent>(_onLoadTasks);
    on<TasksUpdatedEvent>(_onTasksUpdated);
    on<TaskAddedEvent>(_onTaskAdded);
    on<TaskUpdatedEvent>(_onTaskUpdated);
    on<TaskDeletedEvent>(_onTaskDeleted);
  }

  Future<void> _onLoadTasks(
      StartWatchingTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    await _subscription?.cancel();
    _subscription = _taskDao.watchAllTasks().listen(
      (tasks) {
        add(TasksUpdatedEvent(tasks: tasks));
      },
      onError: (error) => emit(TaskErrorState('Failed to watch tasks')),
    );
  }

  void _onTasksUpdated(TasksUpdatedEvent event, Emitter<TaskState> emit) {
    emit(TasksLoadedState(event.tasks));
  }

  Future<void> _onTaskAdded(
      TaskAddedEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TasksLoadedState) {
      // Create an "optimistic" list by adding the new task immediately.
      final optimisticTasks = List<TaskModel>.from(currentState.tasks)
        ..add(event.newTask);

      emit(TasksLoadedState(optimisticTasks));

      try {
        await _taskDao.insertTask(event.newTask);
      } catch (e) {
        // If the database call fails, revert the UI to the previous state and show an error.
        emit(TasksLoadedState(currentState.tasks));
        emit(TaskErrorState('Failed to add task. Please try again.'));
      }
    }
  }

  Future<void> _onTaskUpdated(
      TaskUpdatedEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TasksLoadedState) {
      // Create an optimistic list by finding and replacing the updated task.
      final optimisticTasks = currentState.tasks.map((task) {
        return task.id == event.newTask.id ? event.newTask : task;
      }).toList();

      // Emit immediately for an instant UI update.
      emit(TasksLoadedState(optimisticTasks));

      try {
        await _taskDao.updateTask(event.newTask);
      } catch (e) {
        emit(TasksLoadedState(currentState.tasks));
        emit(TaskErrorState('Failed to update task. Please try again.'));
      }
    }
  }

  Future<void> _onTaskDeleted(
      TaskDeletedEvent event, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TasksLoadedState) {
      // Create an optimistic list by removing the task.
      final optimisticTasks = List<TaskModel>.from(currentState.tasks)
        ..removeWhere((task) => task.id == event.task.id);

      // Emit immediately.
      emit(TasksLoadedState(optimisticTasks));

      try {
        await _taskDao.deleteTask(event.task.id!);
      } catch (e) {
        emit(TasksLoadedState(currentState.tasks));
        emit(TaskErrorState('Failed to delete task. Please try again.'));
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
