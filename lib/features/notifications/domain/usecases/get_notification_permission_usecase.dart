import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class GetNotificationPermissionUsecase implements UseCase<bool, NoParams> {
  final NotificationRepository repository;

  GetNotificationPermissionUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getNotificationPermission();
  }
}

