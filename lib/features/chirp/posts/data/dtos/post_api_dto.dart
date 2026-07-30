import 'package:academia/features/chirp/communities/data/dtos/community_api_dto.dart';
import 'package:academia/features/chirp/posts/data/dtos/attachment_api_dto.dart';
import 'package:academia/features/chirp/posts/data/dtos/comment_api_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_api_dto.freezed.dart';
part 'post_api_dto.g.dart';

@freezed
abstract class PostApiDto with _$PostApiDto {
  const factory PostApiDto({
    required int id,
    required CommunityApiDto community,
    @JsonKey(name: 'author_id') required String authorId,
    required String title,
    required String content,
    @Default(0) int upvotes,
    @Default(0) int downvotes,
    @Default([]) List<AttachmentApiDto> attachments,
    @JsonKey(name: 'views_count') @Default(0) int viewsCount,
    @JsonKey(name: 'comment_count') @Default(0) int commentCount,
    @Default([]) List<CommentApiDto> comments,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PostApiDto;

  factory PostApiDto.fromJson(Map<String, dynamic> json) =>
      _$PostApiDtoFromJson(json);
}
