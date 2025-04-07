
import 'package:equatable/equatable.dart';

import '../../../core/data/models/goal_model.dart';

abstract class GoalEvent extends Equatable {
  @override
  List<Object> get props => [];
}
 
class StartWatchingGoalsEvent extends GoalEvent {}
 
class GoalsUpdatedEvent extends GoalEvent {
  final List<GoalModel> goals;
  GoalsUpdatedEvent(this.goals);
}