import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CreatePostUsecase {
  final ChirpRepository chirpRepository;

  CreatePostUsecase({required this.chirpRepository});

  Future<Either<Failure, Unit>> call({
    required String content,
    required List<MultipartFile> attachments,
  }) async {
    return chirpRepository.createPost(content, attachments);
  }
}

