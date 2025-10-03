import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCommunityUseCase extends UseCase<Community, Community> {
  final CommunityRepository repository;

  CreateCommunityUseCase({required this.repository});

  @override
  Future<Either<Failure, Community>> call(Community community) {
    return repository.createCommunity(community);
  }
}
