part of 'tag_bloc.dart';

abstract class TagState extends Equatable {
  @override
  List<Object> get props => [];
}

class TagInitial extends TagState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class TagLoadingState extends TagState {
  final String _stateId = const Uuid().v4();

  @override
  List<Object> get props => [_stateId];
}

class TagsLoadedState extends TagState {
  final String _stateId = const Uuid().v4();

  final List<TagModel> tags;

  TagsLoadedState(this.tags);

  @override
  List<Object> get props => [_stateId, tags];
}

class TagErrorState extends TagState {
  final String _stateId = const Uuid().v4();
  final String message;

  TagErrorState(this.message);

  @override
  List<Object> get props => [_stateId, message];
}
