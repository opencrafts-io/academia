import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class UpdateUserPhone extends UseCase<UserProfile, UserProfile> {
  final ProfileRepository profileRepository;
  UpdateUserPhone({required this.profileRepository});

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile profile) async {
    return profileRepository.updateUserPhone(profile);
  }
}
