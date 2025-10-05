import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/chirp/memberships/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCachedPersonalChirpCommunityMemberships
    extends UseCase<List<ChirpCommunityMembership>, NoParams> {
  final ChirpCommunityMembershipRepository repository;

  GetCachedPersonalChirpCommunityMemberships({required this.repository});

  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>> call(
    NoParams params,
  ) async {
    return await repository.getAllCachedMemberships();
  }
}
