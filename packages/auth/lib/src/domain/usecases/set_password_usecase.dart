import 'package:core/core.dart';
import 'package:auth/src/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetPasswordUsecase implements UseCase<void, String> {
  const SetPasswordUsecase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(String password) =>
      repository.setPassword(password);
}
