import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class PostAttachmentUploader {
  PostAttachmentUploader({
    required this.createPostAttachment,
    required this.deletePost,
    required this.logger,
  });

  final CreatePostAttachmentUsecase createPostAttachment;
  final DeletePostUsecase deletePost;
  final Logger logger;

  /// Returns null when an attachment failed and the post was rolled back.
  Future<List<Attachments>?> upload(int postId, List<XFile> files) async {
    final uploaded = <Attachments>[];
    for (final file in files) {
      final attachment = await _uploadOne(postId, file);
      if (attachment == null) {
        await _rollback(postId);
        return null;
      }
      uploaded.add(attachment);
    }
    return uploaded;
  }

  Future<Attachments?> _uploadOne(int postId, XFile file) async {
    try {
      final multipartFile = MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
      );
      final result = await createPostAttachment(
        postId: postId,
        file: multipartFile,
      );
      final attachment = result.fold<Attachments?>((failure) {
        logger.e('Attachment upload failed: ${failure.message}');
        return null;
      }, (attachment) => attachment);
      return attachment;
    } on Object catch (error) {
      logger.e('Error preparing attachment: $error');
      return null;
    }
  }

  Future<void> _rollback(int postId) async {
    final result = await deletePost(postId: postId);
    result.fold(
      (failure) => logger.e(
        'Failed to delete post after attachment error: ${failure.message}',
      ),
      (_) => logger.i('Post $postId deleted after attachment error'),
    );
  }
}
