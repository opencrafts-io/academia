part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedPaginationLoading extends FeedState {
  final List<Post> existingPosts;
  final bool hasMore;

  FeedPaginationLoading({required this.existingPosts, required this.hasMore});

  @override
  List<Object?> get props => [existingPosts, hasMore];
}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  final String? next;
  final String? previous;
  final int count;
  final bool hasMore;

  FeedLoaded({
    required this.posts,
    this.next,
    this.previous,
    required this.count,
    this.hasMore = false,
  });

  FeedLoaded copyWith({
    List<Post>? posts,
    String? next,
    String? previous,
    int? count,
    bool? hasMore,
  }) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [posts, next, previous, count, hasMore];
}

class FeedPaginationError extends FeedState {
  final List<Post> existingPosts;
  final String message;
  final bool hasMore;

  FeedPaginationError({
    required this.existingPosts,
    required this.message,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [existingPosts, message, hasMore];
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
