import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ChirpCommunityMembershipLocalDatasource {
  final AppDataBase localDB;

  ChirpCommunityMembershipLocalDatasource({required this.localDB});

  /// --- 1. Create or Update Single Membership ---
  /// Inserts a new membership or updates an existing one if a conflict occurs
  Future<Either<Failure, ChirpCommunityMembershipData>>
  createOrUpdateCommunityMembership(ChirpCommunityMembershipData data) async {
    try {
      final modified = await localDB
          .into(localDB.chirpCommunityMembership)
          .insertReturning(data, onConflict: DoUpdate((d) => data));

      return right(modified);
    } catch (e) {
      return left(
        CacheFailure(
          message:
              "Failed to cache membership. Please check storage or try again.",
          error: e,
        ),
      );
    }
  }

  /// --- 2. Save/Update a List of Memberships (Bulk Operation) ---
  /// Uses a batch operation for highly efficient insertion and updating of
  /// multiple records.
  Future<Either<Failure, List<ChirpCommunityMembershipData>>>
  saveAllCommunityMemberships(
    List<ChirpCommunityMembershipData> dataList,
  ) async {
    try {
      if (dataList.isEmpty) return right([]);

      // 1. Perform a batch operation
      await localDB.batch((batch) {
        batch.insertAll(
          localDB.chirpCommunityMembership,
          dataList,
          // Use insertOrReplace to handle conflicts efficiently on bulk data.
          mode: InsertMode.insertOrReplace,
        );
      });
      return right(dataList);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to save/update list of memberships.",
          error: e,
        ),
      );
    }
  }

  /// --- 3. Returns a list of all cached community memberships
  Future<Either<Failure, List<ChirpCommunityMembershipData>>>
  getAllCachedCommunityMemberships() async {
    try {
      final memberships = await localDB
          .select(localDB.chirpCommunityMembership)
          .get();
      return right(memberships);
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to fetch cached memberships stream.",
          error: e,
        ),
      );
    }
  }

  /// --- 4. Delete Single Cached Membership ---
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
        CacheFailure(message: "Failed to delete cached membership.", error: e),
      );
    }
  }

  Future<Either<Failure, ChirpCommunityMembershipData>> getMembership({
    required int communityID,
    required String userID,
  }) async {
    try {
      final query = localDB.select(localDB.chirpCommunityMembership)
        ..where(
          (tbl) =>
              tbl.communityID.equals(communityID) & tbl.userID.equals(userID),
        );
      final result = await query.getSingleOrNull();
      if (result != null) {
        return right(result);
      } else {
        return left(
          NoDataFoundFailure(
            message: "Membership not found in local cache",
            error: userID,
          ),
        );
      }
    } catch (e) {
      return left(
        CacheFailure(
          message: "Failed to retrieve membership from cache",
          error: e,
        ),
      );
    }
  }
}
