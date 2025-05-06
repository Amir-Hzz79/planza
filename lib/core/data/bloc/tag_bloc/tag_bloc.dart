import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  }

  Future<void> _onLoadTags(
      StartWatchingTagsEvent event, Emitter<TagState> emit) async {
    try {
      emit(TagLoadingState());
      _subscription?.cancel();
      _subscription = _tagDao.watchAllTagsWithTasks().listen(
        (goals) {
          add(TagsUpdatedEvent(goals));
        },
        onError: (error) {
          emit(TagErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(TagErrorState(e.toString()));
    }
  }

  void _onTagsUpdated(TagsUpdatedEvent event, Emitter<TagState> emit) {
    emit(TagsLoadedState(event.tags));
  }

  Future<void> _onTagAdded(TagAddedEvent event, Emitter<TagState> emit) async {
    emit(TagLoadingState());

    try {
      event.newTag.id = await _tagDao.insertTag(event.newTag);
    } catch (e) {
      emit(TagErrorState('Failed to Insert Tag'));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
