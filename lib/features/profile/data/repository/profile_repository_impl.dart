import 'package:academia/core/error/failures.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDatasource profileLocalDatasource;
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl({
    required this.profileRemoteDatasource,
    required this.profileLocalDatasource,
  });

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userProfile,
  ) async {
    // First attempt with remote
    final remoteResponse = await profileRemoteDatasource.updateUserProfile(
      userProfile.toData(),
    );

    if (remoteResponse.isLeft()) {
      return left((remoteResponse as Left).value);
    }

    final cacheResult = await profileLocalDatasource.createOrUpdateUserProfile(
      (remoteResponse as Right).value,
    );
    return cacheResult.fold((failure) => left(failure), (userProfile) {
      return right(userProfile.toEntity());
    });
  }

  @override
  Future<Either<Failure, void>> deleteCachedUserProfile(
    UserProfile userprofile,
  ) async {
    return await profileLocalDatasource.deleteProfile(userprofile.toData());
  }

  @override
  Future<Either<Failure, UserProfile>> refreshUserProfile() async {
    final remoteResult = await profileRemoteDatasource
        .refreshCurrentUserProfile();

    if (remoteResult.isLeft()) {
      return left((remoteResult as Left).value);
    }

    // cache the refreshed
    final result = await profileLocalDatasource.createOrUpdateUserProfile(
      (remoteResult as Right).value,
    );
    return result.fold(
      (failure) => left(failure),
      (profileData) => right(profileData.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfile>> getCachedUserProfile() async {
    final result = await profileLocalDatasource.getCachedUserProfile();
    return result.fold(
      (failure) => left(failure),
      (userProfileData) => right(userProfileData.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserPhone(
    UserProfile userProfile,
  ) async {
    final remoteResponse = await profileRemoteDatasource.updateUserPhone(
      userProfile.toData(),
    );

    if (remoteResponse.isLeft()) {
      return left((remoteResponse as Left).value);
    }

    final cacheResult = await profileLocalDatasource.createOrUpdateUserProfile(
      (remoteResponse as Right).value,
    );
    return cacheResult.fold((failure) => left(failure), (userProfile) {
      return right(userProfile.toEntity());
    });
  }
}
