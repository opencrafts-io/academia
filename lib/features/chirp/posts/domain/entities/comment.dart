import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final int post;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int upvotes;
  final int downvotes;
  final int? parent;
  final List<Comment> replies;

  const Comment({
    required this.id,
    required this.post,
    required this.authorId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.upvotes = 0,
    this.downvotes = 0,
    this.parent,
    this.replies = const [],
  });

  Comment copyWith({
    int? id,
    int? post,
    String? authorId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? upvotes,
    int? downvotes,
    int? parent,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      post: post ?? this.post,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      parent: parent ?? this.parent,
      replies: replies ?? this.replies,
    );
  }

  @override
  List<Object?> get props => [
    id,
    post,
    authorId,
    content,
    createdAt,
    updatedAt,
    upvotes,
    downvotes,
    parent,
    replies,
  ];
}
