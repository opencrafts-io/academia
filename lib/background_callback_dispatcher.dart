import 'dart:typed_data';
import 'dart:ui';

import 'package:academia/background_task/background_task.dart';
import 'package:academia/background_task/course_alert_background_task.dart';
import 'package:academia/background_task/daily_login_background_task.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void backgroundCallbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    await AwesomeNotifications().initialize("resource://drawable/academia", [
      NotificationChannel(
        channelKey: 'course_alerts',
        channelName: 'Course Alerts',
        channelDescription: 'Notifications for upcoming classes',
        defaultColor: const Color(0xFF007DFD),
        importance: NotificationImportance.High,
        playSound: true,
        ledColor: const Color(0xFF007DFD),
        soundSource: 'resource://raw/class_join',
        defaultPrivacy: NotificationPrivacy.Public,
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 500, 200, 500]),
      ),
    ]);

    final dailyLogin = DailyLoginBackgroundTask();
    final courseAlert = CourseAlertBackgroundTask();

    final Map<String, BackgroundTask> taskRegistry = {
      courseAlert.taskName: courseAlert,
      dailyLogin.taskName: dailyLogin,
    };

    final taskToExecute = taskRegistry[task];
    if (taskToExecute != null) {
      return await taskToExecute.execute(input);
    }
    return false;
  });
}

void registerDefaultBackgroundTasks() {
  final courseAlert = CourseAlertBackgroundTask();
  Workmanager().registerPeriodicTask(
    courseAlert.taskName,
    courseAlert.taskName,
    frequency: courseAlert.frequency,
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    constraints: courseAlert.constraints.toWorkManagerConstraints(),
  );
}
