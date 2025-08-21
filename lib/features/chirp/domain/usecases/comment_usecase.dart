import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_repository.dart';
import 'package:dartz/dartz.dart';

class CommentUsecase {
  final ChirpRepository chirpRepository;

  CommentUsecase({required this.chirpRepository});


  Future<Either<Failure, Unit>> call(String postId, String content) {
    return chirpRepository.addComment(postId, content);
  }
}
