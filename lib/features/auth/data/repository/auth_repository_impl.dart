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
    return result.fold(
      (failure) => left(failure),
      (tokens) => right(tokens.map((token) => token.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Token>> refreshVerisafeToken(Token token) async {
    final result = await authRemoteDatasource.refreshVerisafeToken(
      token.toData(),
    );

    return result.fold((error) => left(error), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, Token>> reviewSignIn() async {
    final result = await authRemoteDatasource.refreshVerisafeToken(
      Token(
        id: 1001,
        refreshToken:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3ZlcmlzYWZlLm9wZW5jcmFmdHMuaW8vIiwic3ViIjoiNWIyYjY3NzgtZmM0OS00YjYzLWI4MzYtMDgyNzc4ZDJhNGYzIiwiYXVkIjpbImh0dHBzOi8vYWNhZGVtaWEub3BlbmNyYWZ0cy5pby8iXSwiZXhwIjoxNzYzMDM3NDI1LCJpYXQiOjE3NjA0NDU0MjV9.fMdcw0anXM6LkCDfR1oOK3uUGs598SazpSIcyK3DImA",
        provider: "verisafe",
        expiresAt: DateTime(2025, 10, 14, 15, 16).add(Duration(days: 7)),
        accessToken:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3ZlcmlzYWZlLm9wZW5jcmFmdHMuaW8vIiwic3ViIjoiNWIyYjY3NzgtZmM0OS00YjYzLWI4MzYtMDgyNzc4ZDJhNGYzIiwiYXVkIjpbImh0dHBzOi8vYWNhZGVtaWEub3BlbmNyYWZ0cy5pby8iXSwiZXhwIjoxNzYxMDUwMjI1LCJpYXQiOjE3NjA0NDU0MjV9.SinDjMU5Uc46mMurxn0OOOIt8e7d2588_f8JAPpU1Cc",
        createdAt: DateTime(2025, 10, 14, 15, 16),
        updatedAt: DateTime(2025, 10, 14, 15, 16),
      ).toData(),
    );

    return result.fold((error) => left(error), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }
}
