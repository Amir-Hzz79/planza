part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartWatchingGoalsEvent extends GoalEvent {}

class GoalsUpdatedEvent extends GoalEvent {
  final List<GoalModel> goals;
  GoalsUpdatedEvent(this.goals);
}

class GoalAddedEvent extends GoalEvent {
  final GoalModel newGoal;

  GoalAddedEvent({required this.newGoal});
}
