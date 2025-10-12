import 'package:academia/features/chirp/posts/posts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentUsecase addComment;
  final GetPostCommentsUsecase getPostComments;

  CommentBloc({required this.addComment, required this.getPostComments})
    : super(CommentInitial()) {
    on<AddComment>(_onAddComment);
    on<GetPostComments>(_onGetPostComments);
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
    emit(CommentsLoading());

    final result = await getPostComments(postId: event.postId);

    result.fold(
      (failure) => emit(CommentsError(message: failure.message)),
      (paginatedData) => emit(
        CommentsLoaded(
          comments: paginatedData.results,
          next: paginatedData.next,
          previous: paginatedData.previous,
          count: paginatedData.count,
          hasMore: paginatedData.hasMore,
        ),
      ),
    );
  }
}
