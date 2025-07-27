import 'package:academia/core/error/failures.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userProfile,
  ) {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfile>> deleteUserProfile() {
    // TODO: implement deleteUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfile>> refreshUserProfile() {
    // TODO: implement refreshUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserProfile>> getCachedUserProfile() {
    // TODO: implement getCachedUserProfile
    throw UnimplementedError();
  }
}
