import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class CheckPostLikedUsecase {
  final ChirpRepository chirpRepository;

  CheckPostLikedUsecase({required this.chirpRepository});

  Future<Either<Failure, bool>> call({required int postId}) {
    return chirpRepository.checkIsLiked(postId: postId);
  }
}
