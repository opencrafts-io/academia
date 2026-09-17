import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_user_api_dto.freezed.dart';
part 'chirp_user_api_dto.g.dart';

@freezed
abstract class ChirpUserApiDto with _$ChirpUserApiDto {
  const factory ChirpUserApiDto({
    @JsonKey(name: 'user_id') required String userId,
    String? email,
    String? phone,
    String? username,
    @JsonKey(name: 'vibe_points') @Default(0) int vibePoints,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ChirpUserApiDto;

  factory ChirpUserApiDto.fromJson(Map<String, dynamic> json) =>
      _$ChirpUserApiDtoFromJson(json);
}
