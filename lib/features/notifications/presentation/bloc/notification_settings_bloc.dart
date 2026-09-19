import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/data/data_access_object/user_setting_dao.dart';
import '../../../../../core/data/models/user_settings_model.dart';
import '../../../../../core/services/notification_service.dart';
import 'notification_settings_event.dart';
import 'notification_settings_state.dart';

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  final UserSettingsDao _userSettingsDao;
  final NotificationService _notificationService;

  NotificationSettingsBloc({
    UserSettingsDao? userSettingsDao,
    NotificationService? notificationService,
  })  : _userSettingsDao = userSettingsDao ?? GetIt.instance.get<UserSettingsDao>(),
        _notificationService = notificationService ?? NotificationService(),
        super(NotificationSettingsInitial()) {
    on<LoadNotificationSettings>(_onLoadSettings);
    on<ToggleNotificationsEnabled>(_onToggleNotifications);
    on<UpdateDefaultReminder>(_onUpdateDefaultReminder);
    on<ToggleSnoozeEnabled>(_onToggleSnooze);
    on<UpdateSnoozePresets>(_onUpdateSnoozePresets);
    on<ToggleQuietHours>(_onToggleQuietHours);
    on<UpdateQuietHours>(_onUpdateQuietHours);
    on<ToggleWorkingDays>(_onToggleWorkingDays);
    on<ToggleGoalOverride>(_onToggleGoalOverride);
    on<ResetToDefaults>(_onResetToDefaults);
    on<TestNotification>(_onTestNotification);
  }

  Future<void> _onLoadSettings(
    LoadNotificationSettings event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    emit(NotificationSettingsLoading());
    try {
      final settings = await _userSettingsDao.getUserSettings();
      emit(NotificationSettingsLoaded(settings: settings));
    } catch (e) {
      emit(NotificationSettingsError('Failed to load settings: $e'));
    }
  }

  Future<void> _onToggleNotifications(
    ToggleNotificationsEnabled event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          notificationsEnabled: event.enabled,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update notifications: $e'));
    }
  }

  Future<void> _onUpdateDefaultReminder(
    UpdateDefaultReminder event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          defaultReminderMinutes: event.minutes,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update reminder: $e'));
    }
  }

  Future<void> _onToggleSnooze(
    ToggleSnoozeEnabled event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          snoozeEnabled: event.enabled,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update snooze: $e'));
    }
  }

  Future<void> _onUpdateSnoozePresets(
    UpdateSnoozePresets event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          snoozePresets: event.presets,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update snooze presets: $e'));
    }
  }

  Future<void> _onToggleQuietHours(
    ToggleQuietHours event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          quietHoursEnabled: event.enabled,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update quiet hours: $e'));
    }
  }

  Future<void> _onUpdateQuietHours(
    UpdateQuietHours event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          quietHoursStart: event.start,
          quietHoursEnd: event.end,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update quiet hours: $e'));
    }
  }

  Future<void> _onToggleWorkingDays(
    ToggleWorkingDays event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final newWorkingDays = List<int>.from(currentState.settings.workingDays);
        if (event.enabled) {
          newWorkingDays.add(event.day);
        } else {
          newWorkingDays.remove(event.day);
        }
        final updatedSettings = currentState.settings.copyWith(
          workingDays: newWorkingDays,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update working days: $e'));
    }
  }

  Future<void> _onToggleGoalOverride(
    ToggleGoalOverride event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is NotificationSettingsLoaded) {
        final updatedSettings = currentState.settings.copyWith(
          goalOverrideEnabled: event.enabled,
        );
        await _userSettingsDao.updateUserSettings(updatedSettings);
        emit(NotificationSettingsLoaded(settings: updatedSettings));
      }
    } catch (e) {
      emit(NotificationSettingsError('Failed to update goal override: $e'));
    }
  }

  Future<void> _onResetToDefaults(
    ResetToDefaults event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      final defaultSettings = UserSettingsModel(
        id: 1,
        notificationsEnabled: true,
        theme: 'system',
      );
      await _userSettingsDao.updateUserSettings(defaultSettings);
      emit(NotificationSettingsLoaded(settings: defaultSettings));
    } catch (e) {
      emit(NotificationSettingsError('Failed to reset: $e'));
    }
  }

  Future<void> _onTestNotification(
    TestNotification event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    try {
      await _notificationService.init();
      await _notificationService.showTestNotification();
    } catch (e) {
      emit(NotificationSettingsError('Failed to send test notification: $e'));
    }
  }
}