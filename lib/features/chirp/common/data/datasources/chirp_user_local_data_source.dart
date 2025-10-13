import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

// ChirpUserLocalDataSource
// A local datasource for manipulating and managing cached chirp user information
class ChirpUserLocalDataSource {
  final AppDataBase localDB;

  static const Duration ttl = Duration(
    days: 1,
  ); // User information is persisted for 1 day
  ChirpUserLocalDataSource({required this.localDB});

  /// createorUpdateChirpUser
  /// Attempts to cache a chip user. If the chirp user already exists the data
  /// is updated with the new data
  Future<Either<Failure, ChirpUserData>> createorUpdateChirpUser(
    ChirpUserData chirpUser,
  ) async {
    try {
      await _deleteAllExpiredCachedUsers();
      final manipulated = await localDB
          .into(localDB.chirpUser)
          .insertReturning(
            chirpUser.copyWith(cachedAt: Value(DateTime.now())),
            onConflict: DoUpdate(
              (data) => chirpUser.copyWith(cachedAt: Value(DateTime.now())),
            ),
          );

      return right(manipulated);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache chirp user. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedChirpUserByID
  /// Attempts to retrieve a cached user by their id provided as [chirpUserID]
  /// If no user was provided, the function gracefully returns null otherwise
  /// it returns a failure with a message of what exactly went wrong
  ///
  /// NOTE that [chirpUserID] case will be ignored and use a lowercase version
  /// for comparison
  Future<Either<Failure, ChirpUserData?>> getCachedChirpUserByID(
    String chirpUserID,
  ) async {
    try {
      await _deleteAllExpiredCachedUsers();
      final retrieved =
          await (localDB.select(localDB.chirpUser)..where(
                (user) => user.userID.lower().equals(chirpUserID.toLowerCase()),
              ))
              .getSingleOrNull();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrieve cached chirp user specified by id [$chirpUserID]"
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedChirpUserByUsername
  /// Attempts to retrieve a cached user by their username provided as [chirpUsername]
  /// If no user was retrieved, the function gracefully returns null otherwise
  /// it returns a failure with a message of what exactly went wrong
  ///
  /// NOTE that [chirpUsername] is and will search with case sentitivity
  Future<Either<Failure, ChirpUserData?>> getCachedChirpUserByUsername(
    String chirpUsername,
  ) async {
    try {
      await _deleteAllExpiredCachedUsers();
      final retrieved =
          await (localDB.select(localDB.chirpUser)
                ..where((user) => user.username.equals(chirpUsername)))
              .getSingleOrNull();
      return right(retrieved);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrive cached chirp user specified by username [$chirpUsername]. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// deleteCachedChirpUserByID
  /// Attempts to delete a cached user by their id provided as [chirpUserID]
  ///
  /// NOTE that [chirpUserID] will ignore case and compare the lowercase
  /// versions
  Future<Either<Failure, ChirpUserData?>> deleteCachedChirpUserByID(
    String chirpUserID,
  ) async {
    try {
      await _deleteAllExpiredCachedUsers();
      final deleted =
          await (localDB.delete(localDB.chirpUser)..where(
                (user) => user.userID.lower().equals(chirpUserID.toLowerCase()),
              ))
              .goAndReturn();
      return right(deleted.first);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete cached chirp user specified by id [$chirpUserID]. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// deleteAllCachedChirpUsers
  /// Performs a truncate operation on the chirp user local cache
  Future<Either<Failure, void>> deleteAllCachedChirpUsers() async {
    try {
      await localDB.delete(localDB.chirpUser).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to truncate cached chirp users information. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// _deleteAllExpiredCachedCommunities
  /// Deletes all expired cached chirp user information
  Future<Either<Failure, void>> _deleteAllExpiredCachedUsers() async {
    try {
      final expirationThreshold = DateTime.now().subtract(ttl);
      await (localDB.delete(localDB.chirpUser)..where(
            (chirpUser) =>
                chirpUser.cachedAt.isSmallerThanValue(expirationThreshold),
          ))
          .go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all expired cached chirp user information. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }
}
