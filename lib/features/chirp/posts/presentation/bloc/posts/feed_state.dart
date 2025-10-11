part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  FeedLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class FeedError extends FeedState {
  final String message;
  FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostDetailLoading extends FeedState {}

class PostDetailLoaded extends FeedState {
  final Post post;

  PostDetailLoaded({required this.post});

  @override
  List<Object?> get props => [post];
}

class PostDetailError extends FeedState {
  final String message;

  PostDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PostCreating extends FeedState {}

class PostCreated extends FeedState {
  final List<Post> posts;
  PostCreated({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class PostCreateError extends FeedState {
  final String message;
  PostCreateError(this.message);

  @override
  List<Object?> get props => [message];
}

// class CommentsLoading extends FeedState {
//   final Post post;

//   CommentsLoading({required this.post});
//   @override
//   List<Object> get props => [post];
// }

class CommentsLoading extends FeedState {}

class CommentsLoaded extends FeedState {
  final Post post;

  CommentsLoaded({required this.post});
  @override
  List<Object> get props => [post];
}

class CommentsError extends FeedState {
  final String message;

  CommentsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CommentAdding extends FeedState {}

class CommentAdded extends FeedState {
  final Comment comment;
  
  CommentAdded({required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommentAddError extends FeedState {
  final String message;

  CommentAddError(this.message);

  @override
  List<Object?> get props => [message];
}
