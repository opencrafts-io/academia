import 'package:academia/features/chirp/domain/entities/post.dart';


class PostModel extends Post {

  PostModel({
    required super.id,
    required super.userId,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    required super.likeCount,
    required super.attachments,
    required super.replies,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likeCount: json['like_count'],
      attachments: (json['attachments'] as List<dynamic>)
          .map((a) => Attachment.fromJson(a))
          .toList(),
      replies: (json['replies'] as List<dynamic>)
          .map((r) => Reply.fromJson(r))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'content': content,
    'like_count': likeCount,
    'attachments': attachments.map((a) => a.toJson()).toList(),
    'replies': replies.map((r) => r.toJson()).toList(),
  };
}
