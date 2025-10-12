
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/domain/entities/attachments.dart';

extension AttachmentEntityHelper on AttachmentEntity {
  Attachments toEntity() {
    return Attachments(
      id: id,
      postId: postId,
      attachmentType: attachmentType,
      file: file,
      name: name,
      size: size,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension AttachmentHelper on Attachments {
  AttachmentEntity toData({required String postId}) {
    return AttachmentEntity(
      id: id,
      postId: postId,
      attachmentType: attachmentType,
      name: name,
      size: size,
      file: file,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}



