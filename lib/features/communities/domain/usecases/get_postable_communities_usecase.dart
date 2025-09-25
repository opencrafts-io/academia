import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/communities/communities.dart';
import 'package:dartz/dartz.dart';

class GetPostableCommunitiesUsecase extends UseCase<List<Community>, NoParams> {
  final CommunityRepository communityRepository;

  GetPostableCommunitiesUsecase({required this.communityRepository});
  @override
  Future<Either<Failure, List<Community>>> call(NoParams params) async {
    return await communityRepository.getPostableCommunities();
  }
}
