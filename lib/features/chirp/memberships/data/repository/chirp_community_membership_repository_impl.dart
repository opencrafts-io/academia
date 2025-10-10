import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:dartz/dartz.dart';

class ChirpCommunityMembershipRepositoryImpl
    implements ChirpCommunityMembershipRepository {
  final ChirpCommunityMembershipRemoteDatasource
  chirpCommunityMembershipRemoteDatasource;
  final ChirpCommunityMembershipLocalDatasource
  chirpCommunityMembershipLocalDatasource;

  ChirpCommunityMembershipRepositoryImpl({
    required this.chirpCommunityMembershipLocalDatasource,
    required this.chirpCommunityMembershipRemoteDatasource,
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
  getPersonalMemberships({int page = 1, int pageSize = 100}) async {
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
    required int communityID,
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
    final remoteRes = await chirpCommunityMembershipRemoteDatasource
        .leaveCommunity(communityID: communityID);

    return remoteRes.fold((failure) => left(failure), (ok) async {
      final localRes = await chirpCommunityMembershipLocalDatasource
          .deleteCached(communityID);
      return right(null);
    });
  }

  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>>
  getCommunityMemberships({
    required int communityID,
    int page = 1,
    int pageSize = 50,
  }) async {
    final remoteResult = await chirpCommunityMembershipRemoteDatasource
        .getCommunityMemberships(communityID, page: page, pageSize: pageSize);

    return remoteResult.fold(
      (failure) async {
        final cachedResult = await chirpCommunityMembershipLocalDatasource
            .getCommunityMembershipByCommunityID(communityID);
        return cachedResult.fold((cacheFailure) => Left(cacheFailure), (
          cachedMemberships,
        ) {
          return Right(cachedMemberships.map((e) => e.toEntity()).toList());
        });
      },
      (fetchedMemberships) async {
        final saveResult = await chirpCommunityMembershipLocalDatasource
            .saveAllCommunityMemberships(fetchedMemberships);
        return saveResult.fold((cacheFailure) => Left(cacheFailure), (
          savedMemberships,
        ) {
          return Right(savedMemberships.map((e) => e.toEntity()).toList());
        });
      },
    );
  }

  @override
  Future<Either<Failure, ChirpCommunityMembership>>
  getPersonalCommunityMemberShipForCommunity({required int communityID}) {
    throw UnimplementedError();
  }
}
