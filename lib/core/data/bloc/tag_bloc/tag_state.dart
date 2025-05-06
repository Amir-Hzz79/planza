part of 'tag_bloc.dart';

abstract class TagState extends Equatable {
  @override
  List<Object> get props => [];
}

class TagInitial extends TagState {}

class TagLoadingState extends TagState {}

class TagsLoadedState extends TagState {
  final List<TagModel> tags;

  TagsLoadedState(this.tags);

  @override
  List<Object> get props => [tags];
}

class TagErrorState extends TagState {
  final String message;

  TagErrorState(this.message);

  @override
  List<Object> get props => [message];
}