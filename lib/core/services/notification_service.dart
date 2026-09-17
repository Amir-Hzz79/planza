// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;

/// Custom NotificationService placeholder - replaced flutter_local_notifications
class NotificationService {
  /// Cancel a specific notification
  Future<void> cancelTaskReminder(int taskId) async {
    // TODO: Implement via MethodChannel
    print("CustomNotificationService: cancelTaskReminder($taskId)");
  }

  Future<NotificationService> init() async {
    // TODO: Implement via MethodChannel
    print("CustomNotificationService: init()");
    return this;
  }

  // Request permission from the user (required for Android 13+)
  Future<bool> requestPermissions() async {
    // TODO: Implement via MethodChannel
    print("CustomNotificationService: requestPermissions()");
    return false;
  }

  /// Schedule a reminder for a specific task
  Future<void> scheduleTaskReminder(TaskModel task) async {
    await cancelTaskReminder(task.id!);

    if (task.dueDate == null || task.isCompleted) {
      return;
    }

    final scheduledDate = tz.TZDateTime.from(task.dueDate!, tz.local);

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    // TODO: Implement via MethodChannel
    print("CustomNotificationService: scheduleTaskReminder(${task.title})");
  }
}