import 'dart:ui';

import 'package:academia/background_task/background_task.dart';
import 'package:academia/background_task/course_alert_background_task.dart';
import 'package:academia/background_task/daily_login_background_task.dart';
import 'package:academia/config/config.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:academia/injection_container.dart' as di;

@pragma('vm:entry-point')
void backgroundCallbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    await di.init(
      FlavorConfig(
        flavor: kDebugMode ? Flavor.staging : Flavor.production,
        appName: kDebugMode ? 'Academia - stg' : 'Academia',
        apiBaseUrl: "https://api.opencrafts.io",
      ),
    );

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
    final courseAlert = CourseAlertBackgroundTask(
      timetableEntryRepository: di.sl<TimetableEntryRepository>(),
      courseRepository: di.sl<CourseRepository>(),
    );

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
  Workmanager().registerPeriodicTask(
    'io.opencrafts.academia.course.alert',
    'io.opencrafts.academia.course.alert',
    frequency: const Duration(minutes: 15),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    constraints: Constraints(networkType: NetworkType.notRequired),
  );
}
