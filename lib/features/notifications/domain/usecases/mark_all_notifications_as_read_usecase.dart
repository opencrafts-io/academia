import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class MarkAllNotificationsAsReadUsecase implements UseCase<void, NoParams> {
  final NotificationRepository repository;

  MarkAllNotificationsAsReadUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.markAllAsRead();
  }
}

