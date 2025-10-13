import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/chirp/memberships/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetRemotePersonalChirpMembershipsUsecaseParams {
  final int page;
  final int pageSize;

  GetRemotePersonalChirpMembershipsUsecaseParams({
    required this.page,
    required this.pageSize,
  });
}

class GetRemotePersonalChirpMembershipsUsecase
    extends
        UseCase<
          List<ChirpCommunityMembership>,
          GetRemotePersonalChirpMembershipsUsecaseParams
        > {
  final ChirpCommunityMembershipRepository repository;

  GetRemotePersonalChirpMembershipsUsecase({required this.repository});
  @override
  Future<Either<Failure, List<ChirpCommunityMembership>>> call(
    GetRemotePersonalChirpMembershipsUsecaseParams params,
  ) async {
    return await repository.getPersonalMemberships(
      pageSize: params.pageSize,
      page: params.page,
    );
  }
}
