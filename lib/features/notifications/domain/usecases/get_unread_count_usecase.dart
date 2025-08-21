import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class GetUnreadCountUsecase implements UseCase<int, NoParams> {
  final NotificationRepository repository;

  GetUnreadCountUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getUnreadCount();
  }
}

