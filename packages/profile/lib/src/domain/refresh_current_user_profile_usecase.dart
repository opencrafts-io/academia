import 'package:core/core.dart';

import 'profile_repository.dart';
import 'user_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RefreshCurrentUserProfileUsecase
    implements UseCase<UserProfile, NoUseCaseParams> {
  final ProfileRepository profileRepository;

  RefreshCurrentUserProfileUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(NoUseCaseParams params) async {
    return profileRepository.refreshUserProfile();
  }
}
