import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class SignInWithSpotifyUsecase implements UseCase<Token, NoParams> {
  final AuthRepository repository;

  SignInWithSpotifyUsecase(this.repository);

  @override
  Future<Either<Failure, Token>> call(NoParams params) async {
    return await repository.signInWithSpotify();
  }
}
