import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class GetPostsFromCommunityUsecase {
  final ChirpRepository repository;

  GetPostsFromCommunityUsecase({required this.repository});

  Future<Either<Failure, PaginatedData<Post>>> call({
    required int communityId,
    required int page,
    required pageSize,
  }) async {
    return await repository.getPostsFromCommunity(
      communityId: communityId,
      page: page,
      pageSize: pageSize,
    );
  }
}
