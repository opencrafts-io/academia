import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class ModerateMembersUseCase {
   final CommunityRepository repository;

   ModerateMembersUseCase({required this.repository});

   Future<Either<Failure, Community>> call({
    required String groupId,
    required String action,
    required String userId,
  }) async {
    return repository.moderateCommunity(
      groupId: groupId,
      action: action,
      userId: userId,
    );
  } 
}