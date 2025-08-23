import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChirpRepository {
  Future<Either<Failure,List<Post>>> getFeedPosts();
  Future<Either<Failure, List<Post>>> addFeedPosts();
  Future<Either<Failure, Unit>> createPost(
    String content,
    List<MultipartFile> attachments,
  );
  Future<Either<Failure, Unit>> addComment(String postId, String content);
  Future<Either<Failure, Unit>> toggleLike(String postId, bool isLiked);
  
}

