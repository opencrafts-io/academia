
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/posts.dart';
extension AttachmentEntityHelper on AttachmentData {
  Attachments toEntity() {
    return Attachments(
      id: id,
      postId: postId,
      attachmentType: attachmentType,
      file: file,
      name: name,
      size: size,
      createdAt: createdAt,
    );
  }
}

extension AttachmentHelper on Attachments {
  AttachmentData toData({required String postId}) {
    return AttachmentData(
      id: id,
      postId: int.tryParse(postId) ?? 0,
      attachmentType: attachmentType,
      name: name,
      size: size,
      file: file,
      createdAt: DateTime.now(),
    );
  }
}



