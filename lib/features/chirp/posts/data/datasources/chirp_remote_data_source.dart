import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ChirpRemoteDataSource with DioErrorHandler, ConnectivityChecker {
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

  Future<Either<Failure, PaginatedData<PostData>>> getPosts({
    required int page,
    required int pageSize,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.get(
        "https://qachirp.opencrafts.io/posts/feed",
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return Left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }

      return Right(
        PaginatedData(
          results: (res.data['results'] as List)
              .map((json) => PostData.fromJson(json))
              .toList(),
          count: res.data['count'],
          next: res.data['next'],
          previous: res.data['previous'],
        ),
      );
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

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
      /// Safely ignore check  whether user is connected to the internet 
      /// since this isnt important much .. used only for stats
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

  Future<Either<Failure, PaginatedData<CommentData>>> getPostComments({
    required int postId,
    required int page,
    required int pageSize,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.get(
        "/$servicePrefix/posts/$postId/comments",
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (res.statusCode != 200 || res.data['results'] is! List) {
        return Left(
          NetworkFailure(message: "Unexpected response", error: res.data),
        );
      }
      return Right(
        PaginatedData(
          results: (res.data['results'] as List)
              .map((json) => CommentData.fromJson(json))
              .toList(),
          count: res.data['count'],
          next: res.data['next'],
          previous: res.data['previous'],
        ),
      );
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
    required String title,
    required String authorId,
    required int communityId,
    required String content,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final Map<String, dynamic> formMap = {
        'title': title,
        'author_id': authorId,
        'community_id': communityId,
        'content': content,
      };

      final res = await dioClient.dio.post(
        '/$servicePrefix/posts/create/',
        queryParameters: {'community_id': communityId},
        data: formMap,
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
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

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

  Future<Either<Failure, AttachmentData>> createPostAttachment({
    required int postId,
    required MultipartFile file,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final formData = FormData.fromMap({'post': postId, 'file': file});

      final res = await dioClient.dio.post(
        '/$servicePrefix/posts/attachment/create/',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (res.statusCode == 201) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(res.data);
        return Right(AttachmentData.fromJson(json));
      }

      return Left(
        NetworkFailure(
          message: "Unexpected response while creating attachment",
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while creating attachment",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> deletePost({required int postId}) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.delete(
        '/$servicePrefix/posts/$postId/delete/',
      );

      if (res.statusCode == 204) {
        return const Right(unit);
      }

      return Left(
        NetworkFailure(
          message: "Unexpected response while deleting post",
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while deleting post",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> deletePostComment({
    required int commentId,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.delete(
        '/$servicePrefix/posts/comments/$commentId/delete/',
      );

      if (res.statusCode == 204) {
        return const Right(unit);
      }

      return Left(
        NetworkFailure(
          message: "Unexpected response while deleting comment",
          error: res.data,
        ),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while deleting comment",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, PaginatedData<PostData>>> getPostsFromCommunity({
    required int communityId,
    required int page,
    required int pageSize,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final res = await dioClient.dio.get(
        '/$servicePrefix/posts/from/$communityId',
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (res.statusCode == 200) {
        return right(
          PaginatedData(
            results: (res.data['results'] as List)
                .map((json) => PostData.fromJson(json))
                .toList(),
            count: res.data['count'],
            next: res.data['next'],
            previous: res.data['previous'],
          ),
        );
      }

      return left(
        NetworkFailure(message: "Unexpected response", error: res.data),
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return left(
        ServerFailure(
          message:
              "An unexpected error occurred while fetching community posts",
          error: e,
        ),
      );
    }
  }
}
