import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> signInWithGoogle();
  Future<Either<Failure, Token>> reviewSignIn();
  Future<Either<Failure, Token>> signInWithSpotify();
  Future<Either<Failure, List<Token>>> getPreviousAuthState();
  Future<Either<Failure, Token>> refreshVerisafeToken(Token token);
}
