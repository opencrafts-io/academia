import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCommunityUseCase {
  final CommunityRepository repository;

  DeleteCommunityUseCase({required this.repository});

  Future<Either<Failure, String>> call(String groupId) {
    return repository.deleteCommunity(groupId: groupId);
  } 
}