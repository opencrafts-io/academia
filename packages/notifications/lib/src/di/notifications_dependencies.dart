import 'package:get_it/get_it.dart';

import '../application/local_notification_scheduler.dart';
import '../application/notification_action_handler.dart';
import '../application/notification_configuration.dart';
import '../application/notification_identity_service.dart';
import '../application/notification_initializer.dart';
import '../application/notification_service.dart';
import '../data/awesome_local_notification_scheduler.dart';
import '../data/one_signal_notification_gateway.dart';

void configureNotificationsDependencies(
  GetIt getIt, {
  required NotificationConfiguration configuration,
  required NotificationActionHandler actionHandler,
}) {
  final scheduler = configuration.enabled
      ? AwesomeLocalNotificationScheduler()
      : const DisabledLocalNotificationScheduler();
  final identityService = configuration.enabled
      ? OneSignalNotificationGateway(configuration.oneSignalAppId!)
      : const DisabledNotificationIdentityService();

  if (!getIt.isRegistered<NotificationActionHandler>()) {
    getIt.registerSingleton<NotificationActionHandler>(actionHandler);
  }
  if (!getIt.isRegistered<LocalNotificationScheduler>()) {
    getIt.registerSingleton<LocalNotificationScheduler>(scheduler);
  }
  if (!getIt.isRegistered<NotificationIdentityService>()) {
    getIt.registerSingleton<NotificationIdentityService>(identityService);
  }
  if (!getIt.isRegistered<NotificationService>()) {
    final initializers = <NotificationInitializer>[
      if (scheduler is NotificationInitializer)
        scheduler as NotificationInitializer,
      if (identityService is NotificationInitializer)
        identityService as NotificationInitializer,
    ];
    getIt.registerSingletonAsync<NotificationService>(() async {
      final service = NotificationService(initializers);
      await service.initialize(actionHandler);
      return service;
    });
  }
}
