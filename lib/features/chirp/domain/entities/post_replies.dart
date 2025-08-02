import 'package:equatable/equatable.dart';

class PostReply extends Equatable {
  final String id;
  final String userId;
  final String postId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PostReply({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });

  PostReply copyWith({
    String? id,
    String? postId,
    String? userId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PostReply(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, postId, content, createdAt, updatedAt];
}
