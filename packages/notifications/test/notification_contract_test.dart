import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:notifications/notifications.dart';

void main() {
  test('preserves typed local reminder details at the package boundary', () {
    final request = LocalNotificationRequest(
      id: 101,
      channel: LocalNotificationChannel.reminders,
      title: 'Due tomorrow',
      body: 'Finish the reading list.',
      payload: const {'todoId': '24'},
      schedule: LocalNotificationSchedule.at(
        DateTime.utc(2026, 9, 18, 7),
        precise: true,
      ),
      actions: const [
        LocalNotificationAction(
          id: 'todo.open',
          label: 'View to-do',
        ),
      ],
    );

    expect(request.channel, LocalNotificationChannel.reminders);
    expect(request.schedule?.at, DateTime.utc(2026, 9, 18, 7));
    expect(request.schedule?.precise, isTrue);
    expect(request.actions.single.id, 'todo.open');
  });

  test('disabled delivery is safe on unsupported platforms', () async {
    const scheduler = DisabledLocalNotificationScheduler();

    await scheduler.schedule(
      const LocalNotificationRequest(
        id: 1,
        channel: LocalNotificationChannel.reminders,
        title: 'Reminder',
        body: 'Read this.',
      ),
    );
    await scheduler.cancel(1);
    await scheduler.cancelAllSchedules();
  });

  test('local delivery defaults to non-intrusive presentation', () {
    const request = LocalNotificationRequest(
      id: 1,
      channel: LocalNotificationChannel.reminders,
      title: 'Reminder',
      body: 'Read this.',
    );

    expect(request.presentation.criticalAlert, isFalse);
    expect(request.presentation.fullScreenIntent, isFalse);
    expect(request.presentation.wakeUpScreen, isFalse);
  });

  test('notification actions retain only string payload values', () {
    final action = NotificationAction.fromPayload(
      buttonKey: 'todo.open',
      payload: const {
        'todoId': '24',
        'unexpected': 3,
      },
    );

    expect(action.buttonKey, 'todo.open');
    expect(action.payload, const {'todoId': '24'});
  });

  test('initializes local and remote adapters through one lifecycle service',
      () async {
    final local = _RecordingInitializer();
    final remote = _RecordingInitializer();
    final handler = _RecordingActionHandler();
    final service = NotificationService([local, remote]);

    await service.initialize(handler);

    expect(local.handler, same(handler));
    expect(remote.handler, same(handler));
  });

  test('disabled push identity is safe outside supported platforms', () async {
    const identity = NotificationIdentity(
      userId: 'account-42',
      email: 'student@example.com',
      displayName: 'Student',
    );
    const service = DisabledNotificationIdentityService();

    await service.identify(identity);
    await service.clear();

    expect(identity.userId, 'account-42');
  });

  test('disabled configuration registers safe notification services', () {
    final getIt = GetIt.asNewInstance();

    configureNotificationsDependencies(
      getIt,
      configuration: const NotificationConfiguration.disabled(),
      actionHandler: _RecordingActionHandler(),
    );

    expect(
      getIt<LocalNotificationScheduler>(),
      isA<DisabledLocalNotificationScheduler>(),
    );
    expect(
      getIt<NotificationIdentityService>(),
      isA<DisabledNotificationIdentityService>(),
    );
    expect(getIt.isRegistered<NotificationService>(), isTrue);
  });
}

class _RecordingInitializer implements NotificationInitializer {
  NotificationActionHandler? handler;

  @override
  Future<void> initialize(NotificationActionHandler actionHandler) async {
    handler = actionHandler;
  }
}

class _RecordingActionHandler implements NotificationActionHandler {
  @override
  Future<void> handle(NotificationAction action) async {}
}
