part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  FeedLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class FeedErrorState extends FeedState {
  final String message;
  FeedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
