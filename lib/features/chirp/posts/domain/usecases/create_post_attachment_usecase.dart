import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CreatePostAttachmentUsecase {
  final ChirpRepository repository;

  CreatePostAttachmentUsecase({required this.repository});

  Future<Either<Failure, Attachments>> call({
    required int postId,
    required MultipartFile file,
  }) {
    return repository.createPostAttachment(postId: postId, file: file);
  }
}
