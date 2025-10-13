import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class AddCommentUsecase {
  final ChirpRepository chirpRepository;

  AddCommentUsecase({required this.chirpRepository});

  Future<Either<Failure, Comment>> call({
    required int postId,
    required String authorId,
    required String content,
    int? parentId,
  }) {
    return chirpRepository.createComment(
      postId: postId,
      authorId: authorId,
      content: content,
      parent: parentId,
    );
  }
}
