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
  Future<Either<Failure, UserProfile>> refreshCurrentUserProfile() =>
      _apiClient.get(_paths.account, decoder: _decodeProfile);

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile) =>
      _apiClient.patch(
        _paths.account,
        data: {
          'id': profile.id, // needed for account ownership comparison
          'name': profile.name.trim(),
          'username': profile.username?.trim(),
          'national_id': profile.nationalID?.trim(),
          'onboarded': profile.onboarded,
          'terms_accepted': profile.termsAccepted,
        },
        decoder: _decodeProfile,
      );

  @override
  Future<Either<Failure, UserProfile>> updateUserPhone(UserProfile profile) =>
      _apiClient.patch(
        _paths.phone,
        data: {
          'id': profile.id, // needed for account ownership comparison
          'phone': profile.phone?.trim(),
        },
        decoder: _decodeProfile,
      );

  @override
  Future<Either<Failure, String>> requestAccountDeletion() =>
      _apiClient.post(_paths.deletionRequest, decoder: _decodeMessage);

  @override
  Future<Either<Failure, String>> requestAccountRecovery() =>
      _apiClient.post(_paths.recovery, decoder: _decodeMessage);

  static UserProfile _decodeProfile(Object? value) {
    if (value is! Map) throw const FormatException('Invalid profile response.');
    final json = value.cast<String, dynamic>();
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      username: json['username'] as String?,
      email: json['email'] as String? ?? '',
      termsAccepted: json['terms_accepted'] as bool? ?? false,
      onboarded: json['onboarded'] as bool? ?? false,
      nationalID: json['national_id'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      phone: json['phone'] as String?,
      vibePoints: json['vibe_points'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );
  }

  static String _decodeMessage(Object? value) {
    if (value is Map && value['message'] is String) {
      return value['message'] as String;
    }
    throw const FormatException('Invalid account response.');
  }
}
