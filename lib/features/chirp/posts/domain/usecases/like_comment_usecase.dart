import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class LikeCommentUsecase {
  final ChirpRepository chirpRepository;

  LikeCommentUsecase({required this.chirpRepository});

  Future<Either<Failure, Comment>> call({
    required Comment comment,
    required int voteValue,
    required String voterId,
  }) async {
    return chirpRepository.toggleCommentLike(
      comment: comment,
      voteValue: voteValue,
      voterId: voterId,
    );
  }
}
