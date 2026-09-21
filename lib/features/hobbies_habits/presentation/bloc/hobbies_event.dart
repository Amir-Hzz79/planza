part of 'hobbies_bloc.dart';

abstract class HobbiesEvent extends Equatable {
  const HobbiesEvent();

  @override
  List<Object?> get props => [];
}

class LoadHobbies extends HobbiesEvent {}

class AddHobby extends HobbiesEvent {
  final HobbyModel hobby;
  const AddHobby(this.hobby);
  @override
  List<Object?> get props => [hobby];
}

class UpdateHobby extends HobbiesEvent {
  final HobbyModel hobby;
  const UpdateHobby(this.hobby);
  @override
  List<Object?> get props => [hobby];
}

class DeleteHobby extends HobbiesEvent {
  final int hobbyId;
  const DeleteHobby(this.hobbyId);
  @override
  List<Object?> get props => [hobbyId];
}

class ToggleHobbyActive extends HobbiesEvent {
  final int hobbyId;
  const ToggleHobbyActive(this.hobbyId);
  @override
  List<Object?> get props => [hobbyId];
}

class StartHobbySession extends HobbiesEvent {
  final int hobbyId;
  const StartHobbySession(this.hobbyId);
  @override
  List<Object?> get props => [hobbyId];
}

class EndHobbySession extends HobbiesEvent {
  final int sessionId;
  final int? mood;
  final String? notes;
  const EndHobbySession(this.sessionId, {this.mood, this.notes});
  @override
  List<Object?> get props => [sessionId, mood, notes];
}

class LoadHobbySessions extends HobbiesEvent {
  final int hobbyId;
  const LoadHobbySessions(this.hobbyId);
  @override
  List<Object?> get props => [hobbyId];
}

class RefreshHobbies extends HobbiesEvent {}