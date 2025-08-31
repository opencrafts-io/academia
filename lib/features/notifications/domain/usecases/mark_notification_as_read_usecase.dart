import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class MarkNotificationAsReadUsecase implements UseCase<void, String> {
  final NotificationRepository repository;

  MarkNotificationAsReadUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String notificationId) async {
    return await repository.markAsRead(notificationId);
  }
}

