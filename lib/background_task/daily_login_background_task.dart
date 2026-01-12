import 'dart:convert';
import 'package:academia/background_task/background_task.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class DailyLoginBackgroundTask extends BackgroundTask {
  @override
  String? get taskTag => "io.opencrafts.academia.task.daily_login";

  @override
  String get taskName => "io.opencrafts.academia.task.daily_login";

  @override
  Duration? get frequency =>
      kDebugMode ? const Duration(minutes: 15) : const Duration(hours: 24);

  @override
  Future<bool> execute(Map<String, dynamic>? inputData) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final rawUserActivityData = preferences.getString("user_activity") ?? '{}';

    Map<String, dynamic> userActivity;
    try {
      userActivity = jsonDecode(rawUserActivityData);
    } catch (e) {
      userActivity = {};
    }

    final String? lastAppLaunchString = userActivity["last_app_launch_date"];
    final int currentStreak = userActivity["current_streak"] ?? 0;

    final DateTime? lastAppLaunch = DateTime.tryParse(
      lastAppLaunchString ?? '',
    );

    // If we don't know when the user last launched, we can't do anything.
    if (lastAppLaunch == null) {
      return true;
    }

    final DateTime now = DateTime.now();

    // -- CORE STREAK LOGIC --
    // Check if the user has already opened the app *today*
    final bool hasOpenedToday =
        now.year == lastAppLaunch.year &&
        now.month == lastAppLaunch.month &&
        now.day == lastAppLaunch.day;

    if (hasOpenedToday) {
      // User has already opened the app today. Their streak is safe.
      // No notification needed.
      return true;
    }

    // -- SEND NOTIFICATION --
    // If we get here, the user has *not* opened the app yet today.
    // We send a reminder.

    String title;
    String body;

    if (currentStreak == 0) {
      title = "Start your daily streak! 🚀";
      body = "Open the app today to get your streak started.";
    } else {
      title = "Don't break your $currentStreak-day streak! 🔥";
      body = "You're on a roll! Open the app now to keep your streak alive.";
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10, // Use a consistent ID for streak reminders
        channelKey: NotificationChannelConfig.alerts.channelKey,
        title: title,
        body: body,
        summary: "Daily Streak Reminder",
        category: NotificationCategory.Reminder,
        // Make the notification stand out
        largeIcon: "resource://drawable/academia",
        // IMPORTANT: No more 'locked: true'. This is a standard,
        // dismissible notification.
        autoDismissible: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'OPEN_APP',
          label: 'Keep My Streak!',
          // This will launch the app when tapped
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'DISMISS',
          label: 'Maybe Later',
          // This will just dismiss the notification
          actionType: ActionType.DismissAction,
          isDangerousOption: true,
        ),
      ],
    );

    return true;
  }

  @override
  BackgroundTaskConstraints get constraints => BackgroundTaskConstraints(
    networkType: NetworkType.notRequired,
    requiresBatteryNotLow: true,
  );
}
