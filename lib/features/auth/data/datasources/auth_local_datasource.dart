import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class AuthLocalDatasource {
  final AppDataBase localDB;

  AuthLocalDatasource({required this.localDB});

  /// Caches a token to local cache
  /// In case it already exits its  updated on the cache
  Future<Either<Failure, TokenData>> cacheOrUpdateToken(TokenData token) async {
    try {
      final created = await localDB
          .into(localDB.token)
          .insertReturning(token, onConflict: DoUpdate((tok) => token));
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "We failed to cache your token"
              "A quick restart or checking your storage might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, List<TokenData>>> getAllCachedTokens() async {
    try {
      final retrieved = await localDB.select(localDB.token).get();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "An error occurred while accessing your stored authentication token. "
              "A quick app restart might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, TokenData>> getTokenByProvider(String provider) async {
    try {
      final retrieved = await (localDB.select(
        localDB.token,
      )..where((token) => token.provider.equals(provider))).getSingleOrNull();

      if (retrieved == null) {
        return left(
          NoDataFoundFailure(
            message:
                "No authentication token was found for this provider on your device. "
                "You may need to log in again.",
            error: Exception(
              "Token for provider '$provider' not found in local database.",
            ),
          ),
        );
      }
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "An error occurred while accessing your stored authentication token. "
              "A quick app restart might fix this",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteAllTokens() async {
    try {
      await localDB.delete(localDB.token).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              "An error occurred while clearing your device token"
              "this issue has been noted",
        ),
      );
    }
  }
}
