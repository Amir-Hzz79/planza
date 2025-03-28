import 'package:equatable/equatable.dart';

import '../../../core/data/models/goal_model.dart';

abstract class GoalState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {}

class GoalLoadingState extends GoalState {}

class GoalLoadedState extends GoalState {
  final List<GoalModel> goals;

  GoalLoadedState(this.goals);

  @override
  List<Object> get props => [goals];
}

class GoalErrorState extends GoalState {
  final String message;

  GoalErrorState(this.message);

  @override
  List<Object> get props => [message];
}
