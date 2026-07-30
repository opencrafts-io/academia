import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/posts/posts.dart';

extension AttachmentApiDtoMapper on AttachmentApiDto {
  db.Attachment toData() {
    return db.Attachment(
      id: id,
      postId: postId,
      attachmentType: attachmentType,
      name: name,
      size: size,
      file: file,
      createdAt: createdAt,
    );
  }

  Attachments toEntity() => toData().toEntity();
}

extension AttachmentEntityHelper on db.Attachment {
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
  db.Attachment toData({required int postId}) {
    return db.Attachment(
      id: id,
      postId: postId,
      attachmentType: attachmentType,
      name: name,
      size: size,
      file: file,
      createdAt: DateTime.now(),
    );
  }
}
