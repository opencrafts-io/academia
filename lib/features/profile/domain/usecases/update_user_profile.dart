import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class UpdateUserProfile extends UseCase<UserProfile, UserProfile> {
  final ProfileRepository profileRepository;
  UpdateUserProfile({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    return profileRepository.updateUserProfile(profile);
  }
}
