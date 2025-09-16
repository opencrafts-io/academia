part of 'notification_bloc.dart';

/// Abstract base class for all notification events
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize OneSignal with app ID
class InitializeOneSignalEvent extends NotificationEvent {
  final String appId;

  const InitializeOneSignalEvent({required this.appId});

  @override
  List<Object?> get props => [appId];
}

/// Event to load notifications from local storage
class LoadNotificationsEvent extends NotificationEvent {
  const LoadNotificationsEvent();
}

/// Event to mark a notification as read
class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsReadEvent({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

/// Event to mark all notifications as read
class MarkAllNotificationsAsReadEvent extends NotificationEvent {
  const MarkAllNotificationsAsReadEvent();
}

/// Event to delete a notification
class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  const DeleteNotificationEvent({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

/// Event to clear all notifications
class ClearAllNotificationsEvent extends NotificationEvent {
  const ClearAllNotificationsEvent();
}

/// Event to get notification count
class GetNotificationCountEvent extends NotificationEvent {
  const GetNotificationCountEvent();
}

/// Event to get unread notification count
class GetUnreadCountEvent extends NotificationEvent {
  const GetUnreadCountEvent();
}

/// Event to set notification permission
class SetNotificationPermissionEvent extends NotificationEvent {
  final bool enabled;

  const SetNotificationPermissionEvent({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

/// Event to get notification permission status
class GetNotificationPermissionEvent extends NotificationEvent {
  const GetNotificationPermissionEvent();
}

/// Event to send a local notification (for testing)
class SendLocalNotificationEvent extends NotificationEvent {
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  const SendLocalNotificationEvent({
    required this.title,
    required this.body,
    this.data,
  });

  @override
  List<Object?> get props => [title, body, data];
}

/// Event to set user data (external user ID and metadata) in OneSignal
class SetUserDataEvent extends NotificationEvent {
  final String userId;
  final String name;
  final String email;

  const SetUserDataEvent({
    required this.userId,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, name, email];
}

