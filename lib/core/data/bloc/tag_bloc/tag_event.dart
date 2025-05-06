part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartWatchingTagsEvent extends TagEvent {}

class TagsUpdatedEvent extends TagEvent {
  final List<TagModel> tags;
  TagsUpdatedEvent(this.tags);
}

class TagAddedEvent extends TagEvent {
  final TagModel newTag;

  TagAddedEvent({required this.newTag});
}
