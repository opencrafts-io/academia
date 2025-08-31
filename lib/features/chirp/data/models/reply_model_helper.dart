import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';
extension PostReplyEntityHelper on PostReplyEntity {
  PostReply toEntity() {
    return PostReply(
      id: id,
      postId: postId,
      userId: userId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}


extension ReplyHelper on PostReply {
  PostReplyEntity toData({required String parentPostId}) {
    return PostReplyEntity(
      id: id,
      postId: parentPostId,
      userId: userId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt!,
    );
  }

  static PostReply fromJson(Map<String, dynamic> json) {
    return PostReply(
      id: json["id"].toString(),
      postId: json["id"]?.toString() ?? '',
      userId: json["user_id"],
      content: json["content"],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      
    );
  }
}




