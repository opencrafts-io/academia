// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostApiDto _$PostApiDtoFromJson(Map<String, dynamic> json) => _PostApiDto(
  id: (json['id'] as num).toInt(),
  community: CommunityApiDto.fromJson(
    json['community'] as Map<String, dynamic>,
  ),
  authorId: json['author_id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  upvotes: (json['upvotes'] as num?)?.toInt() ?? 0,
  downvotes: (json['downvotes'] as num?)?.toInt() ?? 0,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentApiDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  viewsCount: (json['views_count'] as num?)?.toInt() ?? 0,
  commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentApiDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PostApiDtoToJson(_PostApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'community': instance.community,
      'author_id': instance.authorId,
      'title': instance.title,
      'content': instance.content,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'attachments': instance.attachments,
      'views_count': instance.viewsCount,
      'comment_count': instance.commentCount,
      'comments': instance.comments,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
