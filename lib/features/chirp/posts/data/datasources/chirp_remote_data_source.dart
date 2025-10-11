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
      final res = await dioClient.dio.get(
        "https://qachirp.opencrafts.io/posts/feed",
      );

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
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while getting posts",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PostData>> getPostDetails({
    required int postId,
  }) async {
    try {
      final res = await dioClient.dio.get(
        '/$servicePrefix/posts/$postId/details/',
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(res.data);
        return right(PostData.fromJson(json));
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while getting post",
          error: e,
        ),
      );
    }
  }

  Future<void> markPostAsViewed({
    required int postId,
    required String viewerId,
  }) async {
    try {
      await dioClient.dio.post(
        '/$servicePrefix/posts/$postId/viewed/',
        data: {'post_id': postId, 'viewer_id': viewerId},
      );
      _logger.i("Successfully marked post $postId as viewed by $viewerId");
    } on DioException catch (e) {
      _logger.e("Failed to mark post as viewed: ${e.message}");
    } catch (e) {
      _logger.e("Unexpected error marking post as viewed: $e");
    }
  }

  Future<Either<Failure, List<CommentData>>> getPostComments({
    required int postId,
  }) async {
    try {
      final res = await dioClient.dio.get(
        '/$servicePrefix/posts/$postId/comments',
      );

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return Left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }

      final List<CommentData> comments = (res.data['results'] as List)
          .map((json) => CommentData.fromJson(json))
          .toList();

      return Right(comments);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      _logger.e("Error fetching comments for post $postId: $e");
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while getting comments",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PostData>> createPost({
    List<MultipartFile>? attachments,
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  }) async {
    try {
      // Build form data dynamically
      final Map<String, dynamic> formMap = {
        'title': title,
        'author_id': authorId,
        'community_id': communityId,
        'content': content,
      };

      if (attachments != null && attachments.isNotEmpty) {
        formMap['attachments'] = attachments;
      }

      final formData = FormData.fromMap(formMap);

      final res = await dioClient.dio.post(
        '/$servicePrefix/posts/create/',
        queryParameters: {'community_id': communityId},
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      if (res.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(res.data);
        return right(PostData.fromJson(json));
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while creating post",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, CommentData>> createComment({
    required int postId,
    required String authorId,
    required String content,
    int? parent,
  }) async {
    try {
      final Map<String, dynamic> formMap = {
        'post': postId,
        'author_id': authorId,
        'content': content,
      };

      // Only include parent if it's not null
      if (parent != null) {
        formMap['parent'] = parent;
      }

      final res = await dioClient.dio.post(
        '/$servicePrefix/posts/$postId/comments/',
        data: formMap,
      );

      if (res.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(res.data);
        return right(CommentData.fromJson(json));
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message: "An unexpected error occurred while creating comment",
          error: e,
        ),
      );
    }
  }

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
