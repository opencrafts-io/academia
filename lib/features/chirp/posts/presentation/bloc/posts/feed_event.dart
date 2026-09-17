part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {
  final int page;
  final int pageSize;

  LoadFeedEvent({this.page = 1, this.pageSize = 20});
}

class LoadPostsForCommunityEvent extends FeedEvent {
  final int communityID;
  final int page;
  final int pageSize;

  LoadPostsForCommunityEvent({
    required this.communityID,
    this.page = 1,
    this.pageSize = 20,
  });
}

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
  final Post post;
  final int voteValue;
  final String voterId;
  final FeedState? previousState;

  ToggleLikePost({
    required this.post,
    required this.voteValue,
    required this.voterId,
    this.previousState,
  });
}

class UpdatePostInFeed extends FeedEvent {
  final Post updatedPost;

  UpdatePostInFeed(this.updatedPost);

  @override
  List<Object> get props => [updatedPost];
}

class CheckFeedLikeStatuses extends FeedEvent {}
