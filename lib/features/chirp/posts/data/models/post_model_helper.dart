import 'package:academia/database/database.dart' as db;
import 'package:academia/features/features.dart';

extension PostApiDtoMapper on PostApiDto {
  db.Post toData() => db.Post(
    id: id,
    community: community.toData().toJson(),
    authorId: authorId,
    title: title,
    content: content,
    upvotes: upvotes,
    downvotes: downvotes,
    attachments: attachments.map((a) => a.toData().toJson()).toList(),
    viewsCount: viewsCount,
    commentCount: commentCount,
    comments: comments.map((c) => c.toData().toJson()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Post toEntity() => toData().toEntity();
}

extension PostModelHelper on db.Post {
  Post toEntity() => Post(
    id: id,
    community: db.Community.fromJson(community).toEntity(),
    authorId: authorId,
    title: title,
    content: content,
    upvotes: upvotes,
    downvotes: downvotes,
    attachments: (attachments.isNotEmpty)
        ? attachments
              .map((item) => db.Attachment.fromJson(item).toEntity())
              .toList()
        : const [],
    viewsCount: viewsCount,
    commentCount: commentCount,
    comments: (comments.isNotEmpty)
        ? comments.map((item) => db.Comment.fromJson(item).toEntity()).toList()
        : const [],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension PostEntityHelper on Post {
  db.Post toData() => db.Post(
    id: id,
    community: community.toData().toJson(),
    authorId: authorId,
    title: title,
    content: content,
    upvotes: upvotes,
    downvotes: downvotes,
    attachments: (attachments.isNotEmpty)
        ? attachments.map((e) => e.toData(postId: id).toJson()).toList()
        : const [],
    viewsCount: viewsCount,
    commentCount: commentCount,
    comments: comments.isNotEmpty
        ? comments.map((e) => e.toData().toJson()).toList()
        : const [],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
