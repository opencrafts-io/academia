import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../domain/user_profile.dart';
import 'profile_api_paths.dart';

abstract interface class ProfileRemoteDatasource {
  Future<Either<Failure, UserProfile>> refreshCurrentUserProfile();
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile);
  Future<Either<Failure, UserProfile>> updateUserPhone(UserProfile profile);
  Future<Either<Failure, String>> requestAccountDeletion();
  Future<Either<Failure, String>> requestAccountRecovery();
}

@LazySingleton(as: ProfileRemoteDatasource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  const ProfileRemoteDatasourceImpl(this._apiClient, this._paths);

  final ApiClient _apiClient;
  final ProfileApiPaths _paths;

  @override
  Future<Either<Failure, UserProfile>> refreshCurrentUserProfile() => _apiClient
      .get(_paths.account, decoder: (json) => UserProfile.fromJson(json));

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile) =>
      _apiClient.patch(
        _paths.account,
        data: profile.toJson(),
        decoder: (json) => UserProfile.fromJson(json),
      );

  @override
  Future<Either<Failure, UserProfile>> updateUserPhone(UserProfile profile) =>
      _apiClient.patch(
        _paths.phone,
        data: {
          'id': profile.id, // needed for account ownership comparison
          'phone': profile.phone?.trim(),
        },
        decoder: (json) => UserProfile.fromJson(json),
      );

  @override
  Future<Either<Failure, String>> requestAccountDeletion() =>
      _apiClient.post(_paths.deletionRequest, decoder: _decodeMessage);

  @override
  Future<Either<Failure, String>> requestAccountRecovery() =>
      _apiClient.post(_paths.recovery, decoder: _decodeMessage);

  static String _decodeMessage(Object? value) {
    if (value is Map && value['message'] is String) {
      return value['message'] as String;
    }
    throw const FormatException('Invalid account response.');
  }
}
