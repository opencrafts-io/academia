import 'package:core/core.dart';

import 'profile_repository.dart';
import 'user_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserPhone extends UseCase<UserProfile, UserProfile> {
  final ProfileRepository profileRepository;
  UpdateUserPhone({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    return profileRepository.updateUserPhone(profile);
  }
}
