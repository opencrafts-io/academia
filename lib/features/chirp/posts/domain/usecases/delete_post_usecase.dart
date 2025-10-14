import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final ChirpRepository repository;

  DeletePostUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required int postId}) {
    return repository.deletePost(postId: postId);
  }
}