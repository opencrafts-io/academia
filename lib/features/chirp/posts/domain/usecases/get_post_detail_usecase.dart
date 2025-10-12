import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class GetPostDetailUseCase {
  final ChirpRepository repository;

  GetPostDetailUseCase({required this.repository});

  Future<Either<Failure, Post>> call({required int postId}) async {
    return await repository.getPostDetails(postId: postId);
  }
}