import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class CommunityLocalDatasource {
  final AppDataBase localDB;
  CommunityLocalDatasource({required this.localDB});

  Future<Either<Failure, CommunityData>> createorUpdateCommunity(
    CommunityData community,
  ) async {
    try {
      final manipulated = await localDB
          .into(localDB.communityTable)
          .insertReturning(
            community,
            onConflict: DoUpdate((data) => community),
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

  Future<Either<Failure, List<CommunityData>>> getCachedCommunities() async {
    try {
      final communities = await localDB.select(localDB.communityTable).get();
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

  Future<Either<Failure, List<CommunityData>>>
  deleteAllCachedCommunities() async {
    try {
      final deleted = await localDB
          .delete(localDB.communityTable)
          .goAndReturn();

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

  Future<Either<Failure, CommunityData>> deleteCachedCommunity(
    CommunityData community,
  ) async {
    try {
      final deleted = await localDB
          .delete(localDB.communityTable)
          .deleteReturning(community);

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
