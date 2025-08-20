import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class DeleteNotificationUsecase implements UseCase<void, String> {
  final NotificationRepository repository;

  DeleteNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String notificationId) async {
    return await repository.deleteNotification(notificationId);
  }
}

