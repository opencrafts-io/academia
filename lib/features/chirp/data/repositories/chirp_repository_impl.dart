import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/data.dart';
import 'package:academia/features/chirp/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;

  ChirpRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> getFeedPosts() async {
    return await remoteDataSource.getFeedPosts();
  }
}

