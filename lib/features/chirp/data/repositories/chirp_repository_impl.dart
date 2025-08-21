import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;
  final ChirpLocalDataSource localDataSource;

  ChirpRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<Post>>> getFeedPosts() async {
    final cacheResult = await localDataSource.getCachedPosts();

    return await cacheResult.fold(
      (failure) => left(failure),
      (posts) => right(posts),
    );
  }

  @override
  Future<Either<Failure, List<Post>>> addFeedPosts() async {
    final remoteResult = await remoteDataSource.getPosts();
    if (remoteResult.isLeft()) {
      return left((remoteResult as Left).value);
    }

    final result = await localDataSource.cachePosts(
      (remoteResult as Right).value,
    );

    return result.fold(
      (failure) => left(failure),
      (postData) => right(postData),
    );
  }

  @override
  Future<Either<Failure, Unit>> createPost(
    String content,
    List<MultipartFile> attachments,
  ) async {
    final result = await remoteDataSource.createPost(content, attachments);
    return result.fold(
      (failure) => left(failure),
      (created) => right(created),
    );
  }

  @override
  Future<Either<Failure, Unit>> addComment(
    String postId,
    String content,
  ) async {
    final result = await remoteDataSource.addComment(postId, content);
    return result.fold((failure) => left(failure), (created) => right(created));
  }

  @override
  Future<Either<Failure, Unit>> toggleLike(
    String postId,
    bool isLiked,
  ) async {
    final result = await remoteDataSource.likePost(postId, isLiked);
    return result.fold((failure) => left(failure), (created) => right(created));
  }

 
}
