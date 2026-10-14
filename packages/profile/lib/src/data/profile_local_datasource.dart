import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../domain/user_profile.dart';

@lazySingleton
class ProfileLocalDatasource {
  const ProfileLocalDatasource(this._profileDao);

  final ProfileDao _profileDao;

  Future<Either<Failure, UserProfile>> getCachedUserProfile() async {
    try {
      final profile = await _profileDao.getProfile();
      return profile == null
          ? left(
              Failure.cache(
                message: 'No cached profile is available.',
                error: Exception('No cached profile.'),
              ),
            )
          : right(_toEntity(profile));
    } catch (error, stackTrace) {
      return left(
        Failure.cache(
          message: 'The cached profile could not be loaded.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Either<Failure, UserProfile>> saveUserProfile(
    UserProfile profile,
  ) async {
    try {
      await _profileDao.saveProfile(_toCompanion(profile));
      return right(profile);
    } catch (error, stackTrace) {
      return left(
        Failure.cache(
          message: 'The profile could not be saved on this device.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Either<Failure, void>> clearProfile() async {
    try {
      await _profileDao.clearProfile();
      return right(null);
    } catch (error, stackTrace) {
      return left(
        Failure.cache(
          message: 'The cached profile could not be cleared.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteProfile(String id) async {
    try {
      await _profileDao.deleteProfile(id);
      return right(null);
    } catch (error, stackTrace) {
      return left(
        Failure.cache(
          message: 'The cached profile could not be deleted.',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  UserProfile _toEntity(Profile profile) => UserProfile(
    id: profile.id,
    name: profile.name,
    username: profile.username,
    email: profile.email,
    termsAccepted: profile.termsAccepted,
    onboarded: profile.onboarded,
    nationalID: profile.nationalId,
    avatarUrl: profile.avatarUrl,
    bio: profile.bio,
    phone: profile.phone,
    vibePoints: profile.vibePoints,
    createdAt: profile.createdAt,
    updatedAt: profile.updatedAt,
    deletedAt: profile.deletedAt,
  );

  ProfilesCompanion _toCompanion(UserProfile profile) => ProfilesCompanion(
    id: Value(profile.id),
    name: Value(profile.name),
    username: Value(profile.username),
    email: Value(profile.email),
    termsAccepted: Value(profile.termsAccepted),
    onboarded: Value(profile.onboarded),
    nationalId: Value(profile.nationalID),
    avatarUrl: Value(profile.avatarUrl),
    bio: Value(profile.bio),
    phone: Value(profile.phone),
    vibePoints: Value(profile.vibePoints),
    createdAt: Value(profile.createdAt),
    updatedAt: Value(profile.updatedAt),
    deletedAt: Value(profile.deletedAt),
  );
}
