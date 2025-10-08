import 'package:academia/config/config.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/database/database.dart';
// import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ChirpRemoteDataSource with DioErrorHandler {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePrefix;
  final Logger _logger = Logger();

  ChirpRemoteDataSource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePrefix = "chirp";
    } else if (flavor.isStaging) {
      servicePrefix = 'qa-chirp';
    } else {
      servicePrefix = "dev-chirp";
    }
  }

  Future<Either<Failure, List<PostData>>> getPosts() async {
    try {
      // final res = await dioClient.dio.get("/$servicePrefix/posts/feed"); //TODO: Update API endpoint
      final res = await dioClient.dio.get("https://qachirp.opencrafts.io/posts/feed");

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return Left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }

      final List<PostData> posts = (res.data['results'] as List)
          .map((json) => PostData.fromJson(json))
          .toList();

      // Return the list of posts
      return Right(posts);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error fetching posts: $e");
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  // Future<Either<Failure, List<PostReply>>> getPostReplies(String postId) async {
  //   try {
  //     final res = await dioClient.dio.get(
  //       "/$servicePrefix/statuses/$postId/comments/",
  //     );

  //     if (res.statusCode == 200 && res.data is List) {
  //       final List<PostReply> replies = (res.data as List)
  //           .map((replyJson) => ReplyHelper.fromJson(replyJson))
  //           .toList();

  //       return Right(replies);
  //     }

  //     return Left(
  //       NetworkFailure(message: "Failed to fetch replies", error: res.data),
  //     );
  //   } on DioException catch (e) {
  //     return handleDioError(e);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString(), error: e));
  //   }
  // }

  // Future<Either<Failure, Post>> createPost(
  //   String content,
  //   List<MultipartFile> attachments, {
  //   required String userName,
  //   required String email,
  //   required String groupId,
  // }) async {
  //   try {
  //     final formData = FormData.fromMap({
  //       if (content.isNotEmpty) 'content': content,
  //       if (attachments.isNotEmpty) 'attachments': attachments,
  //       'user_name': userName,
  //       'email': email,
  //     });

  //     final res = await dioClient.dio.post(
  //       '/$servicePrefix/groups/$groupId/posts/create/',
  //       data: formData,
  //       options: Options(contentType: "multipart/form-data"),
  //     );

  //     if (res.statusCode == 201) {
  //       final Post post = PostHelper.fromApiJson(res.data);
  //       return Right(post);
  //     }
  //     return Left(
  //       NetworkFailure(message: "Unexpected response", error: res.data),
  //     );
  //   } on DioException catch (e) {
  //     return handleDioError(e);
  //   }
  // }

  // Future<Either<Failure, PostReply>> addComment({
  //   required String postId,
  //   required String content,
  //   required String userName,
  //   required String userId,
  //   String? parentId,
  // }) async {
  //   try {
  //     final url = parentId != null
  //         ? '/$servicePrefix/statuses/$postId/comments/$parentId/replies/'
  //         : '/$servicePrefix/statuses/$postId/comments/';

  //     final Map<String, dynamic> data = {
  //       'content': content,
  //       'user_name': userName,
  //       'user_id': userId,
  //     };

  //     if (parentId != null) {
  //       data['parent_comment_id'] = parentId;
  //     }

  //     final res = await dioClient.dio.post(url, data: data);

  //     if (res.statusCode == 201) {
  //       final PostReply reply = ReplyHelper.fromJson(res.data);
  //       return Right(reply);
  //     }

  //     return Left(
  //       NetworkFailure(message: "Unexpected response", error: res.data),
  //     );
  //   } on DioException catch (e) {
  //     return handleDioError(e);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString(), error: e));
  //   }
  // }

  // Future<Either<Failure, Map<String, dynamic>>> likePost(
  //   String postId,
  //   bool isLiked,
  // ) async {
  //   try {
  //     final res = await dioClient.dio.post(
  //       '/$servicePrefix/statuses/$postId/like/',
  //     );
  //     if (res.statusCode == 204 || res.statusCode == 201) {
  //       return Right(res.data);
  //     }
  //     return Left(
  //       NetworkFailure(message: "Unexpected response", error: res.data),
  //     );
  //   } on DioException catch (e) {
  //     return handleDioError(e);
  //   } catch (e) {
  //     return Left(CacheFailure(message: e.toString(), error: e));
  //   }
  // }
}
