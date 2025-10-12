import 'package:equatable/equatable.dart';

class PostReply extends Equatable {
  final String id;
  final String? parentId; 
  final String userId;
  final String userName;
  final String? userAvatar;
  final String postId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<PostReply> replies;
  final int depth;


  const PostReply({
    required this.id,
    this.parentId,
    required this.postId,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    required this.depth,
    this.replies = const [],
  });

  PostReply copyWith({
    String? id,
    String? parentId,
    String? userName,
    String? userAvatar,
    List<PostReply>? replies,
    int? depth,
    String? postId,
    String? userId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostReply(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      replies: replies ?? this.replies,
      content: content ?? this.content,
      depth: depth ?? this.depth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    parentId,
    postId,
    userId,
    userName,
    userAvatar,
    content,
    createdAt,
    updatedAt,
    depth,
    replies,
  ];
}
