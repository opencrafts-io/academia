import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, Community>> createCommunity({
    required String name,
    required String description,
    required bool isPublic,
    required String userId,
    required String userName,
    required String userEmail,
    String? logoPath,
    String? bannerPath,
  });

  Future<Either<Failure, Community>> getCommunityById(String id);

  Future<Either<Failure, Community>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
  });

  Future<Either<Failure, Community>> joinCommunity({required String groupId});

  Future<Either<Failure, String>> leaveCommunity({required String groupId});

  Future<Either<Failure, String>> deleteCommunity({
    required String groupId,
    required String userId,
  });
}
