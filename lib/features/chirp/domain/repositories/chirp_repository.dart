import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/domain/entities/post.dart';
import 'package:academia/features/chirp/domain/entities/post_replies.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChirpRepository {
  Future<Either<Failure,List<Post>>> getFeedPosts();
  Future<Either<Failure, List<PostReply>>> getPostReplies(String postId);
  Future<Either<Failure, List<PostReply>>> cachePostReplies(String postId);
  Future<Either<Failure, List<Post>>> addFeedPosts();
  Future<Either<Failure, Post>> createPost(
    String content,
    List<MultipartFile> attachments,
    {required String userName,
    
    required String email,
    required String groupId}
  );
  Future<Either<Failure, PostReply>> addComment({ required String postId, required String content, required String userName, String? parentId, required String userId,
  });
  Future<Either<Failure, Map<String, dynamic>>> toggleLike(String postId, bool isLiked);
  
}

