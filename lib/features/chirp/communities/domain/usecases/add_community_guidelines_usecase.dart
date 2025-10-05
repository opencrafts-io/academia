import 'package:academia/core/error/failures.dart';
import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:academia/features/chirp/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class AddCommunityGuidelinesUsecase {
  final CommunityRepository repository;

  AddCommunityGuidelinesUsecase({required this.repository});

  Future<Either<Failure, Community>> call({
    required List<String> rule,
    required String communityId,
    required String userId,
  }) {
    return repository.addCommunityGuidelines(
      rule: rule,
      communityId: communityId,
      userId: userId,
    );
  }
}
