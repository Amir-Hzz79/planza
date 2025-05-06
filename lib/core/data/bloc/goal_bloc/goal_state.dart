part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {}

class GoalLoadingState extends GoalState {}

class GoalsLoadedState extends GoalState {
  final List<GoalModel> goals;

  GoalsLoadedState(this.goals);

  @override
  List<Object> get props => [goals];
}

class GoalErrorState extends GoalState {
  final String message;

  GoalErrorState(this.message);

  @override
  List<Object> get props => [message];
}
