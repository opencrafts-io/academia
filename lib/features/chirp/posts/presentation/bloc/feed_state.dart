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

class RepliesLoading extends FeedState {
  final Post post;
  RepliesLoading({required this.post});
  @override
  List<Object> get props => [post];
}

class RepliesLoaded extends FeedState {
  final Post post;
  RepliesLoaded({required this.post});
  @override
  List<Object> get props => [post];
}

class RepliesError extends FeedState {
  final String message;
  RepliesError(this.message);

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

class CommentError extends FeedState {
  final String message;
  CommentError(this.message);

  @override
  List<Object?> get props => [message];
}

