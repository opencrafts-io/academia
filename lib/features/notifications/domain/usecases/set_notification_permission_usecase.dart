import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class SetNotificationPermissionUsecase implements UseCase<void, bool> {
  final NotificationRepository repository;

  SetNotificationPermissionUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(bool enabled) async {
    return await repository.setNotificationPermission(enabled);
  }
}

