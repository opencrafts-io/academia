import 'package:academia/core/error/failures.dart';
import 'package:academia/features/communities/domain/entities/community.dart';
import 'package:academia/features/communities/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';

class CreateCommunityUseCase {
  final CommunityRepository repository;

  CreateCommunityUseCase({required this.repository});

  Future<Either<Failure, Community>> call({
    required String name,
    required String description,
    required bool isPublic,
    required String userId,
    required String userName,
    required String userEmail,
    String? logoPath,
    String? bannerPath,
  }) {
    return repository.createCommunity(
      name: name,
      description: description,
      isPublic: isPublic,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      logoPath: logoPath,
      bannerPath: bannerPath,
    );
  }
}
