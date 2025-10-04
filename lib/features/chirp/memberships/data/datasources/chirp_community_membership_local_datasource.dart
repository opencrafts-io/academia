import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ChirpCommunityMembershipLocalDatasource {
  final AppDataBase localDB;

  ChirpCommunityMembershipLocalDatasource({required this.localDB});

  Future<Either<Failure, ChirpCommunityMembershipData>>
  createOrUpdateCommunityMembership(
    ChirpCommunityMembershipData chirpCommunityMembershipData,
  ) async {
    try {
      final modified = await localDB
          .into(localDB.chirpCommunityMembership)
          .insertReturning(
            chirpCommunityMembershipData,
            onConflict: DoUpdate((d) => chirpCommunityMembershipData),
          );

      return right(modified);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache memberships. "
              "Please check your storage or try restarting the app to fix this",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, Stream<List<ChirpCommunityMembershipData>>>>
  getAllCachedCommunityMemberships() async {
    try {
      final modified = localDB.select(localDB.chirpCommunityMembership).watch();
      return right(modified);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed fetch cached memberships. "
              "Please check your storage or try restarting the app to fix this",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, ChirpCommunityMembershipData?>> deleteCached(
    ChirpCommunityMembershipData communityMembership,
  ) async {
    try {
      final deleted = await localDB
          .delete(localDB.chirpCommunityMembership)
          .deleteReturning(communityMembership);

      return right(deleted);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed delete cached memberships. "
              "Please check your storage or try restarting the app to fix this",
          error: e,
        ),
      );
    }
  }
}
