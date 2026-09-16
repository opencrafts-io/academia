import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/posts/data/dtos/comment_api_dto.dart';
import 'package:academia/features/chirp/posts/domain/entities/comment.dart';

extension CommentApiDtoMapper on CommentApiDto {
  db.Comment toData() {
    return db.Comment(
      id: id,
      post: post,
      authorId: authorId,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      upvotes: upvotes,
      downvotes: downvotes,
      parent: parent,
      replies: replies.map((reply) => reply.toData().toJson()).toList(),
    );
  }

  Comment toEntity() => toData().toEntity();
}

extension CommentModelHelper on db.Comment {
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
                .map((reply) => db.Comment.fromJson(reply).toEntity())
                .toList()
          : const [],
    );
  }
}

extension CommentEntityHelper on Comment {
  db.Comment toData() {
    return db.Comment(
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
