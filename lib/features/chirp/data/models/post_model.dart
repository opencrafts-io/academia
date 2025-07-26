import 'package:academia/features/chirp/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.communityName,
    required super.upvotes,
    required super.comments,
    super.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      communityName: json['communityName'],
      upvotes: json['upvotes'],
      comments: json['comments'],
      imageUrl: json['imageUrl'],
    );
  }
}
