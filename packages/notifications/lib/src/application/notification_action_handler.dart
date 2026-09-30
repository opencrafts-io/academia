import '../domain/notification_action.dart';

abstract interface class NotificationActionHandler {
  Future<void> handle(NotificationAction action);
}
