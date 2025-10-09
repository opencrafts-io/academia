import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/memberships/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class ChirpCommunityMembershipRepository {
  /// Remotely and locally handles the creation or updating of a user's membership
  /// when they attempt to join a community.
  ///
  /// Returns the newly created or updated [CommunityMembership] Entity on success.
  Future<Either<Failure, ChirpCommunityMembership>> joinCommunity({
    required String communityID,
  });

  /// Retrieves all personal memberships for a user and caches them accordingly
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getPersonalMemberships({int page = 1, int pageSize = 100});

  /// Provides a List of all memberships currently cached locally.
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getAllCachedMemberships();

  /// Handles the process of removing a user's membership (leaving or being kicked).
  ///
  /// Returns nothing on successful completion (Right(void)).
  Future<Either<Failure, void>> leaveCommunity({required int communityID});

  /// Fetches memberships for a community
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getCommunityMemberships({
    required int communityID,
    int page = 1,
    int pageSize = 50,
  });

  /// Fetched personal communit membership for a given community
  Future<Either<Failure, ChirpCommunityMembership>>
  getPersonalCommunityMemberShipForCommunity({required int communityID});
}
