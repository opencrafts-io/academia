part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}

class CacheFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final String title;
  final String authorId;
  final int communityId;
  final String content;

  CreatePostEvent({
    required this.title,
    required this.authorId,
    required this.communityId,
    required this.content,
  });
}

class GetPostDetailEvent extends FeedEvent {
  final int postId;

  GetPostDetailEvent({required this.postId});
}

class MarkPostAsViewed extends FeedEvent {
  final int postId;
  final String viewerId;

  MarkPostAsViewed({required this.postId, required this.viewerId});
}

class AddComment extends FeedEvent {
  final int postId;
  final String authorId;
  final String content;
  final int? parentId;

  AddComment({
    required this.postId,
    required this.authorId,
    required this.content,
    this.parentId,
  });
}

class ToggleLikePost extends FeedEvent {
  final String postId;
  final bool isCurrentlyLiked;
  ToggleLikePost({required this.postId, required this.isCurrentlyLiked});
}

class GetPostCommentsEvent extends FeedEvent {
  final int postId;

  GetPostCommentsEvent({required this.postId});
}
