import 'package:core/config/flavor.dart';
import 'package:core/core.dart';
import 'package:todos/src/data/dtos/paginated_todo_tag_dto.dart';
import 'package:todos/src/data/dtos/todo_tag_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class TodoTagRemoteDatasource with ConnectivityChecker, DioErrorHandler {
  final Dio dio;
  late String servicePath;
  final FlavorConfig flavor;

  TodoTagRemoteDatasource({required this.dio, required this.flavor}) {
    if (flavor.isProduction) {
      servicePath = "keepup";
    } else if (flavor.isStaging) {
      servicePath = 'qa-keepup';
    } else {
      servicePath = "dev-keepup";
    }
  }

  /// GET /todos/tags/ — List all tags for the authenticated user
  Future<Either<Failure, PaginatedTodoTagDto>> getTags({String? url}) async {
    try {
      if (!await isConnectedToInternet()) return await handleNoConnection();

      final response = await dio.get(url ?? "/$servicePath/todos/tags/");

      if (response.statusCode == 200) {
        return Right(PaginatedTodoTagDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "The server responded with an unexpected error.",
          error: Exception("Expected 200, got ${response.statusCode}"),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(
        ServerFailure(
          message: "An unexpected error occurred while fetching tags.",
          error: e,
        ),
      );
    }
  }

  /// POST /todos/tags/ — Create a new tag
  Future<Either<Failure, TodoTagDto>> createTag(TodoTagDto tag) async {
    try {
      if (!await isConnectedToInternet()) return await handleNoConnection();

      final response = await dio.post(
        "/$servicePath/todos/tags/",
        data: tag.toJson(),
      );

      if (response.statusCode == 201) {
        return Right(TodoTagDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to create tag on the server.",
          error: Exception(
            "Expected status code 201, but got ${response.statusCode}",
          ),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  /// PATCH /todos/tags/{tag_id}/ — Partially update a tag
  Future<Either<Failure, TodoTagDto>> updateTag(TodoTagDto tag) async {
    try {
      if (!await isConnectedToInternet()) return await handleNoConnection();

      final response = await dio.patch(
        "/$servicePath/todos/tags/${tag.id}/",
        data: tag.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoTagDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to update tag on the server.",
          error: Exception(
            "Expected status code 200, but got ${response.statusCode}",
          ),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  /// DELETE /todos/tags/{tag_id}/ — Delete a tag
  Future<Either<Failure, Unit>> deleteTag(String tagId) async {
    try {
      if (!await isConnectedToInternet()) return await handleNoConnection();

      final response = await dio.delete("/$servicePath/todos/tags/$tagId/");

      if (response.statusCode == 204) {
        return const Right(unit);
      }

      return Left(
        ServerFailure(
          message: "Failed to delete tag on the server.",
          error: Exception(
            "Expected status code 204, but got ${response.statusCode}",
          ),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }
}
