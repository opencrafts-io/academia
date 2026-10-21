import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    required String? username,
    required String email,
    @JsonKey(name: 'terms_accepted') required bool termsAccepted,
    required bool onboarded,
    @JsonKey(name: 'national_id') required String? nationalID,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required String? bio,
    @JsonKey(name: 'vibe_points') required int vibePoints,
    required String? phone,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
