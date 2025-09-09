import 'package:academia/core/core.dart';
import 'package:academia/features/notifications/notifications.dart';
import 'package:dartz/dartz.dart';

class SetUserDataUsecase implements UseCase<void, SetUserDataParams> {
  final NotificationRepository repository;

  SetUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SetUserDataParams params) async {
    return await repository.setUserData(
      userId: params.userId,
      name: params.name,
      email: params.email,
    );
  }
}

class SetUserDataParams {
  final String userId;
  final String name;
  final String email;

  SetUserDataParams({
    required this.userId,
    required this.name,
    required this.email,
  });
}
