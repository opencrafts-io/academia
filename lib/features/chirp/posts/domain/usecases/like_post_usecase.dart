import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class LikePostUsecase {
  final ChirpRepository chirpRepository;

  LikePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required Post post,
    required int voteValue,
    required String voterId,
  }) async {
    return chirpRepository.toggleLike(
      post: post,
      voteValue: voteValue,
      voterId: voterId,
    );
  }
}
