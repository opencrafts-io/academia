import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetPostRepliesUsecase {
  final ChirpRepository chirpRepository;

  GetPostRepliesUsecase({required this.chirpRepository});

  Future<Either<Failure, List<PostReply>>> call(String postId) async {
    return await chirpRepository.getPostReplies(postId);
  }
}
