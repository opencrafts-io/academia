import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class DeletePostCommentUsecase {
  final ChirpRepository repository;

  DeletePostCommentUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required int commentId}) {
    return repository.deletePostComment(commentId: commentId);
  }
}