import 'package:academia/core/error/failures.dart';
import 'package:academia/features/auth/data/data.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, Token>> signInWithGoogle() async {
    final result = await authRemoteDatasource.signInWithGoogle();
    return result.fold((failure) => left(failure), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, Token>> signInWithSpotify() async {
    final result = await authRemoteDatasource.signInWithSpotify();
    return result.fold((failure) => left(failure), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, List<Token>>> getPreviousAuthState() async {
    final result = await authLocalDatasource.getAllCachedTokens();
    return result.fold((failure) => left(failure), (tokens) {
      return right(tokens.map((token) => token.toEntity()).toList());
    });
  }
}
