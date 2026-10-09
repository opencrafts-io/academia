import 'package:academia/core/core.dart';
import 'package:academia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SetPasswordUsecase implements UseCase<void, String> {
  const SetPasswordUsecase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(String password) =>
      repository.setPassword(password);
}
