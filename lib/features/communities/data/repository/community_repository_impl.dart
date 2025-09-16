import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/data/datasources/community_remote_datasource.dart';
import 'package:academia/features/communities/data/models/community_model_helper.dart';
import 'package:academia/features/communities/data/models/paginated_users_model_helper.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/entities/paginated_response.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDatasource remoteDatasource;

  CommunityRepositoryImpl({required this.remoteDatasource});

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

    return result.fold((failure) => left(failure), (community) {
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
  Future<Either<Failure, PaginatedResponse>> getCommunityMembers(
    {
    required String communityId,
    required int page,
    required String userType
  }
  ) async {
    final result = await remoteDatasource.getCommunityMembers(
      communityId: communityId,
      page: page,
      userType: userType
    );

    return result.fold((failure) => left(failure), (paginatedUserResponse) {
      return right(paginatedUserResponse.toEntity());
    });
  }
}
