import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';

import '../../data_access_object/goal_dao.dart';
import '../../data_access_object/task_dao.dart';
import '../../models/goal_model.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalDao _goalDao = GetIt.instance.get<GoalDao>();
  final TaskDao _taskDao = GetIt.instance.get<TaskDao>();

  StreamSubscription<List<GoalModel>>? _subscription;

  GoalBloc() : super(GoalInitial()) {
    on<StartWatchingGoalsEvent>(_onLoadGoals);
    on<GoalsUpdatedEvent>(_onGoalsUpdated);
    on<GoalAddedEvent>(_onGoalAdded);
  }

  Future<void> _onLoadGoals(
      StartWatchingGoalsEvent event, Emitter<GoalState> emit) async {
    try {
      emit(GoalLoadingState());
      _subscription?.cancel();
      _subscription = _goalDao.watchAllGoalsWithTasks().listen(
        (goals) {
          add(GoalsUpdatedEvent(goals));
        },
        onError: (error) {
          emit(GoalErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(GoalErrorState(e.toString()));
    }
  }

  void _onGoalsUpdated(GoalsUpdatedEvent event, Emitter<GoalState> emit) {
    emit(GoalsLoadedState(event.goals));
  }

  Future<void> _onGoalAdded(
      GoalAddedEvent event, Emitter<GoalState> emit) async {
    emit(GoalLoadingState());

    try {
      event.newGoal.id = await _goalDao.insertGoal(event.newGoal);

      for (var task in event.newGoal.tasks) {
        task.goal = event.newGoal;
      }

      await _taskDao.insertAllTasks(event.newGoal.tasks);
    } catch (e) {
      emit(GoalErrorState('Failed to Insert Goal'));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
