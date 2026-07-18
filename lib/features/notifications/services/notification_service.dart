import 'dart:async';

import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/injection_container.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class NotificationService {
  Future<void> init();
}

class NotificationServiceImpl implements NotificationService {
  static const _oneSignalAppId = '88ca0bb7-c0d7-4e36-b9e6-ea0e29213593';

  @override
  Future<void> init() async {
    await _initializeAwesomeNotifications();
    await _initializeOneSignal();
    _registerListeners();
  }

  Future<void> _initializeOneSignal() async {
    OneSignal.initialize(_oneSignalAppId);
  }

  Future<void> _initializeAwesomeNotifications() async {
    await AwesomeNotifications().initialize('resource://drawable/academia', [
      NotificationChannel(
        channelKey: 'local_reminder_channel_v2',
        channelName: 'Reminders',
        channelDescription: 'Notification channel for reminders',
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/reminder',
        defaultColor: Color(0xFF1B1D23),
        importance: NotificationImportance.Max,
      ),
      NotificationChannel(
        channelKey: 'local_alert_channel_v2',
        channelName: 'Alerts',
        channelDescription: 'Notification channel for important alerts',
        criticalAlerts: true,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/symphony',
        defaultPrivacy: NotificationPrivacy.Public,
      ),
      NotificationChannel(
        channelKey: 'local_update_channel_v2',
        channelName: 'Updates',
        channelDescription: 'Notification channel for app updates',
        importance: NotificationImportance.Default,
        criticalAlerts: false,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/meloboom',
        defaultPrivacy: NotificationPrivacy.Public,
      ),
      NotificationChannel(
        channelKey: 'course_alerts_v2',
        channelName: 'Course Alerts',
        channelDescription: 'Notifications for upcoming classes',
        defaultColor: const Color(0xFF007DFD),
        importance: NotificationImportance.Max,
        playSound: true,
        ledColor: const Color(0xFF007DFD),
        soundSource: 'resource://raw/course',
        defaultPrivacy: NotificationPrivacy.Private,
        enableVibration: true,
      ),
      NotificationChannel(
        channelKey: 'exam_alerts_v2',
        channelName: 'Exam Alerts',
        channelDescription: 'Notifications for upcoming exams',
        defaultColor: const Color(0xFFFFA000),
        importance: NotificationImportance.Max,
        playSound: true,
        ledColor: const Color(0xFFFFA000),
        soundSource: 'resource://raw/reminder',
        criticalAlerts: true,
        locked: true,
        defaultPrivacy: NotificationPrivacy.Public,
        enableVibration: true,
      ),
    ], debug: false);
  }

  void _registerListeners() {
    OneSignal.Notifications.addClickListener((event) {
      debugPrint('OneSignal notification clicked: ${event.notification.title}');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.notification.display();
    });

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceived,
      onNotificationCreatedMethod: _onNotificationCreated,
      onNotificationDisplayedMethod: _onNotificationDisplayed,
      onDismissActionReceivedMethod: _onNotificationDismissed,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _onActionReceived(ReceivedAction action) async {
    debugPrint('Notification action: ${action.payload}');

    final todoLocalId = int.tryParse(action.payload?['localId'] ?? '');
    if (todoLocalId != null) {
      await _handleTodoAction(action, todoLocalId);
      return;
    }

    final examInstitutionId = int.tryParse(
      action.payload?['institutionId'] ?? '',
    );
    if (examInstitutionId != null && action.payload?['courseCode'] != null) {
      AppRouter.router.push(
        ExamTimetableRoute(institutionId: examInstitutionId).location,
      );
      return;
    }

    final url = action.payload?['url'];
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
  }

  /// Handles the "View To-do"/"Mark Done" action buttons scheduled by
  /// [TodoNotificationServiceImpl]. Both button types run on the app's main
  /// isolate (see [ActionType.Default] and [ActionType.SilentAction]), so
  /// the DI container set up in `main()` is always available here - no
  /// background-isolate bootstrap is needed.
  static Future<void> _handleTodoAction(
    ReceivedAction action,
    int todoLocalId,
  ) async {
    switch (action.buttonKeyPressed) {
      case 'btn-do':
        AppRouter.router.push(
          UpdateTodoItemRoute(todoLocalID: todoLocalId).location,
        );
      case 'btn-done':
        // Go through the usecase directly rather than TodoItemCubit.completeItem:
        // the cubit is a lazy singleton that may not have loaded this item into
        // its in-memory state yet (e.g. the todos tab was never opened this
        // session), in which case completeItem() would silently no-op.
        await sl<CompleteTodoItem>()(todoLocalId);
        if (sl.isRegistered<TodoNotificationService>()) {
          await sl<TodoNotificationService>().cancelReminder(todoLocalId);
        }
        // Best-effort refresh so an already-open todos screen picks up the
        // change instead of showing stale in-memory state.
        if (sl.isRegistered<TodoItemCubit>()) {
          unawaited(sl<TodoItemCubit>().loadItems());
        }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _onNotificationCreated(
    ReceivedNotification notification,
  ) async {}

  @pragma('vm:entry-point')
  static Future<void> _onNotificationDisplayed(
    ReceivedNotification notification,
  ) async {}

  @pragma('vm:entry-point')
  static Future<void> _onNotificationDismissed(ReceivedAction action) async {}
}
