part of 'notification_bloc.dart';

/// Abstract base class for all notification states
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is first created
class NotificationInitialState extends NotificationState {
  const NotificationInitialState();
}

/// Loading state when an operation is in progress
class NotificationLoadingState extends NotificationState {
  const NotificationLoadingState();
}

/// State when OneSignal has been successfully initialized
class NotificationInitializedState extends NotificationState {
  const NotificationInitializedState();
}

/// State when notifications have been loaded successfully
class NotificationsLoadedState extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationsLoadedState({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

/// State when notification count has been loaded
class NotificationCountLoadedState extends NotificationState {
  final int count;

  const NotificationCountLoadedState({required this.count});

  @override
  List<Object?> get props => [count];
}

/// State when unread count has been loaded
class UnreadCountLoadedState extends NotificationState {
  final int count;

  const UnreadCountLoadedState({required this.count});

  @override
  List<Object?> get props => [count];
}

/// State when notification permission has been set
class NotificationPermissionSetState extends NotificationState {
  final bool enabled;

  const NotificationPermissionSetState({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

/// State when notification permission status has been loaded
class NotificationPermissionLoadedState extends NotificationState {
  final bool enabled;

  const NotificationPermissionLoadedState({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

/// State when a local notification has been sent successfully
class LocalNotificationSentState extends NotificationState {
  const LocalNotificationSentState();
}

/// Error state when an operation fails
class NotificationErrorState extends NotificationState {
  final String message;

  const NotificationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

