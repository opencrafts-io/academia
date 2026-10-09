import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class GetPollVotersUsecase {
  final ChirpRepository chirpRepository;

  GetPollVotersUsecase({required this.chirpRepository});

  Future<Either<Failure, PaginatedData<PollVoter>>> call({
    required int pollId,
    int? optionId,
    int page = 1,
    int pageSize = 20,
  }) {
    return chirpRepository.getPollVoters(
      pollId: pollId,
      optionId: optionId,
      page: page,
      pageSize: pageSize,
    );
  }
}
