import 'dart:async';
import 'dart:io';

import 'package:academia/background_task/background_task.dart';
import 'package:academia/background_task/daily_login_background_task.dart';
import 'package:academia/background_task/todo_item_sync_background_task.dart';
import 'package:academia/background_task/todo_list_sync_background_task.dart';
import 'package:core/config/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:notifications/notifications.dart';
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

      await di.initializeNotifications();

      final scheduler = di.sl<LocalNotificationScheduler>();
      final dailyLogin = DailyLoginBackgroundTask(scheduler);
      final todoItemSync = TodoItemSyncBackgroundTask(
        todoItemRepository: di.sl(),
      );
      final todoListSync = TodoListSyncBackgroundTask(
        todoListRepository: di.sl(),
      );

      final Map<String, BackgroundTask> taskRegistry = {
        dailyLogin.taskName: dailyLogin,
        todoItemSync.taskName: todoItemSync,
        todoListSync.taskName: todoListSync,
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
  await Workmanager().cancelByUniqueName('io.opencrafts.academia.course.alert');

  // Register TodoList sync task - runs every 1 hour
  await Workmanager().registerPeriodicTask(
    'io.opencrafts.academia.todolist.sync',
    'io.opencrafts.academia.todolist.sync',
    backoffPolicy: BackoffPolicy.exponential,
    backoffPolicyDelay: const Duration(minutes: 15),
    frequency: const Duration(hours: 1),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    constraints: Constraints(
      requiresBatteryNotLow: true,
      networkType: NetworkType.connected,
    ),
  );

  await Workmanager().registerPeriodicTask(
    'io.opencrafts.academia.todoitem.sync',
    'io.opencrafts.academia.todoitem.sync',
    backoffPolicy: BackoffPolicy.exponential,
    backoffPolicyDelay: const Duration(minutes: 15),
    frequency: const Duration(hours: 1),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    constraints: Constraints(
      requiresBatteryNotLow: true,
      networkType: NetworkType.connected,
    ),
  );
}

void scheduleDefaultBackgroundTasksAfterFirstFrame() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_initializeDefaultBackgroundTasks());
  });
}

Future<void> _initializeDefaultBackgroundTasks() async {
  if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;

  await Workmanager().initialize(backgroundCallbackDispatcher);
  await registerDefaultBackgroundTasks();
}
