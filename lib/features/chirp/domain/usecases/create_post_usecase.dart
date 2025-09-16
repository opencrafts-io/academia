import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CreatePostUsecase {
  final ChirpRepository chirpRepository;

  CreatePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Post>> call({
    required String userName,
    required String email,
    required String content,
    required List<MultipartFile> attachments,
    required String groupId,
  }) async {
    return chirpRepository.createPost(content, attachments, userName: userName, email: email, groupId: groupId);
  }
}

