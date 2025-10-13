import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';

extension PostModelHelper on PostData {
  Post toEntity() => Post(
    id: id,
    community: CommunityData.fromJson(community).toEntity(),
    authorId: authorId,
    title: title,
    content: content,
    upvotes: upvotes,
    downvotes: downvotes,
    attachments: (attachments.isNotEmpty)
        ? attachments
              .map((item) => AttachmentData.fromJson(item).toEntity())
              .toList()
        : const [],
    viewsCount: viewsCount,
    commentCount: commentCount,
    comments: (comments.isNotEmpty)
        ? comments.map((item) => CommentData.fromJson(item).toEntity()).toList()
        : const [],
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension PostEntityHelper on Post {
  PostData toData() => PostData(
    id: id,
    community: community.toData().toJson(),
    authorId: authorId,
    title: title,
    content: content,
    upvotes: upvotes,
    downvotes: downvotes,
    attachments: (attachments.isNotEmpty)
        ? attachments
              .map((e) => e.toData(postId: id.toString()).toJson())
              .toList()
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
