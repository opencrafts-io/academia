import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/paginated_response.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommunityMembersUsecase {
  final CommunityRepository repository;

  GetCommunityMembersUsecase({required this.repository});

  Future<Either<Failure, PaginatedResponse>> call({
    required String communityId,
    required int page,
    required String userType,
  }) {
    return repository.getCommunityMembers(
      communityId: communityId,
      page: page,
      userType: userType,
    );
  }
}
