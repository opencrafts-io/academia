part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final String title;
  final String authorId;
  final int communityId;
  final String content;
  final List<XFile> attachments;

  CreatePostEvent({
    required this.title,
    required this.authorId,
    required this.communityId,
    required this.content,
    this.attachments = const [],
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

class ToggleLikePost extends FeedEvent {
  final String postId;
  final bool isCurrentlyLiked;
  ToggleLikePost({required this.postId, required this.isCurrentlyLiked});
}

class UpdatePostInFeed extends FeedEvent {
  final Post updatedPost;

  UpdatePostInFeed(this.updatedPost);

  @override
  List<Object> get props => [updatedPost];
}
