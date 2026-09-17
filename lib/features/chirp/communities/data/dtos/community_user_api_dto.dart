import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_user_api_dto.freezed.dart';
part 'community_user_api_dto.g.dart';

@freezed
abstract class CommunityUserApiDto with _$CommunityUserApiDto {
  const factory CommunityUserApiDto({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    required String role,
  }) = _CommunityUserApiDto;

  factory CommunityUserApiDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityUserApiDtoFromJson(json);
}
