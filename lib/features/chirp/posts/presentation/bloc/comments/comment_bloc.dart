import 'package:academia/features/chirp/posts/posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

export 'comment_state.dart';

part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUsecase addComment;
  final GetPostCommentsUsecase getPostComments;
  final LikeCommentUsecase likeComment;
  final CheckCommentLikedUsecase checkCommentLiked;
  final Logger _logger = Logger();

  CommentBloc({
    required this.addComment,
    required this.getPostComments,
    required this.likeComment,
    required this.checkCommentLiked,
  }) : super(CommentInitial()) {
    on<AddComment>(_onAddComment);
    on<GetPostComments>(_onGetPostComments);
    on<ToggleCommentVote>(_onToggleCommentVote);
    on<CheckCommentVoteStatuses>(_onCheckCommentVoteStatuses);
  }

  Future<void> _onAddComment(
    AddComment event,
    Emitter<CommentState> emit,
  ) async {
    final result = await addComment(
      postId: event.postId,
      authorId: event.authorId,
      content: event.content,
      parentId: event.parentId,
    );

    result.fold((failure) => emit(CommentAddError(failure.message)), (
      newComment,
    ) {
      if (state is CommentsLoaded) {
        final currentState = state as CommentsLoaded;

        List<Comment> updatedComments;

        if (newComment.parent != null) {
          // Add as a reply under the correct parent
          updatedComments = _addReplyToParent(
            currentState.comments,
            newComment.parent!,
            newComment,
          );
        } else {
          // Add as top-level comment
          updatedComments = [...currentState.comments, newComment];
        }

        emit(CommentAdded(comment: newComment));

        emit(
          CommentsLoaded(
            comments: updatedComments,
            next: currentState.next,
            previous: currentState.previous,
            count: currentState.count + 1,
            hasMore: currentState.hasMore,
          ),
        );
      } else {
        emit(CommentAddError("Comments not loaded"));
      }
    });
  }

  /// Helper function to recursively find the parent and add the reply
  List<Comment> _addReplyToParent(
    List<Comment> comments,
    int parentId,
    Comment reply,
  ) {
    return comments.map((comment) {
      if (comment.id == parentId) {
        // Found the parent → append the reply
        return comment.copyWith(replies: [...comment.replies, reply]);
      } else if (comment.replies.isNotEmpty) {
        // Search deeper in the tree
        return comment.copyWith(
          replies: _addReplyToParent(comment.replies, parentId, reply),
        );
      } else {
        return comment;
      }
    }).toList();
  }

  Future<void> _onGetPostComments(
    GetPostComments event,
    Emitter<CommentState> emit,
  ) async {
    final currentState = state;

    // Only show loading if it's the first page
    if (event.page == 1) {
      emit(CommentsLoading());
    } // Show pagination loader if fetching next pages
    else if (currentState is CommentsLoaded && event.page > 1) {
      emit(
        CommentsPaginationLoading(
          existingComments: currentState.comments,
          hasMore: currentState.hasMore,
        ),
      );
    } else if (currentState is CommentsPaginationError && event.page > 1) {
      emit(
        CommentsPaginationLoading(
          existingComments: currentState.existingComments,
          hasMore: currentState.hasMore,
        ),
      );
    }

    final result = await getPostComments(
      postId: event.postId,
      page: event.page,
      pageSize: event.pageSize,
    );

    result.fold(
      (failure) {
        // Pagination failed but we already had comments
        if (currentState is CommentsLoaded && event.page > 1) {
          emit(
            CommentsPaginationError(
              existingComments: currentState.comments,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else if (currentState is CommentsPaginationError && event.page > 1) {
          // Retry after pagination error also failed
          emit(
            CommentsPaginationError(
              existingComments: currentState.existingComments,
              message: failure.message,
              hasMore: currentState.hasMore,
            ),
          );
        } else {
          // First load failed
          emit(CommentsError(message: failure.message));
        }
      },
      (paginatedData) {
        // If this is a pagination request and we already have comments
        if (currentState is CommentsLoaded && event.page > 1) {
          emit(
            CommentsLoaded(
              comments: [...currentState.comments, ...paginatedData.results],
              next: paginatedData.next,
              previous: paginatedData.previous,
              count: paginatedData.count,
              hasMore: paginatedData.hasMore,
            ),
          );
        } else {
          // First page or no previous comments loaded
          emit(
            CommentsLoaded(
              comments: paginatedData.results,
              next: paginatedData.next,
              previous: paginatedData.previous,
              count: paginatedData.count,
              hasMore: paginatedData.hasMore,
            ),
          );
        }
        if (!isClosed) add(CheckCommentVoteStatuses());
      },
    );
  }

  Future<void> _onToggleCommentVote(
    ToggleCommentVote event,
    Emitter<CommentState> emit,
  ) async {
    if (state is! CommentsLoaded) return;
    final loadedState = state as CommentsLoaded;

    // Optimistically apply the vote so the UI responds immediately.
    final optimisticComment = event.comment.copyWith(
      myVote: event.voteValue,
      upvotes: event.comment.upvotes + (event.voteValue - event.comment.myVote),
    );
    emit(
      loadedState.copyWith(
        comments: _updateCommentInTree(
          loadedState.comments,
          optimisticComment,
        ),
      ),
    );

    final result = await likeComment(
      comment: event.comment,
      voteValue: event.voteValue,
      voterId: event.voterId,
    );

    result.fold(
      (failure) {
        _logger.e('Failed to cast comment vote: ${failure.message}');
        // Roll back to the pre-toggle comment on failure.
        if (state is CommentsLoaded) {
          final rollbackState = state as CommentsLoaded;
          emit(
            rollbackState.copyWith(
              comments: _updateCommentInTree(
                rollbackState.comments,
                event.comment,
              ),
            ),
          );
        }
      },
      (updatedComment) {
        if (state is CommentsLoaded) {
          final latestState = state as CommentsLoaded;
          emit(
            latestState.copyWith(
              comments: _updateCommentInTree(
                latestState.comments,
                updatedComment,
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _onCheckCommentVoteStatuses(
    CheckCommentVoteStatuses event,
    Emitter<CommentState> emit,
  ) async {
    if (state is! CommentsLoaded) return;
    final flatComments = _flattenComments((state as CommentsLoaded).comments);
    if (flatComments.isEmpty) return;

    final updated = await Future.wait(
      flatComments.map((comment) async {
        final result = await checkCommentLiked(commentId: comment.id);
        return result.fold(
          (failure) => comment,
          (voteValue) => comment.copyWith(myVote: voteValue),
        );
      }),
    );

    if (state is! CommentsLoaded || isClosed) return;
    var comments = (state as CommentsLoaded).comments;
    for (final comment in updated) {
      comments = _updateCommentInTree(comments, comment);
    }
    emit((state as CommentsLoaded).copyWith(comments: comments));
  }

  /// Recursively replaces the comment matching [updated]'s id anywhere in
  /// the tree (top-level or nested reply) with [updated].
  List<Comment> _updateCommentInTree(List<Comment> comments, Comment updated) {
    return comments.map((comment) {
      if (comment.id == updated.id) {
        return updated;
      } else if (comment.replies.isNotEmpty) {
        return comment.copyWith(
          replies: _updateCommentInTree(comment.replies, updated),
        );
      } else {
        return comment;
      }
    }).toList();
  }

  List<Comment> _flattenComments(List<Comment> comments) {
    final flat = <Comment>[];
    for (final comment in comments) {
      flat.add(comment);
      if (comment.replies.isNotEmpty) {
        flat.addAll(_flattenComments(comment.replies));
      }
    }
    return flat;
  }
}
