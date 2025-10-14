import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class DeleteCommunityUseCase extends UseCase<void, int> {
  final CommunityRepository repository;

  DeleteCommunityUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(int communityID) {
    return repository.deleteCommunity(communityID: communityID);
  }
}

