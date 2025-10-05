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
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getAllCachedMemberships() async {
    final result = await chirpCommunityMembershipLocalDatasource
        .getAllCachedCommunityMemberships();

    return result.fold(
      (failure) => left(failure),
      (cachedMemberships) => right(
        cachedMemberships.map((membership) => membership.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getAndCachePersonalMemberships({int page = 1, int pageSize = 100}) async {
    final remoteRes = await chirpCommunityMembershipRemoteDatasource
        .getPersonalMemberships(page: page, pageSize: pageSize);

    return remoteRes.fold((failure) async => await getAllCachedMemberships(), (
      fetched,
    ) async {
      final res = await chirpCommunityMembershipLocalDatasource
          .saveAllCommunityMemberships(fetched);
      return res.fold(
        (failure) => left(failure),
        (rawMemberships) => right(
          rawMemberships.map((membership) => membership.toEntity()).toList(),
        ),
      );
    });
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
  Future<Either<Failure, void>> leaveCommunity({
    required int communityID,
  }) async {
    final profileResult = await profileLocalDatasource.getCachedUserProfile();
    return await profileResult.fold((failure) => Left(failure), (
      userProfile,
    ) async {
      final membershipResult = await chirpCommunityMembershipLocalDatasource
          .getMembership(communityID: communityID, userID: userProfile.id);

      return await membershipResult.fold((failure) => Left(failure), (
        membership,
      ) async {
        // Anticipatory local deletion
        final deleteResult = await chirpCommunityMembershipLocalDatasource
            .deleteCached(membership);
        if (deleteResult.isLeft()) {
          return deleteResult.fold((l) => Left(l), (r) => const Right(null));
        }

        final remoteResult = await chirpCommunityMembershipRemoteDatasource
            .leaveCommunity(membershipID: membership.id.toString());

        return remoteResult.fold((failure) async {
          // Revert local change if remote call fails
          await chirpCommunityMembershipLocalDatasource
              .createOrUpdateCommunityMembership(membership);
          return Left(failure);
        }, (_) => const Right(null));
      });
    });
  }
}
