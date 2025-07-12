import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> signInWithGoogle();
}
