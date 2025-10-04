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

  /// Fetches the current user's personal memberships from the remote source,
  /// synchronizes (caches) the full list locally, and returns the list of Entities.
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getAndCachePersonalMemberships();

  /// Provides a real-time stream of all memberships currently cached locally.
  /// This is used for keeping the UI updated instantly when the cache changes.
  Stream<Either<Failure, List<ChirpCommunityMembership>>>
  getAllCachedMemberships();

  /// Handles the process of removing a user's membership (leaving or being kicked).
  ///
  /// Returns nothing on successful completion (Right(void)).
  Future<Either<Failure, void>> leaveCommunity({required String communityID});
}
