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
    poll: _parsePoll(poll),
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
    poll: poll?.toData().toJson(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

/// A malformed cached poll blob must not take the whole post down with it —
/// degrade to "no poll" instead.
Poll? _parsePoll(Map<String, dynamic>? json) {
  if (json == null || json.isEmpty) return null;
  try {
    return PollData.fromJson(json).toEntity();
  } catch (_) {
    return null;
  }
}
