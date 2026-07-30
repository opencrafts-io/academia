import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required Community community,
    required String authorId,
    required String title,
    required String content,
    required int upvotes,
    required int downvotes,
    // 1 = upvoted, -1 = downvoted, 0 = no vote
    @Default(0) int myVote,
    @Default([]) List<Attachments> attachments,
    required int viewsCount,
    required int commentCount,
    @Default([]) List<Comment> comments,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Post;
}
