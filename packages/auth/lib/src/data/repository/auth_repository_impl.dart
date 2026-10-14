import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, Token>> signInWithProvider(
    String provider, {
    String deviceToken = "none",
    String deviceName = "Unknown Device",
  }) async {
    final result = await authRemoteDatasource.signInWithProvider(
      provider,
      deviceToken: deviceToken,
      deviceName: deviceName,
    );
    return result.fold((failure) => left(failure), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, Token>> signInWithApple() async {
    final result = await authRemoteDatasource.signInWithApple();
    return result.fold((failure) => left(failure), (token) async {
      final cacheRes = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheRes.fold(
        (error) => left(error),
        (token) => right(token.toEntity()),
      );
    });
  }

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
  Future<Either<Failure, Token>> signInWithPassword({
    required String email,
    required String password,
    String? deviceName,
    String? deviceToken,
  }) async {
    final result = await authRemoteDatasource.signInWithPassword(
      email: email,
      password: password,
      deviceName: deviceName,
      deviceToken: deviceToken,
    );
    return result.fold((failure) => left(failure), (token) async {
      final cacheResult = await authLocalDatasource.cacheOrUpdateToken(token);
      return cacheResult.fold(
        (failure) => left(failure),
        (savedToken) => right(savedToken.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, void>> setPassword(String password) =>
      authRemoteDatasource.setPassword(password);

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
    return result.fold(
      (failure) => left(failure),
      (token) => right(token.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Token>> reviewSignIn() async {
    return left(
      Failure.server(message: "Not implemented", error: UnimplementedError()),
    );
  }

  @override
  Future<Either<Failure, void>> signout() async {
    final tokenResult = await authLocalDatasource.getTokenByProvider(
      "verisafe",
    );
    final token = tokenResult.fold((_) => null, (token) => token);

    // Remove local credentials before making the best-effort revocation call.
    // This keeps concurrent auth checks from refreshing a session mid-logout.
    final localLogout = await authLocalDatasource.deleteAllTokens();
    if (token != null) await authRemoteDatasource.revokeToken(token);
    return localLogout;
  }
}
