import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class InitializeLocalNotificationsUsecase
    extends UseCase<void, List<NotificationChannelConfig>> {
  final NotificationRepository notificationRepository;

  InitializeLocalNotificationsUsecase({required this.notificationRepository});
  @override
  Future<Either<Failure, void>> call(
    List<NotificationChannelConfig> channels,
  ) async {
    return await notificationRepository.initializeLocalNotifications(channels);
  }
}
