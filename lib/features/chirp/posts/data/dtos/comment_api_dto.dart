import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_api_dto.freezed.dart';
part 'comment_api_dto.g.dart';

@freezed
abstract class CommentApiDto with _$CommentApiDto {
  const factory CommentApiDto({
    required int id,
    required int post,
    @JsonKey(name: 'author_id') required String authorId,
    required String content,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @Default(0) int upvotes,
    @Default(0) int downvotes,
    @Default([]) List<CommentApiDto> replies,
    int? parent,
  }) = _CommentApiDto;

  factory CommentApiDto.fromJson(Map<String, dynamic> json) =>
      _$CommentApiDtoFromJson(json);
}
