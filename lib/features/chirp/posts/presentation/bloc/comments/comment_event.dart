part of 'comment_bloc.dart';


abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddComment extends CommentEvent {
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

class GetPostComments extends CommentEvent {
  final int postId;
  final int page;
  final int pageSize;

  GetPostComments({required this.postId, this.page = 1, this.pageSize = 20});
}