import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/communities/communities.dart';
import 'package:dartz/dartz.dart';

class GetPostableCommunitiesUsecase
    extends UseCase<PaginatedCommunity, NoParams> {
  final CommunityRepository communityRepository;

  GetPostableCommunitiesUsecase({required this.communityRepository});
  @override
  Future<Either<Failure, PaginatedCommunity>> call(NoParams params) async {
    return await communityRepository.getPostableCommunities();
  }
}
