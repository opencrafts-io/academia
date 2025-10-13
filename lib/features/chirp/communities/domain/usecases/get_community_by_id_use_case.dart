import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:academia/features/chirp/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommunityByIdUseCase {
  final CommunityRepository repository;

  GetCommunityByIdUseCase({required this.repository});

  Future<Either<Failure, Community>> call(int communityID) {
    return repository.getCommunityByID(
      communityID: communityID,
    );
  }
}
