import 'package:academia/features/chirp/domain/entities/attachments.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int likeCount;
  final bool isLiked;
  final List<Attachments> attachments;
  final List<PostReply> replies;

  const Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.likeCount = 0,
    this.attachments = const [],
    this.replies = const [],
    this.isLiked = false,
  });

  Post copyWith({
  String? id,
  String? userId,
  String? content,
  DateTime? createdAt,
  DateTime? updatedAt,
  int? likeCount,
  bool? isLiked,
  List<Attachments>? attachments,
  List<PostReply>? replies,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      attachments: attachments ?? this.attachments,
      replies: replies ?? this.replies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    content,
    createdAt,
    updatedAt,
    likeCount,
    isLiked,
    attachments,
    replies,
  ];
}
