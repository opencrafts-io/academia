import 'package:core/core.dart';
import 'package:auth/src/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUsecase extends UseCase<void, NoUseCaseParams> {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoUseCaseParams params) async {
    return await authRepository.signout();
  }
}
