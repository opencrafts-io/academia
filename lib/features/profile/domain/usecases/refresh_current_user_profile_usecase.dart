import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class RefreshCurrentUserProfileUsecase
    implements UseCase<UserProfile, NoParams> {
  final ProfileRepository profileRepository;

  RefreshCurrentUserProfileUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    return profileRepository.refreshUserProfile();
  }
}
