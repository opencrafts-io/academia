import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class CreatePostUsecase {
  final ChirpRepository chirpRepository;

  CreatePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  }) async {
    return chirpRepository.createPost(
      title: title,
      authorId: authorId,
      communityId: communityId,
      content: content,
    );
  }
}
