import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class ChirpRepository {
  Future<Either<Failure,List<Post>>> getFeedPosts();
  Future<Either<Failure, List<Post>>> addFeedPosts();
}

