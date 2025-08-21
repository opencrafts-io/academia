import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class InitializeOneSignalUsecase implements UseCase<void, String> {
  final NotificationRepository repository;

  InitializeOneSignalUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String appId) async {
    return await repository.initializeOneSignal(appId);
  }
}

