part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class GoalLoadingState extends GoalState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class GoalsLoadedState extends GoalState {
  final String _stateId = const Uuid().v4();
  final List<GoalModel> goals;

  GoalsLoadedState(this.goals);

  @override
  List<Object> get props => [_stateId, goals];
}

class GoalErrorState extends GoalState {
  final String _stateId = const Uuid().v4();

  final String message;

  GoalErrorState(this.message);

  @override
  List<Object> get props => [_stateId, message];
}
