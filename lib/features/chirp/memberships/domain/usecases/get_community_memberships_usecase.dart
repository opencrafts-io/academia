import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:dartz/dartz.dart';

class GetCommunityMembershipsUsecaseParams {
  final int page;
  final int pageSize;
  final int communityID;

  GetCommunityMembershipsUsecaseParams({
    required this.page,
    required this.communityID,
    required this.pageSize,
  });
}

class GetCommunityMembershipsUsecase
    extends
        UseCase<
          List<ChirpCommunityMembership>,
          GetCommunityMembershipsUsecaseParams
        > {
  final ChirpCommunityMembershipRepository communityMembershipRepository;

  GetCommunityMembershipsUsecase({required this.communityMembershipRepository});

  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>> call(params) {
    return communityMembershipRepository.getCommunityMemberships(
      communityID: params.communityID,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
