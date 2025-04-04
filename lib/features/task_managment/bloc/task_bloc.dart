import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/data/data_access_object/task_dao.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskDao _taskDao = GetIt.instance.get<TaskDao>();

  TaskBloc() : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<TaskSubmittedEvent>(_onSubmittedTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await _taskDao.getAllTasks();

      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState('خطا در بارگیری اهداف'));
    }
  }

  Future<void> _onSubmittedTask(
      TaskSubmittedEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await _taskDao.insertTask(event.task);
      final tasks = await _taskDao.getAllTasks();

      emit(TaskLoadedState(tasks));
    } catch (e) {
      emit(TaskErrorState('خطا در بارگیری اهداف'));
    }
  }
}
