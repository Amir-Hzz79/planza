part of 'hobbies_bloc.dart';

abstract class HobbiesState extends Equatable {
  const HobbiesState();

  @override
  List<Object?> get props => [];
}

class HobbiesInitial extends HobbiesState {}

class HobbiesLoading extends HobbiesState {}

class HobbiesLoaded extends HobbiesState {
  final List<HobbyModel> hobbies;

  const HobbiesLoaded({required this.hobbies});

  @override
  List<Object?> get props => [hobbies];
}

class HobbiesError extends HobbiesState {
  final String message;

  const HobbiesError(this.message);

  @override
  List<Object?> get props => [message];
}

class HobbiesActionInProgress extends HobbiesState {
  final String message;

  const HobbiesActionInProgress(this.message);

  @override
  List<Object?> get props => [message];
}

class HobbiesActionSuccess extends HobbiesState {
  final String message;

  const HobbiesActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class HobbySessionsLoaded extends HobbiesState {
  final List<HobbySessionModel> sessions;
  final HobbyStats stats;

  const HobbySessionsLoaded({
    required this.sessions,
    required this.stats,
  });

  @override
  List<Object?> get props => [sessions, stats];
}