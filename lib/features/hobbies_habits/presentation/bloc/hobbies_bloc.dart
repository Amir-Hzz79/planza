import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/hobbies_dao.dart';
import 'package:planza/core/data/data_access_object/hobby_sessions_dao.dart';
import 'package:planza/core/data/models/hobby_model.dart';
import 'package:planza/core/data/models/hobby_session_model.dart';
import 'package:planza/core/utils/hobby_stats.dart';

part 'hobbies_event.dart';
part 'hobbies_state.dart';

class HobbiesBloc extends Bloc<HobbiesEvent, HobbiesState> {
  final HobbiesDao _hobbiesDao;
  final HobbySessionsDao _sessionsDao;
  final _statsCache = <int, HobbyStats>{};

  HobbiesBloc({
    HobbiesDao? hobbiesDao,
    HobbySessionsDao? sessionsDao,
  })  : _hobbiesDao = hobbiesDao ?? GetIt.instance.get<HobbiesDao>(),
        _sessionsDao = sessionsDao ?? GetIt.instance.get<HobbySessionsDao>(),
        super(HobbiesInitial()) {
    on<LoadHobbies>(_onLoadHobbies);
    on<AddHobby>(_onAddHobby);
    on<UpdateHobby>(_onUpdateHobby);
    on<DeleteHobby>(_onDeleteHobby);
    on<ToggleHobbyActive>(_onToggleHobbyActive);
    on<StartHobbySession>(_onStartHobbySession);
    on<EndHobbySession>(_onEndHobbySession);
    on<LoadHobbySessions>(_onLoadHobbySessions);
    on<RefreshHobbies>(_onRefreshHobbies);
  }

  Future<void> _onLoadHobbies(
    LoadHobbies event,
    Emitter<HobbiesState> emit,
  ) async {
    emit(HobbiesLoading());
    try {
      final hobbies = await _hobbiesDao.getAllHobbies();
      emit(HobbiesLoaded(hobbies: hobbies));
    } catch (e) {
      emit(HobbiesError('Failed to load hobbies: $e'));
    }
  }

  Future<void> _onAddHobby(
    AddHobby event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is HobbiesLoaded) {
        // Optimistic update
        emit(HobbiesLoaded(hobbies: [...currentState.hobbies, event.hobby]));
        
        try {
          await _hobbiesDao.insertHobby(event.hobby);
        } catch (e) {
          emit(HobbiesLoaded(hobbies: currentState.hobbies));
          emit(HobbiesError('Failed to add hobby: $e'));
        }
      }
    } catch (e) {
      emit(HobbiesError('Failed to add hobby: $e'));
    }
  }

  Future<void> _onUpdateHobby(
    UpdateHobby event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is HobbiesLoaded) {
        final optimisticHobbies = currentState.hobbies.map((h) {
          return h.id == event.hobby.id ? event.hobby : h;
        }).toList();
        
        emit(HobbiesLoaded(hobbies: optimisticHobbies));
        
        try {
          await _hobbiesDao.updateHobby(event.hobby);
        } catch (e) {
          emit(HobbiesLoaded(hobbies: currentState.hobbies));
          emit(HobbiesError('Failed to update hobby: $e'));
        }
      }
    } catch (e) {
      emit(HobbiesError('Failed to update hobby: $e'));
    }
  }

  Future<void> _onDeleteHobby(
    DeleteHobby event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is HobbiesLoaded) {
        final optimisticHobbies = currentState.hobbies
            .where((h) => h.id != event.hobbyId)
            .toList();
        
        emit(HobbiesLoaded(hobbies: optimisticHobbies));
        
        try {
          await _hobbiesDao.deleteHobby(event.hobbyId);
        } catch (e) {
          emit(HobbiesLoaded(hobbies: currentState.hobbies));
          emit(HobbiesError('Failed to delete hobby: $e'));
        }
      }
    } catch (e) {
      emit(HobbiesError('Failed to delete hobby: $e'));
    }
  }

  Future<void> _onToggleHobbyActive(
    ToggleHobbyActive event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is HobbiesLoaded) {
        final hobby = currentState.hobbies.firstWhere((h) => h.id == event.hobbyId);
        final updated = hobby.copyWith(isActive: !hobby.isActive);
        
        emit(HobbiesLoaded(
          hobbies: currentState.hobbies.map((h) => h.id == event.hobbyId ? updated : h).toList(),
        ));
        
        await _hobbiesDao.updateHobby(updated);
      }
    } catch (e) {
      emit(HobbiesError('Failed to toggle hobby: $e'));
    }
  }

  Future<void> _onStartHobbySession(
    StartHobbySession event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final session = HobbySessionModel(
        id: 0,
        hobbyId: event.hobbyId,
        startTime: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      await _sessionsDao.insertSession(session);
    } catch (e) {
      emit(HobbiesError('Failed to start session: $e'));
    }
  }

  Future<void> _onEndHobbySession(
    EndHobbySession event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      await _sessionsDao.endSession(
        event.sessionId,
        mood: event.mood,
        notes: event.notes,
      );
    } catch (e) {
      emit(HobbiesError('Failed to end session: $e'));
    }
  }

  Future<void> _onLoadHobbySessions(
    LoadHobbySessions event,
    Emitter<HobbiesState> emit,
  ) async {
    try {
      final sessions = await _sessionsDao.getSessionsForHobby(event.hobbyId);
      final hobby = await _hobbiesDao.getHobbyById(event.hobbyId);
      final stats = HobbyStats.compute(
        hobby ?? HobbyModel(
          id: event.hobbyId,
          name: '',
          category: 'Custom',
          frequency: 'daily',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        sessions,
      );
      emit(HobbySessionsLoaded(sessions: sessions, stats: stats));
    } catch (e) {
      emit(HobbiesError('Failed to load sessions: $e'));
    }
  }

  Future<void> _onRefreshHobbies(
    RefreshHobbies event,
    Emitter<HobbiesState> emit,
  ) async {
    add(LoadHobbies());
  }
}