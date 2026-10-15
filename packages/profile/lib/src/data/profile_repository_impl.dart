import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';
import 'profile_local_datasource.dart';
import 'profile_remote_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._remote, this._local);

  final ProfileRemoteDatasource _remote;
  final ProfileLocalDatasource _local;

  @override
  Future<Either<Failure, UserProfile>> refreshUserProfile() =>
      _cacheRemote(_remote.refreshCurrentUserProfile());

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    UserProfile userProfile,
  ) => _cacheRemote(_remote.updateUserProfile(userProfile));

  @override
  Future<Either<Failure, UserProfile>> updateUserPhone(
    UserProfile userProfile,
  ) => _cacheRemote(_remote.updateUserPhone(userProfile));

  @override
  Future<Either<Failure, UserProfile>> getCachedUserProfile() =>
      _local.getCachedUserProfile();

  @override
  Future<Either<Failure, void>> deleteCachedUserProfile(
    UserProfile userProfile,
  ) => _local.deleteProfile(userProfile.id);

  @override
  Future<Either<Failure, void>> clearCachedUserProfile() =>
      _local.clearProfile();

  @override
  Future<Either<Failure, String>> requestAccountDeletion() =>
      _remote.requestAccountDeletion();

  @override
  Future<Either<Failure, String>> requestAccountRecovery() =>
      _remote.requestAccountRecovery();

  Future<Either<Failure, UserProfile>> _cacheRemote(
    Future<Either<Failure, UserProfile>> response,
  ) async {
    final result = await response;
    return result.fold(
      (failure) => left(failure),
      (profile) => _local.saveUserProfile(profile),
    );
  }
}
