part of 'user_stats_bloc.dart';

abstract class UserStatsEvent extends Equatable {
  const UserStatsEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserStats extends UserStatsEvent {}

class AddXp extends UserStatsEvent {
  final int amount;

  const AddXp(this.amount);

  @override
  List<Object?> get props => [amount];
}

class UpdateStreak extends UserStatsEvent {
  final bool isActiveToday;

  const UpdateStreak(this.isActiveToday);

  @override
  List<Object?> get props => [isActiveToday];
}

class IncrementTasksCompleted extends UserStatsEvent {}

class IncrementGoalsCompleted extends UserStatsEvent {}

class IncrementTemplatesCreated extends UserStatsEvent {}

class UnlockTheme extends UserStatsEvent {
  final int themeId;

  const UnlockTheme(this.themeId);

  @override
  List<Object?> get props => [themeId];
}

class UnlockIcon extends UserStatsEvent {
  final int iconId;

  const UnlockIcon(this.iconId);

  @override
  List<Object?> get props => [iconId];
}

class UnlockAnimation extends UserStatsEvent {
  final int animationId;

  const UnlockAnimation(this.animationId);

  @override
  List<Object?> get props => [animationId];
}

class ResetStats extends UserStatsEvent {}