import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getCachedUserProfile();
  Future<Either<Failure, UserProfile>> refreshUserProfile();
  Future<Either<Failure, UserProfile>> deleteUserProfile();
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userprofile,
  );
}
