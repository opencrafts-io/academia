import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/data/models/attachment_model_helper.dart';
import 'package:academia/features/chirp/data/models/reply_model_helper.dart';
import 'package:academia/features/chirp/domain/entities/attachments.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';

extension PostEntityHelper on PostEntity {
  Post toEntity({
    List<AttachmentEntity> attachments = const [],
    List<PostReplyEntity> replies = const [],
  }) {
    return Post(
      id: id,
      userId: userId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      likeCount: likeCount,
      isLiked: isLiked,
      attachments: attachments.map((e) => e.toEntity()).toList(),
      replies: replies.map((e) => e.toEntity()).toList(),
    );
  }
}

extension PostHelper on Post {
  PostEntity toData() {
    return PostEntity(
      id: id,
      userId: userId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt!,
      likeCount: likeCount,
      isLiked: isLiked,
    );
  }

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"].toString(),
      userId: json["user_id"],
      content: json["content"],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likeCount: json['like_count'],
      isLiked: json['is_liked'],
      attachments: (json["attachments"] as List).isNotEmpty
          ? (json["attachments"])
                .map(
                  (a) => Attachments(
                    id: a["id"]?.toString() ?? '',
                    postId: json["id"]?.toString() ?? '',
                    attachmentType: a["attachment_type"] ?? '',
                    file: a["file_url"] ?? '',
                    name: a["original_filename"] ?? '',
                    size: a["file_size_mb"] ?? 0,
                    createdAt: DateTime.parse(a['created_at']),
                    updatedAt: a['updated_at'] != null
                        ? DateTime.parse(a['updated_at'])
                        : null,
                  ),
                )
                .toList()
                .cast<Attachments>()
          : [],
      
    );
  }
}
