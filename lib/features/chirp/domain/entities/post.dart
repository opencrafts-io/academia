class Post {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likeCount;
  final List<Attachment> attachments;
  final List<Reply> replies;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.likeCount,
    required this.attachments,
    required this.replies,
  });
}

class Attachment {
  final String attachmentType;
  final String file;
  final DateTime createdAt;

  Attachment({
    required this.attachmentType,
    required this.file,
    required this.createdAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachmentType: json['attachment_type'],
      file: json['file'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'attachment_type': attachmentType,
    'file': file,
    'created_at': createdAt.toIso8601String(),
  };
}

class Reply {
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reply({
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
