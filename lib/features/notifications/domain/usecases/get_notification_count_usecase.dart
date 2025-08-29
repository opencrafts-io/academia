import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class GetNotificationCountUsecase implements UseCase<int, NoParams> {
  final NotificationRepository repository;

  GetNotificationCountUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getNotificationCount();
  }
}

