import 'package:academia/core/core.dart';
import 'package:academia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signout();
  }
}
