import 'package:academia/features/chirp/communities/communities.dart';
import 'package:academia/features/chirp/posts/domain/domain.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final Community community; 
  final String authorId;
  final String title;
  final String content;
  final int upvotes;
  final int downvotes;
  final List<Attachments> attachments;
  final int viewsCount;
  final int commentCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Post({
    required this.id,
    required this.community,
    required this.authorId,
    required this.title,
    required this.content,
    required this.upvotes,
    required this.downvotes,
    this.attachments = const [],
    required this.viewsCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Post copyWith({
    int? id,
    Community? community,
    String? authorId,
    String? title,
    String? content,
    int? upvotes,
    int? downvotes,
    List<Attachments>? attachments,
    int? viewsCount,
    int? commentCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Post(
      id: id ?? this.id,
      community: community ?? this.community,
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      content: content ?? this.content,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      attachments: attachments ?? this.attachments,
      viewsCount: viewsCount ?? this.viewsCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    community,
    authorId,
    title,
    content,
    upvotes,
    downvotes,
    attachments,
    viewsCount,
    commentCount,
    createdAt,
    updatedAt,
  ];
}
