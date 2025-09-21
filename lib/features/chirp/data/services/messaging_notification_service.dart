import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/entities/conversations/message.dart' as domain;

class MessagingNotificationService {
  static const String _channelId = 'messaging_channel';
  static const String _channelName = 'Messages';
  static const String _channelDescription = 'Notifications for new messages';

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  bool _isInitialized = false;

  // Singleton pattern
  static final MessagingNotificationService _instance = 
      MessagingNotificationService._internal();
  
  factory MessagingNotificationService() {
    return _instance;
  }
  
  MessagingNotificationService._internal();

  /// Initialize the notification service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    // Create notification channel for Android
    await _createNotificationChannel();

    _isInitialized = true;
    debugPrint('Messaging notification service initialized');
  }

  /// Create notification channel for Android
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Handle notification tap
  void _onNotificationResponse(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('Notification tapped with payload: $payload');
      
      // Parse payload and navigate to conversation
      try {
        // Expected format: "conversation_id"
        // You can enhance this to include more data if needed
        _navigateToConversation(payload);
      } catch (e) {
        debugPrint('Error handling notification response: $e');
      }
    }
  }

  /// Navigate to conversation (implement with your navigation system)
  void _navigateToConversation(String conversationId) {
    // TODO: Implement navigation to conversation
    // This should integrate with your app's navigation system (GoRouter, etc.)
    debugPrint('Should navigate to conversation: $conversationId');
  }

  /// Show notification for a new message
  Future<void> showMessageNotification(domain.Message message) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
      );

      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: iOSPlatformChannelSpecifics,
      );

      // Create notification content
      final title = message.sender.name.isNotEmpty 
          ? message.sender.name 
          : 'New Message';
      
      String body;
      // Note: imageUrl is no longer part of Message entity
      // Attachments would need to be handled separately
      body = message.content.isNotEmpty 
          ? message.content 
          : 'New message received';

      // Truncate body if too long
      if (body.length > 100) {
        body = '${body.substring(0, 97)}...';
      }

      await _flutterLocalNotificationsPlugin.show(
        message.id, // Use message ID as notification ID
        title,
        body,
        platformChannelSpecifics,
        payload: message.conversationId.toString(), // Pass conversation ID as string for navigation
      );

      debugPrint('Message notification shown: $title - $body');
    } catch (e) {
      debugPrint('Error showing message notification: $e');
    }
  }

  /// Show notification for typing indicator
  Future<void> showTypingNotification(String userName, String conversationId) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.low,
        priority: Priority.low,
        ongoing: true,
        autoCancel: false,
        showWhen: false,
        icon: '@mipmap/ic_launcher',
      );

      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
        macOS: iOSPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        conversationId.hashCode, // Use conversation ID hash as notification ID
        '$userName is typing...',
        'In conversation',
        platformChannelSpecifics,
        payload: conversationId,
      );

      // Auto-dismiss after 5 seconds
      Timer(const Duration(seconds: 5), () {
        cancelTypingNotification(conversationId);
      });

      debugPrint('Typing notification shown: $userName is typing...');
    } catch (e) {
      debugPrint('Error showing typing notification: $e');
    }
  }

  /// Cancel typing notification
  Future<void> cancelTypingNotification(String conversationId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(conversationId.hashCode);
      debugPrint('Typing notification cancelled for conversation: $conversationId');
    } catch (e) {
      debugPrint('Error cancelling typing notification: $e');
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      debugPrint('All notifications cancelled');
    } catch (e) {
      debugPrint('Error cancelling all notifications: $e');
    }
  }

  /// Cancel notification for specific message
  Future<void> cancelMessageNotification(int messageId) async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(messageId);
      debugPrint('Message notification cancelled for message: $messageId');
    } catch (e) {
      debugPrint('Error cancelling message notification: $e');
    }
  }

  /// Request notification permissions (mainly for iOS)
  Future<bool> requestPermissions() async {
    if (!_isInitialized) {
      await initialize();
    }

    final result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return result ?? true; // Android doesn't require explicit permission request
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (!_isInitialized) {
      await initialize();
    }

    // For iOS
    final iOSImplementation = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iOSImplementation != null) {
      // Note: getNotificationSettings() method may not be available in current version
      // This is a simplified implementation - in a real app you might need to check
      // notification permissions differently
      try {
        final result = await iOSImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return result ?? false;
      } catch (e) {
        debugPrint('Error checking iOS notification permissions: $e');
        return false;
      }
    }

    // For Android, assume enabled (can be enhanced with permission checks)
    return true;
  }
}