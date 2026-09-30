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
      NotFoundFailure(message: "Not implemented", error: UnimplementedError()),
    );
  }

  @override
  Future<Either<Failure, void>> signout() async {
    final tokenResult = await authLocalDatasource.getTokenByProvider(
      "verisafe",
    );
    final token = tokenResult.fold((_) => null, (token) => token);

    // Revocation is best effort: even if the network is unavailable, complete
    // local logout so the user is not left in an authenticated UI state.
    if (token != null) await authRemoteDatasource.revokeToken(token);
    return authLocalDatasource.deleteAllTokens();
  }
}
