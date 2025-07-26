import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/domain/repositories/chirp_repository.dart';

class GetFeedPosts {
  final ChirpRepository repository;

  GetFeedPosts(this.repository);

  Future<List<Post>> call() async {
    return await repository.getFeedPosts();
  }
}
