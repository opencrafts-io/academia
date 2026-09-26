import '../domain/local_notification_request.dart';

abstract interface class LocalNotificationScheduler {
  Future<void> schedule(LocalNotificationRequest request);

  Future<void> cancel(int id);

  Future<void> cancelAllSchedules();
}

class DisabledLocalNotificationScheduler implements LocalNotificationScheduler {
  const DisabledLocalNotificationScheduler();

  @override
  Future<void> cancel(int id) async {}

  @override
  Future<void> cancelAllSchedules() async {}

  @override
  Future<void> schedule(LocalNotificationRequest request) async {}
}
