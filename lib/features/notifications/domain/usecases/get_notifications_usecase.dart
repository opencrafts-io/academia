import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUsecase implements UseCase<List<NotificationEntity>, NoParams> {
  final NotificationRepository repository;

  GetNotificationsUsecase(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(NoParams params) async {
    return await repository.getNotifications();
  }
}

