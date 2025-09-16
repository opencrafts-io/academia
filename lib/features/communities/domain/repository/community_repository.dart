import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/entities/paginated_response.dart';
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

  Future<Either<Failure, Community>> getCommunityById({
    required String communityId,
    required String userId,
  });

  Future<Either<Failure, Community>> moderateCommunity({
    required String groupId,
    required String action,
    required String userId,
    required String memberId,
    required String memberName,
  });

  Future<Either<Failure, Community>> joinCommunity({
    required String groupId,
    required String userId,
    required String userName,
  });

  Future<Either<Failure, String>> leaveCommunity({
    required String groupId,
    required String userId,
    required String userName,
  });

  Future<Either<Failure, String>> deleteCommunity({
    required String groupId,
    required String userId,
  });

  Future<Either<Failure, PaginatedResponse>> getCommunityMembers({
    required String communityId,
    required int page,
    required String userType
  });
}
