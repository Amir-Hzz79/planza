library notification_settings_state;

import 'package:equatable/equatable.dart';
import 'package:planza/core/data/models/user_settings_model.dart';

abstract class NotificationSettingsState extends Equatable {
  const NotificationSettingsState();

  @override
  List<Object?> get props => [];
}

class NotificationSettingsInitial extends NotificationSettingsState {}

class NotificationSettingsLoading extends NotificationSettingsState {}

class NotificationSettingsLoaded extends NotificationSettingsState {
  final UserSettingsModel settings;

  const NotificationSettingsLoaded({required this.settings});

  @override
  List<Object?> get props => [settings];
}

class NotificationSettingsError extends NotificationSettingsState {
  final String message;

  const NotificationSettingsError(this.message);

  @override
  List<Object?> get props => [message];
}