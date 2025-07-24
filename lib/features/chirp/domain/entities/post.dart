class Post {
  final String id;
  final String title;
  final String content;
  final String communityName;
  final int upvotes;
  final int comments;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.communityName,
    required this.upvotes,
    required this.comments,
    this.imageUrl,
  });
}
