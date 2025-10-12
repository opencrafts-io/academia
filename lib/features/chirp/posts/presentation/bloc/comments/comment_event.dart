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

  GetPostComments({required this.postId});
}