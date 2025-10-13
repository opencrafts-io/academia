import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/memberships/memberships.dart';
import 'package:dartz/dartz.dart';

class JoinCommunityUsecase extends UseCase<ChirpCommunityMembership, int> {
  final ChirpCommunityMembershipRepository chirpCommunityMembershipRepository;

  JoinCommunityUsecase({required this.chirpCommunityMembershipRepository});

  @override
  Future<Either<Failure, ChirpCommunityMembership>> call(
    int communityID,
  ) async {
    return await chirpCommunityMembershipRepository.joinCommunity(
      communityID: communityID,
    );
  }
}
