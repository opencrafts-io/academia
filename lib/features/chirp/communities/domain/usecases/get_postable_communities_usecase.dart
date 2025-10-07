import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/chirp/communities/communities.dart';
import 'package:dartz/dartz.dart';

class GetPostableCommunitiesUsecaseParams {
  final int page;
  final int pageSize;

  GetPostableCommunitiesUsecaseParams({
    required this.page,
    required this.pageSize,
  });
}

class GetPostableCommunitiesUsecase
    extends UseCase<List<Community>, GetPostableCommunitiesUsecaseParams> {
  final CommunityRepository communityRepository;

  GetPostableCommunitiesUsecase({required this.communityRepository});
  @override
  Future<Either<Failure, List<Community>>> call(
    GetPostableCommunitiesUsecaseParams params,
  ) async {
    return await communityRepository.getPostableCommunities(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
