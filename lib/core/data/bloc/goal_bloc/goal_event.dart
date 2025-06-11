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

class GoalUpdatedEvent extends GoalEvent {
  final GoalModel updatedGoal;

  GoalUpdatedEvent({required this.updatedGoal});
}

class GoalDeletedEvent extends GoalEvent {
  final GoalModel goal;

  GoalDeletedEvent({required this.goal});
}

class GoalAndItsTasksDeletedEvent extends GoalEvent {
  final GoalModel goal;

  GoalAndItsTasksDeletedEvent({required this.goal});

  @override
  List<Object> get props => [goal];
}
