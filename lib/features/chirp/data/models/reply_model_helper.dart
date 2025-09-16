import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';

extension PostReplyEntityHelper on PostReplyEntity {
  PostReply toEntity({List<PostReplyEntity> nestedReplies = const []}) {
    // return PostReply(
    //   id: id,
    //   postId: postId,
    //   userId: userId,
    //   content: content,
    //   createdAt: createdAt,
    //   updatedAt: updatedAt,
    // );
    return PostReply(
      id: id,
      parentId: parentId,
      postId: postId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      depth: depth,
      replies: nestedReplies.map((e) => e.toEntity()).toList(),
    );
  }
}

extension ReplyHelper on PostReply {
  PostReplyEntity toData({required String parentPostId}) {
    return PostReplyEntity(
      id: id,
      parentId: parentId,
      postId: parentPostId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt!,
      depth: depth,
    );
  }

  static PostReply fromJson(Map<String, dynamic> json) {
    return PostReply(
      id: json["id"].toString(),
      parentId: json["parent_id"].toString(),
      postId: json["post_id"].toString(),
      userId: json["user_id"].toString(),
      userName: json["user_name"],
      userAvatar: json["user_avatar"],
      content: json["content"],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      depth: json["depth"],
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((r) => fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}



