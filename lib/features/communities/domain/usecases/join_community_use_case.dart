import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class JoinCommunityUseCase {
  final CommunityRepository repository;

  JoinCommunityUseCase({required this.repository});

  Future<Either<Failure, Community>> call(String groupId) {
    return repository.joinCommunity(groupId: groupId);
  }
}