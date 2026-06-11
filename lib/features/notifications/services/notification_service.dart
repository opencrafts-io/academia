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
        channelKey: 'local_reminder_channel',
        channelName: 'Reminders',
        channelDescription: 'Notification channel for reminders',
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/reminder',
        defaultColor: Color(0xFF1B1D23),
      ),
      NotificationChannel(
        channelKey: 'local_alert_channel',
        channelName: 'Alerts',
        channelDescription: 'Notification channel for important alerts',
        criticalAlerts: true,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/symphony',
      ),
      NotificationChannel(
        channelKey: 'local_update_channel',
        channelName: 'Updates',
        channelDescription: 'Notification channel for app updates',
        importance: NotificationImportance.Default,
        criticalAlerts: false,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/meloboom',
      ),
      NotificationChannel(
        channelKey: 'course_alerts',
        channelName: 'Course Alerts',
        channelDescription: 'Notifications for upcoming classes',
        defaultColor: const Color(0xFF007DFD),
        importance: NotificationImportance.Max,
        playSound: true,
        ledColor: const Color(0xFF007DFD),
        soundSource: 'resource://raw/course',
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
    final url = action.payload?['url'];
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
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
