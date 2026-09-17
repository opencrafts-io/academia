import 'notification_action_handler.dart';
import 'notification_initializer.dart';

class NotificationService {
  const NotificationService(this._initializers);

  final List<NotificationInitializer> _initializers;

  Future<void> initialize(NotificationActionHandler actionHandler) async {
    for (final initializer in _initializers) {
      await initializer.initialize(actionHandler);
    }
  }
}
