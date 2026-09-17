import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_state.freezed.dart';

@freezed
sealed class CommentState with _$CommentState {
  const factory CommentState.initial() = CommentInitial;
  const factory CommentState.adding() = CommentAdding;
  const factory CommentState.added({required Comment comment}) =
      CommentAdded;
  const factory CommentState.addError(String message) = CommentAddError;
  const factory CommentState.commentsLoading() = CommentsLoading;
  const factory CommentState.commentsPaginationLoading({
    required List<Comment> existingComments,
    required bool hasMore,
  }) = CommentsPaginationLoading;
  const factory CommentState.commentsLoaded({
    required List<Comment> comments,
    String? next,
    String? previous,
    required int count,
    @Default(false) bool hasMore,
  }) = CommentsLoaded;
  const factory CommentState.commentsPaginationError({
    required List<Comment> existingComments,
    required String message,
    required bool hasMore,
  }) = CommentsPaginationError;
  const factory CommentState.commentsError({required String message}) =
      CommentsError;
}
