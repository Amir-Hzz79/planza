import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../data_access_object/user_stats_dao.dart';
import '../../models/user_stats_model.dart';

part 'user_stats_event.dart';
part 'user_stats_state.dart';

class UserStatsBloc extends Bloc<UserStatsEvent, UserStatsState> {
  final UserStatsDao _userStatsDao = GetIt.instance.get<UserStatsDao>();

  UserStatsBloc() : super(UserStatsInitial()) {
    on<LoadUserStats>(_onLoadUserStats);
    on<AddXp>(_onAddXp);
    on<UpdateStreak>(_onUpdateStreak);
    on<IncrementTasksCompleted>(_onIncrementTasksCompleted);
    on<IncrementGoalsCompleted>(_onIncrementGoalsCompleted);
    on<IncrementTemplatesCreated>(_onIncrementTemplatesCreated);
    on<UnlockTheme>(_onUnlockTheme);
    on<UnlockIcon>(_onUnlockIcon);
    on<UnlockAnimation>(_onUnlockAnimation);
    on<ResetStats>(_onResetStats);
  }

  Future<void> _onLoadUserStats(
    LoadUserStats event,
    Emitter<UserStatsState> emit,
  ) async {
    emit(UserStatsLoading());
    try {
      final stats = await _userStatsDao.getOrCreateUserStats();
      emit(UserStatsLoaded(stats));
    } catch (e) {
      emit(UserStatsError('Failed to load user stats: $e'));
    }
  }

  Future<void> _onAddXp(
    AddXp event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.addXp(event.amount);
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to add XP: $e'));
    }
  }

  Future<void> _onUpdateStreak(
    UpdateStreak event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.updateStreak(event.isActiveToday);
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to update streak: $e'));
    }
  }

  Future<void> _onIncrementTasksCompleted(
    IncrementTasksCompleted event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.incrementTasksCompleted();
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to increment tasks completed: $e'));
    }
  }

  Future<void> _onIncrementGoalsCompleted(
    IncrementGoalsCompleted event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.incrementGoalsCompleted();
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to increment goals completed: $e'));
    }
  }

  Future<void> _onIncrementTemplatesCreated(
    IncrementTemplatesCreated event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.incrementTemplatesCreated();
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to increment templates created: $e'));
    }
  }

  Future<void> _onUnlockTheme(
    UnlockTheme event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.unlockTheme(event.themeId);
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to unlock theme: $e'));
    }
  }

  Future<void> _onUnlockIcon(
    UnlockIcon event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.unlockIcon(event.iconId);
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to unlock icon: $e'));
    }
  }

  Future<void> _onUnlockAnimation(
    UnlockAnimation event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.unlockAnimation(event.animationId);
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to unlock animation: $e'));
    }
  }

  Future<void> _onResetStats(
    ResetStats event,
    Emitter<UserStatsState> emit,
  ) async {
    try {
      await _userStatsDao.resetStats();
      final stats = await _userStatsDao.getUserStats();
      if (stats != null) {
        emit(UserStatsLoaded(stats));
      }
    } catch (e) {
      emit(UserStatsError('Failed to reset stats: $e'));
    }
  }
}