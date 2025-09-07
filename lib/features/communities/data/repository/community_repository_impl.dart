import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/data/datasources/community_remote_datasource.dart';
import 'package:academia/features/communities/data/models/community_model_helper.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
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
  Future<Either<Failure, Community>> getCommunityById(String id) async {
    final result = await remoteDatasource.getCommunityById(id);

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
  }) async {
    final result = await remoteDatasource.moderateCommunity(
      groupId: groupId,
      action: action,
      userId: userId,
    );

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, Community>> joinCommunity({
    required String groupId,
  }) async {
    final result = await remoteDatasource.joinCommunity(groupId: groupId);

    return result.fold((failure) => left(failure), (community) {
      return right(community.toEntity());
    });
  }

  @override
  Future<Either<Failure, String>> leaveCommunity({
    required String groupId,
  }) async {
    final result = await remoteDatasource.leaveCommunity(groupId: groupId);

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
}
