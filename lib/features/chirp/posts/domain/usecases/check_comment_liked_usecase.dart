import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class CheckCommentLikedUsecase {
  final ChirpRepository chirpRepository;

  CheckCommentLikedUsecase({required this.chirpRepository});

  Future<Either<Failure, int>> call({required int commentId}) {
    return chirpRepository.checkIsCommentLiked(commentId: commentId);
  }
}
