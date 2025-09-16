import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_repository.dart';
import 'package:dartz/dartz.dart';

class CommentUsecase {
  final ChirpRepository chirpRepository;

  CommentUsecase({required this.chirpRepository});


  Future<Either<Failure, PostReply>> call({ required String postId, required String content, required String userId, required String userName, String? parentId}) {
    return chirpRepository.addComment(postId: postId, content:content, userName: userName, parentId: parentId, userId: userId);
  }
}
