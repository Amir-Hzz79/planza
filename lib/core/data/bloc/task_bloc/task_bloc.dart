import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:equatable/equatable.dart';
import '../../data_access_object/task_dao.dart';

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
    try {
      _subscription?.cancel();
      _subscription = _taskDao.watchAllTasks().listen(
        (tasks) {
          add(
            TasksUpdatedEvent(tasks: tasks),
          );
        },
      );
    } catch (e) {
      emit(TaskErrorState('Failed to load Tasks'));
    }
  }

  Future<void> _onTasksUpdated(
      TasksUpdatedEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoadedState(event.tasks));
  }

  Future<void> _onTaskAdded(
      TaskAddedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await _taskDao.insertTask(event.newTask);
    } catch (e) {
      emit(TaskErrorState('Failed to Insert Task'));
    }
  }

  Future<void> _onTaskUpdated(
      TaskUpdatedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await _taskDao.updateTask(event.newTask);
    } catch (e) {
      emit(TaskErrorState('Failed to Update Task'));
    }
  }

  Future<void> _onTaskDeleted(
      TaskDeletedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await _taskDao.deleteTask(event.task.id!);
    } catch (e) {
      emit(TaskErrorState('Failed to Update Task'));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
