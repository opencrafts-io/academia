import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class VoteOnPollUsecase {
  final ChirpRepository chirpRepository;

  VoteOnPollUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required Post post,
    required List<int> optionIds,
    required String voterId,
  }) {
    return chirpRepository.voteOnPoll(
      post: post,
      optionIds: optionIds,
      voterId: voterId,
    );
  }
}
