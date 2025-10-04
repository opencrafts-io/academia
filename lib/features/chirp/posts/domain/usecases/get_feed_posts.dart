import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:dartz/dartz.dart';

class GetFeedPosts extends UseCase<List<Post>, NoParams>{
  final ChirpRepository chirpRepository;

  GetFeedPosts(this.chirpRepository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await chirpRepository.getFeedPosts();
  }
}

