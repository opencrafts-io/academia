import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class CommunityLocalDatasource {
  final AppDataBase localDB;
  static const Duration ttl = Duration(hours: 1);
  CommunityLocalDatasource({required this.localDB});

  /// createorUpdateCommunity
  /// Attempts to cache a community. If the community already exists it is
  /// updated with the new information supplied.
  Future<Either<Failure, CommunityData>> createorUpdateCommunity(
    CommunityData community,
  ) async {
    try {
      await _deleteAllExpiredCachedCommunities();
      final manipulated = await localDB
          .into(localDB.community)
          .insertReturning(
            community.copyWith(cachedAt: Value(DateTime.now())),
            onConflict: DoUpdate(
              (data) => community.copyWith(cachedAt: Value(DateTime.now())),
            ),
          );

      return right(manipulated);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache community. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedCommunities
  /// Returns a list of all communities cached.
  /// Interally the function will invalidate cache that is older than the specified
  /// [ttl] duration
  Future<Either<Failure, List<CommunityData>>> getCachedCommunities() async {
    try {
      await _deleteAllExpiredCachedCommunities();
      final communities = await localDB.select(localDB.community).get();

      return right(communities);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrive community. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// getCachedCommunityByID
  /// Returns a community by its id specified by [communityID].
  /// Interally the function will invalidate cache that is older than the specified
  /// [ttl] duration
  Future<Either<Failure, CommunityData>> getCachedCommunityByID(
    int communityID,
  ) async {
    try {
      await _deleteAllExpiredCachedCommunities();
      final community = await (localDB.select(
        localDB.community,
      )..where((community) => community.id.equals(communityID))).getSingle();

      return right(community);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to retrive community. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, List<CommunityData>>>
  deleteAllCachedCommunities() async {
    try {
      await _deleteAllExpiredCachedCommunities();
      final deleted = await localDB.delete(localDB.community).goAndReturn();

      return right(deleted);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all cached communities. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  /// _deleteAllExpiredCachedCommunities
  /// Deletes all expired cached communities
  Future<Either<Failure, void>> _deleteAllExpiredCachedCommunities() async {
    try {
      final expirationThreshold = DateTime.now().subtract(ttl);
      await (localDB.delete(localDB.community)..where(
            (community) =>
                community.cachedAt.isSmallerThanValue(expirationThreshold),
          ))
          .go();

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete all cached communities. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommunityData>> deleteCachedCommunity(
    CommunityData community,
  ) async {
    try {
      final deleted = await localDB
          .delete(localDB.community)
          .deleteReturning(community);

      await _deleteAllExpiredCachedCommunities();
      return right(deleted!);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to delete cached community. "
              "A quick restart or clearing your storage might fix the issue",
          error: e,
        ),
      );
    }
  }
}
