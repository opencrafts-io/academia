import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class GetFeedPostsUsecase{
  final ChirpRepository chirpRepository;

  GetFeedPostsUsecase(this.chirpRepository);

  Future<Either<Failure, PaginatedData<Post>>> call({
    required int page,
    required int pageSize,
  }) async {
    return await chirpRepository.getFeedPosts(page: page, pageSize: pageSize);
  }
}

