import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;
  final ChirpLocalDataSource localDataSource;

  ChirpRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<Post>>> getFeedPosts() async {
    print("Got here: loading");
    final cacheResult = await localDataSource.getCachedPosts();

    return await cacheResult.fold(
      (failure) => left(failure),
      (posts) => right(posts),
    );
  }

  @override
  Future<Either<Failure, List<Post>>> addFeedPosts() async {
    print("Got here: caching posts");
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
}
