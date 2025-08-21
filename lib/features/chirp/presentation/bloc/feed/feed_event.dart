part of 'feed_bloc.dart';


abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}

class CacheFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final String content;
  final List<PlatformFile> files;
  CreatePostEvent({required this.content, required this.files});
}

class AddComment extends FeedEvent {
  final String postId;
  final String content;
  AddComment({required this.postId, required this.content});
}

class ToggleLikePost extends FeedEvent {
  final String postId;
  final bool isCurrentlyLiked;
  ToggleLikePost({required this.postId, required this.isCurrentlyLiked});
}
