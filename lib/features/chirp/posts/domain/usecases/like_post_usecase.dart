import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class LikePostUsecase {
  final ChirpRepository chirpRepository;

  LikePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required Post post,
    required bool isCurrentlyLiked,
    required String voterId,
  }) async {
    return chirpRepository.toggleLike(
      post: post,
      isCurrentlyLiked: isCurrentlyLiked,
      voterId: voterId,
    );
  }
}
