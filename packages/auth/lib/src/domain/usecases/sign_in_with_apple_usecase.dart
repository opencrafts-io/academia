import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithAppleUsecase implements UseCase<Token, NoUseCaseParams> {
  final AuthRepository repository;

  SignInWithAppleUsecase(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoUseCaseParams params) async {
    return await repository.signInWithApple();
  }
}
