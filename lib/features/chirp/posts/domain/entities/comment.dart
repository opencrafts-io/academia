import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required int id,
    required int post,
    required String authorId,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int upvotes,
    @Default(0) int downvotes,
    // 1 = upvoted, -1 = downvoted, 0 = no vote
    @Default(0) int myVote,
    int? parent,
    @Default([]) List<Comment> replies,
  }) = _Comment;
}
