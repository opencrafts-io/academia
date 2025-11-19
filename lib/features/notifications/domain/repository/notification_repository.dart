import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  /// Initialize OneSignal with the provided app ID
  Future<Either<Failure, void>> initializeOneSignal(String appId);

  /// Initialize the local notifications
  Future<Either<Failure, void>> initializeLocalNotifications(
    List<NotificationChannelConfig> channels,
  );

  /// Set user data (external user ID and metadata) in OneSignal
  Future<Either<Failure, void>> setUserData({
    required String userId,
    required String name,
    required String email,
  });

  /// Get all notifications from local storage
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  /// Mark a notification as read
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead();

  /// Delete a notification
  Future<Either<Failure, void>> deleteNotification(String notificationId);

  /// Clear all notifications
  Future<Either<Failure, void>> clearAllNotifications();

  /// Get notification count
  Future<Either<Failure, int>> getNotificationCount();

  /// Get unread notification count
  Future<Either<Failure, int>> getUnreadCount();

  /// Set notification permission
  Future<Either<Failure, void>> setNotificationPermission(bool enabled);

  /// Get notification permission status
  Future<Either<Failure, bool>> getNotificationPermission();

  Future<Either<Failure, void>> sendLocalNotification({
    required NotificationContent content,
    NotificationCalendar? schedule,
    List<NotificationActionButton>? actionButtons,
    Map<String, NotificationLocalization>? localizations,
  });
}
