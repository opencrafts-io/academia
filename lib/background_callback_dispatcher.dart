import 'package:academia/background_task/background_task.dart';
import 'package:academia/background_task/course_alert_background_task.dart';
import 'package:academia/background_task/daily_login_background_task.dart';
import 'package:academia/config/config.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:academia/injection_container.dart' as di;

@pragma('vm:entry-point')
void backgroundCallbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    try {
      await di.init(
        FlavorConfig(
          flavor: kDebugMode ? Flavor.staging : Flavor.production,
          appName: kDebugMode ? 'Academia - stg' : 'Academia',
          apiBaseUrl: "https://api.opencrafts.io",
        ),
        isBackground: true,
      );

      final notificationRepository = di.sl<NotificationRepository>();
      await notificationRepository.initializeLocalNotifications([
        NotificationChannelConfig.courseAlerts,
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
    } catch (e) {
      debugPrint("Background Task Error: $e");
      debugPrint(e.toString());
      return Future.value(false);
    }
  });
}

Future<void> registerDefaultBackgroundTasks() async {
  // Calculate delay to next 5 AM
  final now = DateTime.now();
  var next5Am = DateTime(now.year, now.month, now.day, 5);

  if (now.isAfter(next5Am)) {
    next5Am = next5Am.add(const Duration(days: 1));
  }

  final initialDelay = next5Am.difference(now);

  // Run the course alert task once every 24 hours at 5 AM
  // It schedules precise notifications for the day
  await Workmanager().registerPeriodicTask(
    'io.opencrafts.academia.course.alert',
    'io.opencrafts.academia.course.alert',
    initialDelay: initialDelay,
    backoffPolicy: BackoffPolicy.linear,
    frequency: const Duration(hours: 24),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    constraints: Constraints(
      requiresBatteryNotLow: false,
      networkType: NetworkType.notRequired,
    ),
  );
}
