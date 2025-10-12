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

class CommentsError extends CommentState {
  final String message;

  CommentsError({required this.message});

  @override
  List<Object?> get props => [message];
}
