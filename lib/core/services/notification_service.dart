import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Cancel a specific notification
  Future<void> cancelTaskReminder(int taskId) async {
    await _plugin.cancel(taskId);
  }

  Future<NotificationService> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/planza_icon');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        // Handle notification tap
        print("Notification tapped with payload: ${response.payload}");
        // TODO: Use a navigator service to open the TaskDetailsPage
      },
    );

    return this;
  }

  // Request permission from the user (required for Android 13+)
  Future<bool> requestPermissions() async {
    final result = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return result ?? false;
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

    await _plugin.zonedSchedule(
      task.id!,
      "Task Due: ${task.title}",
      "Your task is scheduled for now. Time to get it done!",
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminders_channel',
          'Task Reminders',
          channelDescription: 'Notifications for task deadlines.',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: task.id.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      /* uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime, */
    );
  }
}
