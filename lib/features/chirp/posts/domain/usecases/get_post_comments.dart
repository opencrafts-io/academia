import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class GetPostCommentsUsecase {
  final ChirpRepository chirpRepository;

  GetPostCommentsUsecase({required this.chirpRepository});

  Future<Either<Failure, PaginatedData<Comment>>> call({
    required int postId,
    required int page,
    required int pageSize,
  }) async {
    return await chirpRepository.getPostComments(
      postId: postId,
      page: page,
      pageSize: pageSize,
    );
  }
}
