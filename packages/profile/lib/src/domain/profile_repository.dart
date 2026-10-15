import 'package:core/core.dart';

import 'user_profile.dart';

import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getCachedUserProfile();
  Future<Either<Failure, UserProfile>> refreshUserProfile();
  Future<Either<Failure, void>> deleteCachedUserProfile(
    UserProfile userprofile,
  );
  Future<Either<Failure, void>> clearCachedUserProfile();
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userprofile,
  );
  Future<Either<Failure, UserProfile>> updateUserPhone(UserProfile userprofile);

  Future<Either<Failure, String>> requestAccountDeletion();
  Future<Either<Failure, String>> requestAccountRecovery();
}
