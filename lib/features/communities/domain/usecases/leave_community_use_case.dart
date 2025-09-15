import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class LeaveCommunityUseCase {
  final CommunityRepository repository;

  LeaveCommunityUseCase({required this.repository});

  Future<Either<Failure, String>> call(
    String groupId,
    String userId,
    String userName,
  ) {
    return repository.leaveCommunity(
      groupId: groupId,
      userId: userId,
      userName: userName,
    );
  }
}
