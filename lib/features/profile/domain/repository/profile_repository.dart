import 'package:academia/core/core.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getCachedUserProfile();
  Future<Either<Failure, UserProfile>> refreshUserProfile();
  Future<Either<Failure, void>> deleteCachedUserProfile(
    UserProfile userprofile,
  );
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userprofile,
  );
  Future<Either<Failure, UserProfile>> updateUserPhone(
    UserProfile userprofile,
  );
}
