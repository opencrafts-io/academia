import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, Community>> createCommunity(Community community);

  Future<Either<Failure, Community>> getCommunityByID({
    required int communityID,
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
    required String userType,
  });

  Future<Either<Failure, Community>> addCommunityGuidelines({
    required List<String> rule,
    required String communityId,
    required String userId,
  });

  Future<Either<Failure, List<Community>>> getPostableCommunities({
    int page = 1,
    int pageSize = 50,
  });

  Future<Either<Failure, List<Community>>> searchForCommunity(
    String searchTerm, {
    int page = 1,
    int pageSize = 50,
  });
}
