part of 'feed_bloc.dart';


abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}

class CacheFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final String content;
  final String userName;
  final String email;
  final String groupId;
  final List<PlatformFile> files;
  CreatePostEvent({required this.content, required this.files, required this.userName, required this.email, required this.groupId});
}

class AddComment extends FeedEvent {
  final String postId;
  final String content;
  final String userName;
  final String userId;
  final String? parentId;
  AddComment({required this.postId, required this.content,
    required this.userName, required this.userId, this.parentId});
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
