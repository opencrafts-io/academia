import '../domain/notification_identity.dart';

abstract interface class NotificationIdentityService {
  Future<void> identify(NotificationIdentity identity);

  Future<void> clear();
}

class DisabledNotificationIdentityService implements NotificationIdentityService {
  const DisabledNotificationIdentityService();

  @override
  Future<void> clear() async {}

  @override
  Future<void> identify(NotificationIdentity identity) async {}
}
