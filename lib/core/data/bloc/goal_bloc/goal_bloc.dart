import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../data_access_object/goal_dao.dart';
import '../../models/goal_model.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalDao _goalDao = GetIt.instance.get<GoalDao>();
  StreamSubscription<List<GoalModel>>? _subscription;

  GoalBloc() : super(GoalInitial()) {
    on<StartWatchingGoalsEvent>(_onLoadGoals);
    on<GoalsUpdatedEvent>(_onGoalsUpdated);
    on<GoalAddedEvent>(_onGoalAdded);
    on<GoalUpdatedEvent>(_onGoalUpdated);
    on<GoalDeletedEvent>(_onGoalDeleted);
    on<GoalAndItsTasksDeletedEvent>(_onGoalAndItsTasksDeleted);
  }

  Future<void> _onLoadGoals(
      StartWatchingGoalsEvent event, Emitter<GoalState> emit) async {
    emit(GoalLoadingState());
    await _subscription?.cancel();
    _subscription = _goalDao.watchAllGoalsWithTasksAndTags().listen(
      (goals) {
        add(GoalsUpdatedEvent(goals));
      },
      onError: (error) => emit(GoalErrorState(error.toString())),
    );
  }

  void _onGoalsUpdated(GoalsUpdatedEvent event, Emitter<GoalState> emit) {
    emit(GoalsLoadedState(event.goals));
  }

  Future<void> _onGoalAdded(
      GoalAddedEvent event, Emitter<GoalState> emit) async {
    final currentState = state;
    if (currentState is GoalsLoadedState) {
      final optimisticGoals = List<GoalModel>.from(currentState.goals)
        ..add(event.newGoal);

      emit(GoalsLoadedState(optimisticGoals));

      try {
        await _goalDao.insertGoalWithTasks(event.newGoal);
      } catch (e) {
        emit(GoalsLoadedState(currentState.goals));
        emit(GoalErrorState('Failed to add goal. Please try again.'));
      }
    }
  }

  /* Future<void> _onGoalUpdated(
      GoalUpdatedEvent event, Emitter<GoalState> emit) async {
    final currentState = state;
    if (currentState is GoalsLoadedState) {
      final optimisticGoals = currentState.goals.map((goal) {
        return goal.id == event.updatedGoal.id ? event.updatedGoal : goal;
      }).toList();

      emit(GoalsLoadedState(optimisticGoals));

      try {
        await _goalDao.updateGoal(event.updatedGoal);
      } catch (e) {
        emit(GoalsLoadedState(currentState.goals));
        emit(GoalErrorState('Failed to update goal. Please try again.'));
      }
    }
  } */

  Future<void> _onGoalUpdated(
      GoalUpdatedEvent event, Emitter<GoalState> emit) async {
    emit(GoalLoadingState());

    try {
      await _goalDao.updateGoalAndSyncTasks(
        updatedGoal: event.updatedGoal,
      );
    } catch (e) {
      emit(GoalErrorState('Failed to update goal. Please try again.'));
    }
  }

  Future<void> _onGoalAndItsTasksDeleted(
      GoalAndItsTasksDeletedEvent event, Emitter<GoalState> emit) async {
    final currentState = state;
    if (currentState is GoalsLoadedState) {
      final optimisticGoals = List<GoalModel>.from(currentState.goals)
        ..removeWhere((goal) => goal.id == event.goal.id);

      emit(GoalsLoadedState(optimisticGoals));

      try {
        await _goalDao.deleteGoalAndItsTasks(event.goal.id!);
      } catch (e) {
        emit(GoalsLoadedState(currentState.goals));
        emit(GoalErrorState('Failed to delete goal. Please try again.'));
      }
    }
  }

  Future<void> _onGoalDeleted(
      GoalDeletedEvent event, Emitter<GoalState> emit) async {
    // This follows the same optimistic pattern
    final currentState = state;
    if (currentState is GoalsLoadedState) {
      final optimisticGoals = List<GoalModel>.from(currentState.goals)
        ..removeWhere((goal) => goal.id == event.goal.id);

      emit(GoalsLoadedState(optimisticGoals));

      try {
        // Call the new DAO method we will create next
        await _goalDao.deleteGoal(event.goal.id!);
      } catch (e) {
        emit(GoalsLoadedState(currentState.goals));
        emit(GoalErrorState('Failed to process goal. Please try again.'));
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
