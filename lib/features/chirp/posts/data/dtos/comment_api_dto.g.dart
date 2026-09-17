// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentApiDto _$CommentApiDtoFromJson(Map<String, dynamic> json) =>
    _CommentApiDto(
      id: (json['id'] as num).toInt(),
      post: (json['post'] as num).toInt(),
      authorId: json['author_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      upvotes: (json['upvotes'] as num?)?.toInt() ?? 0,
      downvotes: (json['downvotes'] as num?)?.toInt() ?? 0,
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentApiDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      parent: (json['parent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentApiDtoToJson(_CommentApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post': instance.post,
      'author_id': instance.authorId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'replies': instance.replies,
      'parent': instance.parent,
    };
