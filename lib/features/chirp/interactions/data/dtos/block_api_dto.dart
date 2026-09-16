import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_api_dto.freezed.dart';
part 'block_api_dto.g.dart';

@freezed
abstract class BlockApiDto with _$BlockApiDto {
  const factory BlockApiDto({
    required int id,
    @JsonKey(name: 'block_type') required String blockType,
    @JsonKey(name: 'blocked_user') String? blockedUser,
    @JsonKey(name: 'blocked_community') int? blockedCommunity,
    @JsonKey(name: 'blocked_name') String? blockedName,
    @JsonKey(name: 'blocked_image') String? blockedImage,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _BlockApiDto;

  factory BlockApiDto.fromJson(Map<String, dynamic> json) =>
      _$BlockApiDtoFromJson(json);
}
