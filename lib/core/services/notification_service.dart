import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

/// Full-featured NotificationService using flutter_local_notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static const String _channelId = 'planza_task_reminders';
  static const String _channelName = 'Task Reminders';
  static const String _channelDescription = 'Notifications for task due dates and reminders';

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<NotificationService> init() async {
    if (_initialized) return this;

    tzdata.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/planza_icon');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _createNotificationChannel();
    _initialized = true;
    return this;
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _onNotificationTapped(NotificationResponse response) async {
    // Handle notification actions
    if (response.actionId != null) {
      final parts = response.actionId!.split(':');
      if (parts.length == 2) {
        final action = parts[0];
        final taskId = int.tryParse(parts[1]);
        if (taskId != null) {
          await _handleNotificationAction(action, taskId);
        }
      }
    }
  }

  Future<void> _handleNotificationAction(String action, int taskId) async {
    // TODO: Implement action handling via event bus or callback
    // This would typically trigger a task completion, snooze, etc.
    print('Notification action: $action for task: $taskId');
  }

  Future<bool> requestPermissions() async {
    final result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return result ?? false;
  }

  /// Cancel a specific notification
  Future<void> cancelTaskReminder(int taskId) async {
    await _flutterLocalNotificationsPlugin.cancel(taskId);
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Schedule a reminder for a specific task with optional snooze
  Future<void> scheduleTaskReminder(TaskModel task, {Duration? snoozeDuration}) async {
    await cancelTaskReminder(task.id!);

    if (task.dueDate == null || task.isCompleted) {
      return;
    }

    DateTime scheduledDate;
    if (snoozeDuration != null) {
      scheduledDate = DateTime.now().add(snoozeDuration);
    } else {
      scheduledDate = tz.TZDateTime.from(task.dueDate!, tz.local);
    }

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    // Check quiet hours
    if (await _isInQuietHours(scheduledDate)) {
      return;
    }

    // Check working days
    if (!(await _isWorkingDay(scheduledDate))) {
      return;
    }

    // Check per-goal override
    final goalId = task.goal?.id;
    if (goalId != null && await _hasNotificationOverride(goalId, task.id!)) {
      return;
    }

    final notificationDetails = await _buildNotificationDetails(task);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      task.id!,
      'Task Reminder',
      task.title,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<NotificationDetails> _buildNotificationDetails(TaskModel task) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: const Color(0xFF6366F1),
      actions: [
        AndroidNotificationAction('complete:${task.id}', 'Complete', showsUserInterface: false),
        AndroidNotificationAction('snooze_10m:${task.id}', 'Snooze 10m', showsUserInterface: false),
        AndroidNotificationAction('snooze_1h:${task.id}', 'Snooze 1h', showsUserInterface: false),
      ],
      category: AndroidNotificationCategory.reminder,
      visibility: NotificationVisibility.public,
      showWhen: true,
      when: DateTime.now().millisecondsSinceEpoch,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      categoryIdentifier: 'task_reminder',
    );

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  Future<bool> _isInQuietHours(DateTime dateTime) async {
    // TODO: Implement quiet hours check from settings
    return false;
  }

  Future<bool> _isWorkingDay(DateTime dateTime) async {
    // TODO: Implement working days check from settings
    return true;
  }

  Future<bool> _hasNotificationOverride(int goalId, int taskId) async {
    // TODO: Implement per-goal override check from settings
    return false;
  }

  /// Schedule a snooze notification
  Future<void> snoozeTask(TaskModel task, Duration duration) async {
    await scheduleTaskReminder(task, snoozeDuration: duration);
  }

  /// Show immediate test notification
  Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification from Planza',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }
}