import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class LikePostUsecase {
  final ChirpRepository chirpRepository;

  LikePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Map<String, dynamic>>> call(String postId, bool isLiked) async {
    return chirpRepository.toggleLike(postId, isLiked);
  }
}
