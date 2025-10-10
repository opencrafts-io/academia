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
  final List<XFile> files;

  CreatePostEvent({
    required this.title,
    required this.authorId,
    required this.communityId,
    required this.content,
    required this.files,
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
  final String postId;
  final String content;
  final String userName;
  final String userId;
  final String? parentId;
  AddComment({
    required this.postId,
    required this.content,
    required this.userName,
    required this.userId,
    this.parentId,
  });
}

class ToggleLikePost extends FeedEvent {
  final String postId;
  final bool isCurrentlyLiked;
  ToggleLikePost({required this.postId, required this.isCurrentlyLiked});
}

class GetPostRepliesEvent extends FeedEvent {
  final String postId;
  GetPostRepliesEvent({required this.postId});
}
