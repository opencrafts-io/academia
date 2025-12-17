import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class SignInWithAppleUsecase implements UseCase<Token, NoParams> {
  final AuthRepository repository;

  SignInWithAppleUsecase(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoParams params) async {
    return await repository.signInWithApple();
  }
}
