import 'package:workmanager/workmanager.dart';
import 'package:academia/background_task/background_task.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CourseAlertBackgroundTask extends BackgroundTask {
  @override
  String? get taskTag => 'io.opencrafts.academia.course.alert';

  @override
  String get taskName => 'io.opencrafts.academia.course.alert';

  @override
  Duration? get frequency => Duration(minutes: 15);

  @override
  ExistingWorkPolicy get existingWorkPolicy => ExistingWorkPolicy.keep;

  @override
  Future<bool> execute(Map<String, dynamic>? inputData) async {
    try {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 105,
          channelKey: 'course_alerts',
          title: 'Time for Classy! 🔔',
          body: 'Your next session is starting soon.\n📍 Building B, Room 302',
          actionType: ActionType.KeepOnTop,
          locked: true,
          chronometer: Duration(minutes: 10),
          autoDismissible: false,
          notificationLayout: NotificationLayout.BigText,
          category: NotificationCategory.Reminder,
          backgroundColor: const Color(0xFF007DFD),
          color: Colors.white,
          payload: {"type": "countdown"},
          wakeUpScreen: true,
          criticalAlert: true,
          fullScreenIntent: true,
          displayOnForeground: true,
          largeIcon: 'asset://assets/icons/alarm.png',
          roundedLargeIcon: true,
        ),
      );
      return true;
    } catch (e) {
      debugPrint("Notification Error: $e");
      return false;
    }
  }
}
