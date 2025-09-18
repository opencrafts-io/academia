import 'package:academia/features/chirp/domain/entities/attachments.dart';
import 'package:academia/features/chirp/domain/entities/group.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final Group group;
  final String userId;
  final String userName;
  final String email;
  final String? avatarUrl;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final List<Attachments> attachments;
  final List<PostReply> replies;

  const Post({
    required this.id,
    required this.group,
    required this.userId,
    required this.userName,
    required this.email,
    this.avatarUrl,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    this.attachments = const [],
    this.replies = const [],
  });

  Post copyWith({
  String? id,
  String? userId,
  Group? group,
  String? userName,
  String? email,
  String? avatarUrl,
  String? content,
  DateTime? createdAt,
  DateTime? updatedAt,
  int? likeCount,
  int? commentCount,
  bool? isLiked,
  List<Attachments>? attachments,
  List<PostReply>? replies,
  }) {
    return Post(
      id: id ?? this.id,
      group: group ?? this.group,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
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
