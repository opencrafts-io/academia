import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/chirp/communities/data/models/paginated_users_model_helper.dart';
import 'package:dartz/dartz.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDatasource remoteDatasource;
  final CommunityLocalDatasource communityLocalDatasource;

  CommunityRepositoryImpl({
    required this.remoteDatasource,
    required this.communityLocalDatasource,
  });

  @override
  Future<Either<Failure, Community>> createCommunity(
    Community community,
  ) async {
    final result = await remoteDatasource.createCommunity(
      community: community.toData(),
    );

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> getCommunityByID({
    required int communityID,
  }) async {
    // Check local cache first
    final localResult = await communityLocalDatasource.getCachedCommunityByID(
      communityID,
    );

    if (localResult.isRight()) {
      return right(((localResult as Right).value as CommunityData).toEntity());
    }

    // If not found locally, fetch from remote and cache
    final result = await remoteDatasource.getCommunityById(
      communityId: communityID,
    );

    return result.fold((failure) => left(failure), (community) async {
      await communityLocalDatasource.createorUpdateCommunity(community);
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
    required String memberId,
    required String memberName,
  }) async {
    final result = await remoteDatasource.moderateCommunity(
      groupId: groupId,
      action: action,
      userId: userId,
      memberId: memberId,
      memberName: memberName,
    );

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> joinCommunity({
    required String groupId,
    required String userId,
    required String userName,
  }) async {
    final result = await remoteDatasource.joinCommunity(
      groupId: groupId,
      userId: userId,
      userName: userName,
    );

    return await result.fold((failure) => left(failure), (community) async {
      await communityLocalDatasource.createorUpdateCommunity(community);
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, String>> leaveCommunity({
    required String groupId,
    required String userId,
    required String userName,
  }) async {
    final result = await remoteDatasource.leaveCommunity(
      groupId: groupId,
      userId: userId,
      userName: userName,
    );

    return result.fold((failure) => left(failure), (message) {
      return right(message);
    });
  }

  @override
  Future<Either<Failure, void>> deleteCommunity({
    required int communityID,
  }) async {
    final result = await remoteDatasource.deleteCommunity(
      communityID: communityID,
    );

    return result.fold((failure) => left(failure), (ok) async{
      await communityLocalDatasource.deleteCachedCommunity(communityID);
      return right(null);
    });
  }

  @override
  Future<Either<Failure, PaginatedResponse>> getCommunityMembers({
    required String communityId,
    required int page,
    required String userType,
  }) async {
    final result = await remoteDatasource.getCommunityMembers(
      communityId: communityId,
      page: page,
      userType: userType,
    );

    return result.fold((failure) => left(failure), (paginatedUserResponse) {
      return right(paginatedUserResponse.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> addCommunityGuidelines({
    required List<String> rule,
    required String communityId,
    required String userId,
  }) async {
    final result = await remoteDatasource.addCommunityGuidelines(
      rule: rule,
      communityId: communityId,
      userId: userId,
    );

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, List<Community>>> getPostableCommunities({
    int page = 1,
    int pageSize = 50,
  }) async {
    final result = await remoteDatasource.getPostableCommunities(
      page: page,
      pageSize: pageSize,
    );

    return result.fold(
      (failure) async {
        if (failure is NetworkFailure) {
          final cacheRes = await communityLocalDatasource
              .getCachedCommunities();
          if (cacheRes.isRight()) {
            final rawCommunities =
                (cacheRes as Right).value as List<CommunityData>;
            return right(
              rawCommunities.map((e) => e.toEntity()).toList(),
            ); // Return cache if available
          }
        }
        return left(
          failure,
        ); // If there's no cache or network failure, return error
      },
      (rawCommunities) async {
        final List<Community> communities = [];
        for (final community in rawCommunities) {
          final result = await communityLocalDatasource.createorUpdateCommunity(
            community,
          );
          if (result.isRight()) {
            communities.add(community.toEntity());
          }
        }
        return right(communities);
      },
    );
  }

  @override
  Future<Either<Failure, List<Community>>> searchForCommunity(
    String searchTerm, {
    int page = 0,
    int pageSize = 100,
  }) async {
    final result = await remoteDatasource.searchForCommunity(
      searchTerm,
      page: page,
      pageSize: pageSize,
    );

    return result.fold(
      (failure) => left(failure),
      (searched) => right(searched.map((e) => e.toEntity()).toList()),
    );
  }
}
