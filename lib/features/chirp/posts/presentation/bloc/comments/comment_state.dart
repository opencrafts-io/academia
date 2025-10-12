part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentAdding extends CommentState {}

class CommentAdded extends CommentState {
  final Comment comment;

  CommentAdded({required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommentAddError extends CommentState {
  final String message;

  CommentAddError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentsLoading extends CommentState {}

class CommentsPaginationLoading extends CommentState {
  final List<Comment> existingComments;
  final bool hasMore;

  CommentsPaginationLoading({
    required this.existingComments,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingComments, hasMore];
}

class CommentsLoaded extends CommentState {
  final List<Comment> comments;
  final String? next;
  final String? previous;
  final int count;
  final bool hasMore;

  CommentsLoaded({
    required this.comments,
    this.next,
    this.previous,
    required this.count,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [comments, next, previous, count, hasMore];
}

class CommentsPaginationError extends CommentState {
  final List<Comment> existingComments;
  final String message;
  final bool hasMore;

  CommentsPaginationError({
    required this.existingComments,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingComments, message, hasMore];
}

class CommentsError extends CommentState {
  final String message;

  CommentsError({required this.message});

  @override
  List<Object?> get props => [message];
}
