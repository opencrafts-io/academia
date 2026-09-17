import 'notification_action_handler.dart';

abstract interface class NotificationInitializer {
  Future<void> initialize(NotificationActionHandler actionHandler);
}
