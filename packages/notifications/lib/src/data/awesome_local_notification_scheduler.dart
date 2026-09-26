import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart' as awesome;
import 'package:flutter/material.dart' show Color;

import '../application/local_notification_scheduler.dart';
import '../application/notification_action_handler.dart';
import '../application/notification_initializer.dart';
import '../domain/local_notification_action.dart';
import '../domain/local_notification_category.dart';
import '../domain/local_notification_channel.dart';
import '../domain/local_notification_presentation.dart';
import '../domain/local_notification_request.dart';
import '../domain/notification_action.dart';

class AwesomeLocalNotificationScheduler
    implements LocalNotificationScheduler, NotificationInitializer {
  AwesomeLocalNotificationScheduler({awesome.AwesomeNotifications? client})
    : _client = client ?? awesome.AwesomeNotifications();

  static NotificationActionHandler? _actionHandler;

  final awesome.AwesomeNotifications _client;

  @override
  Future<void> initialize(NotificationActionHandler actionHandler) async {
    _actionHandler = actionHandler;
    await _client.initialize(
      'resource://drawable/academia',
      [
        awesome.NotificationChannel(
          channelKey: _channelKey(LocalNotificationChannel.reminders),
          channelName: 'Reminders',
          channelDescription: 'Notification channel for reminders',
          locked: true,
          playSound: true,
          soundSource: 'resource://raw/reminder',
          defaultColor: const Color(0xFF1B1D23),
          importance: awesome.NotificationImportance.Max,
        ),
        awesome.NotificationChannel(
          channelKey: _channelKey(LocalNotificationChannel.alerts),
          channelName: 'Alerts',
          channelDescription: 'Notification channel for important alerts',
          criticalAlerts: true,
          locked: true,
          playSound: true,
          soundSource: 'resource://raw/symphony',
          defaultPrivacy: awesome.NotificationPrivacy.Public,
        ),
        awesome.NotificationChannel(
          channelKey: _channelKey(LocalNotificationChannel.updates),
          channelName: 'Updates',
          channelDescription: 'Notification channel for app updates',
          importance: awesome.NotificationImportance.Default,
          locked: true,
          playSound: true,
          soundSource: 'resource://raw/meloboom',
          defaultPrivacy: awesome.NotificationPrivacy.Public,
        ),
        awesome.NotificationChannel(
          channelKey: _channelKey(LocalNotificationChannel.courseAlerts),
          channelName: 'Course Alerts',
          channelDescription: 'Notifications for upcoming classes',
          defaultColor: const Color(0xFF007DFD),
          importance: awesome.NotificationImportance.Max,
          playSound: true,
          ledColor: const Color(0xFF007DFD),
          soundSource: 'resource://raw/course',
          defaultPrivacy: awesome.NotificationPrivacy.Private,
          enableVibration: true,
        ),
        awesome.NotificationChannel(
          channelKey: _channelKey(LocalNotificationChannel.examAlerts),
          channelName: 'Exam Alerts',
          channelDescription: 'Notifications for upcoming exams',
          defaultColor: const Color(0xFFFFA000),
          importance: awesome.NotificationImportance.Max,
          playSound: true,
          ledColor: const Color(0xFFFFA000),
          soundSource: 'resource://raw/reminder',
          criticalAlerts: true,
          locked: true,
          defaultPrivacy: awesome.NotificationPrivacy.Public,
          enableVibration: true,
        ),
      ],
      debug: false,
    );
    await _client.setListeners(onActionReceivedMethod: _onActionReceived);
  }

  @override
  Future<void> schedule(LocalNotificationRequest request) async {
    await _client.createNotification(
      content: awesome.NotificationContent(
        id: request.id,
        channelKey: _channelKey(request.channel),
        title: request.title,
        body: request.body,
        summary: request.summary,
        category: _category(request.category),
        actionType: request.presentation.keepOnTop
            ? awesome.ActionType.KeepOnTop
            : awesome.ActionType.Default,
        autoDismissible: request.presentation.autoDismissible,
        displayOnBackground: request.presentation.showInBackground,
        displayOnForeground: request.presentation.showInForeground,
        wakeUpScreen: request.presentation.wakeUpScreen,
        criticalAlert: request.presentation.criticalAlert,
        fullScreenIntent: request.presentation.fullScreenIntent,
        locked: request.presentation.locked,
        largeIcon: request.presentation.largeIcon,
        roundedLargeIcon: request.presentation.roundedLargeIcon,
        color: request.presentation.colorValue == null
            ? null
            : Color(request.presentation.colorValue!),
        backgroundColor: request.presentation.backgroundColorValue == null
            ? null
            : Color(request.presentation.backgroundColorValue!),
        chronometer: request.presentation.chronometer,
        notificationLayout: request.presentation.layout
            == LocalNotificationLayout.bigText
            ? awesome.NotificationLayout.BigText
            : awesome.NotificationLayout.Default,
        payload: request.payload,
      ),
      schedule: request.schedule == null
          ? null
          : awesome.NotificationCalendar.fromDate(
              date: request.schedule!.at,
              preciseAlarm: request.schedule!.precise,
              allowWhileIdle: request.schedule!.allowWhileIdle,
              repeats: false,
            ),
      actionButtons: request.actions.map(_actionButton).toList(),
    );
  }

  @override
  Future<void> cancel(int id) => _client.cancel(id);

  @override
  Future<void> cancelAllSchedules() => _client.cancelAllSchedules();

  static Future<void> _onActionReceived(awesome.ReceivedAction action) async {
    final handler = _actionHandler;
    if (handler == null) {
      return;
    }
    await handler.handle(
      NotificationAction.fromPayload(
        buttonKey: action.buttonKeyPressed,
        payload: action.payload,
      ),
    );
  }

  awesome.NotificationActionButton _actionButton(
    LocalNotificationAction action,
  ) {
    return awesome.NotificationActionButton(
      key: action.id,
      label: action.label,
      color: action.colorValue == null ? null : Color(action.colorValue!),
      actionType: switch (action.type) {
        LocalNotificationActionType.open => awesome.ActionType.Default,
        LocalNotificationActionType.silent => awesome.ActionType.SilentAction,
        LocalNotificationActionType.dismiss => awesome.ActionType.DismissAction,
      },
    );
  }

  static awesome.NotificationCategory _category(
    LocalNotificationCategory category,
  ) {
    return switch (category) {
      LocalNotificationCategory.reminder => awesome.NotificationCategory.Reminder,
      LocalNotificationCategory.alarm => awesome.NotificationCategory.Alarm,
      LocalNotificationCategory.status => awesome.NotificationCategory.Status,
      LocalNotificationCategory.event => awesome.NotificationCategory.Event,
    };
  }

  static String _channelKey(LocalNotificationChannel channel) {
    return switch (channel) {
      LocalNotificationChannel.reminders => 'local_reminder_channel_v2',
      LocalNotificationChannel.alerts => 'local_alert_channel_v2',
      LocalNotificationChannel.updates => 'local_update_channel_v2',
      LocalNotificationChannel.courseAlerts => 'course_alerts_v2',
      LocalNotificationChannel.examAlerts => 'exam_alerts_v2',
    };
  }
}
