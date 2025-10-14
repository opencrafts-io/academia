import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/chirp/memberships/domain/domain.dart';
import 'package:dartz/dartz.dart';

class LeaveCommunityUsecase extends UseCase<void, int> {
  final ChirpCommunityMembershipRepository repository;

  LeaveCommunityUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(int communityID) async {
    return await repository.leaveCommunity(communityID: communityID);
  }
}
