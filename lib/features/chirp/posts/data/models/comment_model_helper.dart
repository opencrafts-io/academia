import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/domain/entities/comment.dart';

extension CommentModelHelper on CommentData {
  Comment toEntity() {
    return Comment(
      id: id,
      post: post,
      authorId: authorId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      upvotes: upvotes,
      downvotes: downvotes,
      parent: parent,
      replies: (replies.isNotEmpty)
          ? replies
                .map((reply) => CommentData.fromJson(reply).toEntity())
                .toList()
          : const [],
    );
  }
}

extension CommentEntityHelper on Comment {
  CommentData toData() {
    return CommentData(
      id: id,
      post: post,
      authorId: authorId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      upvotes: upvotes,
      downvotes: downvotes,
      parent: parent,
      replies: replies.isNotEmpty
          ? replies.map((reply) => reply.toData().toJson()).toList()
          : const [],
    );
  }
}
