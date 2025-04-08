import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';

import '../../../core/data/data_access_object/goal_dao.dart' show GoalDao;
import '../../../core/data/models/goal_model.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalDao _goalDao = GetIt.instance.get<GoalDao>();
  StreamSubscription<List<GoalModel>>? _subscription;

  GoalBloc() : super(GoalInitial()) {
    on<StartWatchingGoalsEvent>(_onLoadGoals);
    on<GoalsUpdatedEvent>(_onGoalsUpdated);
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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
