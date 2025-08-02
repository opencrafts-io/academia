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
