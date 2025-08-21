import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:dio/dio.dart';

class ChirpRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;

  ChirpRemoteDataSource({required this.dioClient});

  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      // Fetch posts
      final res = await dioClient.dio.get("/qa-chirp/statuses/");

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return Left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }

      // Parse posts
      final List<Post> posts = (res.data['results'] as List)
          .map((json) => PostHelper.fromJson(json))
          .toList();

      // fetch replies for all posts
      final updatedPosts = await Future.wait(
        posts.map((post) async {
          try {
            final repliesRes = await dioClient.dio.get(
              "/qa-chirp/statuses/${post.id}/reply/",
            );

            if (repliesRes.statusCode == 200 && repliesRes.data['results'] is List) {
              final replies = (repliesRes.data['results'] as List)
                  .map((replyJson) => ReplyHelper.fromJson(replyJson))
                  .toList();
              return post.copyWith(replies: replies);
            }
          } catch (_) {
            // If replies fail for one post, skip and keep post as is
          }
          return post;
        }),
      );

      return Right(updatedPosts);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }

  Future<Either<Failure, Unit>> createPost(
    String content,
    List<MultipartFile> attachments,
  ) async {
    try {
      final formData = FormData.fromMap({
        if (content.isNotEmpty) 'content': content,
        if (attachments.isNotEmpty) 'attachments': attachments,
      });

      final res = await dioClient.dio.post(
        '/qa-chirp/statuses/create/',
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      if (res.statusCode == 201) {
        return Right(unit);
      }
      return Left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    }
  }

  Future<Either<Failure, Unit>> addComment(
    String postId,
    String content,
  ) async {
    try {
      final res = await dioClient.dio.post(
        '/qa-chirp/statuses/$postId/reply/',
        data: {'content': content},
      );
      if (res.statusCode == 201) return const Right(unit);
      return Left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }

  Future<Either<Failure, Unit>> likePost(String postId, bool isLiked) async {
    try {
      final res = isLiked
          ? await dioClient.dio.delete('/qa-chirp/statuses/$postId/like/')
          : await dioClient.dio.post('/qa-chirp/statuses/$postId/like/');
      if (res.statusCode == 204 || res.statusCode == 201) {
        return Right(unit);
      }
      return Left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), error: e));
    }
  }
}
