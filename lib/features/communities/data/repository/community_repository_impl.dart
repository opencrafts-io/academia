import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/communities/communities.dart';
import 'package:academia/features/communities/data/models/paginated_users_model_helper.dart';
import 'package:dartz/dartz.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDatasource remoteDatasource;
  final CommunityLocalDatasource communityLocalDatasource;

  CommunityRepositoryImpl({
    required this.remoteDatasource,
    required this.communityLocalDatasource,
  });

  @override
  Future<Either<Failure, Community>> createCommunity({
    required String name,
    required String description,
    required bool isPublic,
    required String userId,
    required String userName,
    required String userEmail,
    String? logoPath,
    String? bannerPath,
  }) async {
    final result = await remoteDatasource.createCommunity(
      name: name,
      description: description,
      isPublic: isPublic,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      logoPath: logoPath,
      bannerPath: bannerPath,
    );

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> getCommunityById({
    required String communityId,
    required String userId,
  }) async {
    final result = await remoteDatasource.getCommunityById(
      communityId: communityId,
      userId: userId,
    );

    return result.fold((failure) => left(failure), (community) {
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

    return await result.fold((failure) => left(failure), (message) async {
      return right(message);
    });
  }

  @override
  Future<Either<Failure, String>> deleteCommunity({
    required String groupId,
    required String userId,
  }) async {
    final result = await remoteDatasource.deleteCommunity(
      groupId: groupId,
      userId: userId,
    );

    return result.fold((failure) => left(failure), (message) {
      return right(message);
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
  Future<Either<Failure, List<Community>>> getPostableCommunities() async {
    final result = await remoteDatasource.getPostableCommunities();
    return await result.fold(
      (failure) async {
        final cacheRes = await communityLocalDatasource.getCachedCommunities();
        if (cacheRes.isLeft()) {
          return left(failure);
        }

        final rawCommunities = (cacheRes as Right).value as List<CommunityData>;
        return right(
          rawCommunities.map((community) => community.toEntity()).toList(),
        );
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
}
