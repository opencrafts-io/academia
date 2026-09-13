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
  final PollDraft? poll;

  CreatePostEvent({
    required this.title,
    required this.authorId,
    required this.communityId,
    required this.content,
    this.attachments = const [],
    this.poll,
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
  final bool isCurrentlyLiked;
  final String voterId;

  /// The state before the optimistic update — used to restore on failure.
  final FeedState? previousState;

  ToggleLikePost({
    required this.post,
    required this.isCurrentlyLiked,
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

/// Replace the user's poll selection on [post] with [optionIds].
/// The UI applies the change optimistically via [PostCubit] first; on failure
/// the bloc emits [PollVoteError] so the card can roll back.
class VoteOnPollEvent extends FeedEvent {
  final Post post;
  final List<int> optionIds;
  final String voterId;

  VoteOnPollEvent({
    required this.post,
    required this.optionIds,
    required this.voterId,
  });
}

/// Remove all of the user's poll selections on [post].
class RetractPollVoteEvent extends FeedEvent {
  final Post post;
  final String voterId;

  RetractPollVoteEvent({required this.post, required this.voterId});
}
