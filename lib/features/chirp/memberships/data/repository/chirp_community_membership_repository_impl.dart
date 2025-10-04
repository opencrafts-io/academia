import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:academia/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ChirpCommunityMembershipRepositoryImpl
    implements ChirpCommunityMembershipRepository {
  final ChirpCommunityMembershipRemoteDatasource
      chirpCommunityMembershipRemoteDatasource;
  final ChirpCommunityMembershipLocalDatasource
      chirpCommunityMembershipLocalDatasource;
  final ProfileLocalDatasource profileLocalDatasource;

  ChirpCommunityMembershipRepositoryImpl({
    required this.chirpCommunityMembershipLocalDatasource,
    required this.chirpCommunityMembershipRemoteDatasource,
    required this.profileLocalDatasource,
  });

  @override
  Stream<Either<Failure, List<ChirpCommunityMembership>>>
      getAllCachedMemberships() {
    // TODO: implement getAllCachedMemberships
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>>
      getAndCachePersonalMemberships() {
    // TODO: implement getAndCachePersonalMemberships
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ChirpCommunityMembership>> joinCommunity({
    required String communityID,
  }) async {
    final remoteResult = await chirpCommunityMembershipRemoteDatasource
        .joinCommunity(communityID: communityID);

    return remoteResult.fold((serverFailure) => Left(serverFailure), (
      remoteData,
    ) async {
      final localResult = await chirpCommunityMembershipLocalDatasource
          .createOrUpdateCommunityMembership(remoteData);
      return localResult.fold(
        (cacheFailure) => Left(cacheFailure),
        (data) => Right(data.toEntity()),
      );
    });
  }

  @override
  Future<Either<Failure, void>> leaveCommunity({required String communityID}) async {
    final profileResult = await profileLocalDatasource.getCachedUserProfile();
    return await profileResult.fold(
      (failure) => Left(failure),
      (userProfile) async {
        final membershipResult = await chirpCommunityMembershipLocalDatasource.getMembership(
          communityID: communityID,
          userID: userProfile.id,
        );

        return await membershipResult.fold(
          (failure) => Left(failure),
          (membership) async {
            // Anticipatory local deletion
            final deleteResult = await chirpCommunityMembershipLocalDatasource.deleteCached(membership);
            if (deleteResult.isLeft()) {
              return deleteResult.fold((l) => Left(l), (r) => const Right(null));
            }

            final remoteResult = await chirpCommunityMembershipRemoteDatasource.leaveCommunity(membershipID: membership.id.toString());

            return remoteResult.fold(
              (failure) async {
                // Revert local change if remote call fails
                await chirpCommunityMembershipLocalDatasource.createOrUpdateCommunityMembership(membership);
                return Left(failure);
              },
              (_) => const Right(null),
            );
          },
        );
      },
    );
  }
}
