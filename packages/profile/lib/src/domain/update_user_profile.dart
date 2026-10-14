import 'package:core/core.dart';

import 'profile_repository.dart';
import 'user_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserProfile extends UseCase<UserProfile, UserProfile> {
  final ProfileRepository profileRepository;
  UpdateUserProfile({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    return profileRepository.updateUserProfile(profile);
  }
}
