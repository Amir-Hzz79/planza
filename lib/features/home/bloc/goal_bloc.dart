import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/data/data_access_object/goal_dao.dart' show GoalDao;
import 'goal_evet.dart';
import 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalDao _goalDao = GetIt.instance.get<GoalDao>();

  GoalBloc() : super(GoalInitial()) {
    on<LoadGoalsEvent>(_onLoadGoals);
  }

  Future<void> _onLoadGoals(LoadGoalsEvent event, Emitter<GoalState> emit) async {
    emit(GoalLoadingState());
    try {
      final goals = await _goalDao.getAllGoalsWithTasks();
      emit(GoalLoadedState(goals));
    } catch (e) {
      emit(GoalErrorState('خطا در بارگیری اهداف'));
    }
  }
}
