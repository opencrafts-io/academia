import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class GetPostCommentsUsecase {
  final ChirpRepository chirpRepository;

  GetPostCommentsUsecase({required this.chirpRepository});

  Future<Either<Failure, List<Comment>>> call({required int postId}) async {
    return await chirpRepository.getPostComments(postId: postId);
  }
}
