
import 'package:equatable/equatable.dart';

abstract class GoalEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadGoalsEvent extends GoalEvent {}