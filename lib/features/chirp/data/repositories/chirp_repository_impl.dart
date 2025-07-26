import 'package:academia/features/chirp/data/datasources/chirp_remote_data_source.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_repository.dart';

class ChirpRepositoryImpl implements ChirpRepository {
  final ChirpRemoteDataSource remoteDataSource;

  ChirpRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getFeedPosts() async {
    return await remoteDataSource.getFeedPosts();
  }
}
