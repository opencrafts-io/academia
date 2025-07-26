import 'package:academia/features/chirp/domain/entities/post.dart';

abstract class ChirpRepository {
  Future<List<Post>> getFeedPosts();
}
