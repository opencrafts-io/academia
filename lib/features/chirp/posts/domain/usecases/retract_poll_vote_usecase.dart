import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class RetractPollVoteUsecase {
  final ChirpRepository chirpRepository;

  RetractPollVoteUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required Post post,
    required String voterId,
  }) {
    return chirpRepository.retractPollVote(post: post, voterId: voterId);
  }
}
