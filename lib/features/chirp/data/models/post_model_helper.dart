import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/data/models/attachment_model_helper.dart';
import 'package:academia/features/chirp/data/models/reply_model_helper.dart';
import 'package:academia/features/chirp/domain/entities/attachments.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';

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
    );
  }

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"].toString(),
      userId: json["user_id"],
      content: json["content"] ?? 'mama',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likeCount: json['like_count'],
      attachments: (json["attachments"] as List).isNotEmpty
          ? (json["attachments"])
                .map(
                  (a) => Attachments(
                    id: a["id"]?.toString() ?? '',
                    postId: json["id"]?.toString() ?? '',
                    attachmentType: a["attachment_type"] ?? '',
                    file: a["file"] ?? '',
                    createdAt: DateTime.parse(a['created_at']),
                    updatedAt: a['updated_at'] != null
                        ? DateTime.parse(a['updated_at'])
                        : null,
                  ),
                )
                .toList()
                .cast<Attachments>()
          : [],
      replies: (json['replies'] != null && (json["replies"] as List).isNotEmpty)
          ? (json["replies"])
                .map(
                  (r) => PostReply(
                    id: r["id"]?.toString() ?? '',
                    postId: json["id"]?.toString() ?? '',
                    userId: r["user_id"] ?? '',
                    content: r["content"] ?? '',
                    createdAt: DateTime.parse(r['created_at']),
                    updatedAt: r['updated_at'] != null
                        ? DateTime.parse(r['updated_at'])
                        : null,
                  ),
                )
                .toList()
                .cast<PostReply>()
          : [],
    );
  }
}
