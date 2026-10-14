import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithSpotifyUsecase implements UseCase<Token, NoUseCaseParams> {
  final AuthRepository repository;

  SignInWithSpotifyUsecase(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoUseCaseParams params) async {
    return await repository.signInWithSpotify();
  }
}
