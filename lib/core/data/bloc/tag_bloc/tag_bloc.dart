import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../data_access_object/tag_dao.dart';
import '../../models/tag_model.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagDao _tagDao = GetIt.instance.get<TagDao>();
  StreamSubscription<List<TagModel>>? _subscription;

  TagBloc() : super(TagInitial()) {
    on<StartWatchingTagsEvent>(_onLoadTags);
    on<TagsUpdatedEvent>(_onTagsUpdated);
    on<TagAddedEvent>(_onTagAdded);
    on<TagUpdatedEvent>(_onTagUpdated);
    on<TagDeletedEvent>(_onTagDeleted);
  }

  Future<void> _onLoadTags(
      StartWatchingTagsEvent event, Emitter<TagState> emit) async {
    emit(TagLoadingState());
    await _subscription?.cancel();
    _subscription = _tagDao.watchAllTagsWithTasks().listen(
          (tags) => add(TagsUpdatedEvent(tags)),
          onError: (error) => emit(TagErrorState(error.toString())),
        );
  }

  void _onTagsUpdated(TagsUpdatedEvent event, Emitter<TagState> emit) {
    emit(TagsLoadedState(event.tags));
  }

  Future<void> _onTagAdded(TagAddedEvent event, Emitter<TagState> emit) async {
    final currentState = state;
    if (currentState is TagsLoadedState) {
      final optimisticTags = List<TagModel>.from(currentState.tags)
        ..add(event.newTag);

      emit(TagsLoadedState(optimisticTags));

      try {
        await _tagDao.insertTag(event.newTag);
      } catch (e) {
        emit(TagsLoadedState(currentState.tags));
        emit(TagErrorState('Failed to add tag. Please try again.'));
      }
    }
  }

  Future<void> _onTagUpdated(
      TagUpdatedEvent event, Emitter<TagState> emit) async {
    final currentState = state;
    if (currentState is TagsLoadedState) {
      final optimisticTags = currentState.tags.map((tag) {
        return tag.id == event.updatedTag.id ? event.updatedTag : tag;
      }).toList();

      emit(TagsLoadedState(optimisticTags));

      try {
        await _tagDao.updateTag(event.updatedTag);
      } catch (e) {
        emit(TagsLoadedState(currentState.tags));
        emit(TagErrorState('Failed to update tag. Please try again.'));
      }
    }
  }

  Future<void> _onTagDeleted(
      TagDeletedEvent event, Emitter<TagState> emit) async {
    final currentState = state;
    if (currentState is TagsLoadedState) {
      final optimisticTags = List<TagModel>.from(currentState.tags)
        ..removeWhere((tag) => tag.id == event.tag.id);

      emit(TagsLoadedState(optimisticTags));

      try {
        await _tagDao.deleteTag(event.tag.id);
      } catch (e) {
        emit(TagsLoadedState(currentState.tags));
        emit(TagErrorState('Failed to delete tag. Please try again.'));
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
