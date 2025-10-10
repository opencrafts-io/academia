import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:dartz/dartz.dart';

class GetPersonalCommunityMembershipForCommunityUsecaseParams {
  final int communityID;
  final String userID;

  GetPersonalCommunityMembershipForCommunityUsecaseParams({
    required this.communityID,
    required this.userID,
  });
}

class GetPersonalCommunityMembershipForCommunityUsecase
    extends
        UseCase<
          ChirpCommunityMembership,
          GetPersonalCommunityMembershipForCommunityUsecaseParams
        > {
  ChirpCommunityMembershipRepository repository;
  GetPersonalCommunityMembershipForCommunityUsecase({required this.repository});

  @override
  Future<Either<Failure, ChirpCommunityMembership>> call(
    GetPersonalCommunityMembershipForCommunityUsecaseParams params,
  ) async {
    return await repository.getPersonalCommunityMemberShipForCommunity(
      communityID: params.communityID,
      userID: params.userID,
    );
  }
}
