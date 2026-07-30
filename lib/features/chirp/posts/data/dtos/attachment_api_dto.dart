import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_api_dto.freezed.dart';
part 'attachment_api_dto.g.dart';

@freezed
abstract class AttachmentApiDto with _$AttachmentApiDto {
  const factory AttachmentApiDto({
    required int id,
    @JsonKey(name: 'attachment_type') required String attachmentType,
    required String file,
    @JsonKey(name: 'file_size') required int size,
    @JsonKey(name: 'original_filename') required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'post') required int postId,
  }) = _AttachmentApiDto;

  factory AttachmentApiDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentApiDtoFromJson(json);
}
