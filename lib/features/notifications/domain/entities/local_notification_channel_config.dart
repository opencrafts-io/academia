import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationChannelConfig {
  final String channelKey;
  final String channelName;
  final String channelDescription;
  final NotificationPrivacy defaultPrivacy;
  final bool playSound;
  final String? soundSource;
  final bool enableVibration;
  final bool criticalAlerts;
  final DefaultRingtoneType defaultRingtoneType;
  final bool enableLights;
  final bool locked;
  final NotificationImportance importance;
  final Color? defaultColor;
  final Color? ledColor;
  final String? icon;
  final bool? onlyAlertOnce;

  const NotificationChannelConfig({
    required this.channelKey,
    required this.channelName,
    required this.channelDescription,
    this.defaultPrivacy = NotificationPrivacy.Public,
    this.playSound = true,
    this.soundSource,
    this.enableVibration = true,
    this.criticalAlerts = true,
    this.defaultRingtoneType = DefaultRingtoneType.Notification,
    this.enableLights = true,
    this.locked = true,
    this.importance = NotificationImportance.Max,
    this.defaultColor,
    this.ledColor,
    this.icon,
    this.onlyAlertOnce,
  });

  // Convert to Awesome Notifications channel
  NotificationChannel toNotificationChannel() {
    return NotificationChannel(
      channelKey: channelKey,
      channelName: channelName,
      channelDescription: channelDescription,
      defaultPrivacy: defaultPrivacy,
      playSound: playSound,
      enableVibration: enableVibration,
      criticalAlerts: criticalAlerts,
      defaultRingtoneType: defaultRingtoneType,
      enableLights: enableLights,
      locked: locked,
      importance: importance,
      defaultColor: defaultColor,
      ledColor: ledColor,
      soundSource: soundSource,
      icon: icon,
      onlyAlertOnce: onlyAlertOnce,
    );
  }

  // Predefined channel configs
  static const NotificationChannelConfig reminders = NotificationChannelConfig(
    channelKey: 'local_reminder_channel',
    channelName: 'Reminders',
    channelDescription: 'Notification channel for reminders',
    locked: true,
    soundSource: "resource://raw/hangout",
    playSound: true,
  );

  static const NotificationChannelConfig alerts = NotificationChannelConfig(
    channelKey: 'local_alert_channel',
    channelName: 'Alerts',
    channelDescription: 'Notification channel for important alerts',
    criticalAlerts: true,
    locked: true,
    soundSource: "resource://raw/symphony",
    playSound: true,
  );

  static const NotificationChannelConfig updates = NotificationChannelConfig(
    channelKey: 'local_update_channel',
    channelName: 'Updates',
    channelDescription: 'Notification channel for app updates',
    importance: NotificationImportance.Default,
    criticalAlerts: false,
    locked: true,
    soundSource: "resource://raw/meloboom",
    playSound: true,
  );
}
