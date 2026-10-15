import '../domain/local_notification_channel.dart';
import '../domain/local_notification_request.dart';

abstract interface class LocalNotificationScheduler {
  Future<void> schedule(LocalNotificationRequest request);

  Future<void> cancel(int id);

  Future<void> cancelScheduledForChannel(LocalNotificationChannel channel);

  Future<int> scheduledCount();

  Future<void> cancelAllSchedules();
}

class DisabledLocalNotificationScheduler implements LocalNotificationScheduler {
  const DisabledLocalNotificationScheduler();

  @override
  Future<void> cancel(int id) async {}

  @override
  Future<void> cancelAllSchedules() async {}

  @override
  Future<void> cancelScheduledForChannel(
    LocalNotificationChannel channel,
  ) async {}

  @override
  Future<int> scheduledCount() async => 0;

  @override
  Future<void> schedule(LocalNotificationRequest request) async {}
}
