// import 'package:academia/database/database.dart';
// import 'package:academia/features/chirp/communities/communities.dart';
// import 'package:academia/features/chirp/posts/posts.dart';

// extension PostEntityHelper on PostData {
//   Post toEntity({
//     List<AttachmentData> attachments = const [],
//     List<PostReplyEntity> replies = const [],
//     required CommunityData community,
//   }) {
//     return Post(
//       id: int.tryParse(id) ?? 0,
//       community: community.toEntity(),
//       authorId: authorId,
//       authorUsername: authorUsername,
//       authorEmail: authorEmail,
//       title: title,
//       content: content,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       upvotes: upvotes,
//       downvotes: downvotes,
//       viewsCount: viewsCount,
//       commentCount: commentCount,
//       attachments: attachments.map((e) => e.toEntity()).toList(),
//     );
//   }
// }

// extension PostHelper on Post {
//   /// Converts domain model → Drift entity
//   PostData toData() {
//     return PostData(
//       id: id.toString(),
//       communityId: community.id,
//       authorId: authorId,
//       authorUsername: authorUsername,
//       authorEmail: authorEmail,
//       title: title,
//       content: content,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       upvotes: upvotes,
//       downvotes: downvotes,
//       viewsCount: viewsCount,
//       commentCount: commentCount,
//     );
//   }

//   /// Converts API JSON (nested structure) → domain entity
//   /// Used this because of the nested json structure from the API
//   static Post fromApiJson(Map<String, dynamic> json) {
//     final author = json['author'] ?? {};
//     final attachmentsJson = json['attachments'] as List? ?? [];

//     return Post(
//       id: json['id'],
//       community: json['community'] ?? {},
//       authorId: author['user_id'],
//       authorUsername: author['name'],
//       authorEmail: author['email'],
//       title: json['title'],
//       content: json['content'] ?? '',
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       upvotes: json['upvotes'] ?? 0,
//       viewsCount: json['views_count'] ?? 0,
//       commentCount: json['comment_count'] ?? 0,
//       downvotes: json['downvotes'] ?? 0,
//       attachments: attachmentsJson
//           .map(
//             (a) => Attachments(
//               id: a['id'],
//               postId: json['post'],
//               attachmentType: a['attachment_type'],
//               file: a['file'],
//               name: a['original_filename'],
//               size: a['file_size_mb'],
//               createdAt: DateTime.now(),
//               updatedAt: DateTime.now(),
//             ),
//           )
//           .toList()
//           .cast<Attachments>(),
//     );
//   }
// }

import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';

extension PostModelHelper on PostData {
  Post toEntity() => Post(
        id: id,
        community: CommunityData.fromJson(community).toEntity(),
        authorId: authorId,       
        title: title,
        content: content,
        upvotes: upvotes,
        downvotes: downvotes,
        attachments: (attachments)
            .map((item) => AttachmentData.fromJson(item).toEntity())
            .toList(),
        viewsCount: viewsCount,
        commentCount: commentCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension PostEntityHelper on Post {
  PostData toData() => PostData(
        id: id,
        community: community.toData().toJson(),
        authorId: authorId,
        title: title,
        content: content,
        upvotes: upvotes,
        downvotes: downvotes,
        attachments: attachments.map((e) => e.toData(postId: id.toString()).toJson()).toList(),
        viewsCount: viewsCount,
        commentCount: commentCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

