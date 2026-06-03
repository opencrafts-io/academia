import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TodoListRemoteDatasource with ConnectivityChecker, DioErrorHandler {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  TodoListRemoteDatasource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePath = "keepup";
    } else if (flavor.isStaging) {
      servicePath = 'qa-keepup';
    } else {
      servicePath = "dev-keepup";
    }
  }

  Future<Either<Failure, TodoListDto>> createTodoList(
    TodoListDto todoList,
  ) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final response = await dioClient.dio.post(
        "/$servicePath/todos/tasklist/create/",
        data: todoList.toJson(),
      );

      if (response.statusCode != 201) {
        return Left(
          ServerFailure(
            message:
                "Wrong server code returned while attempting to create todo list",
            error: Exception(
              "Wrong status code expected code 201 instead got ${response.statusCode}",
            ),
          ),
        );
      }

      return Right(TodoListDto.fromJson(response.data));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  Future<Either<Failure, PaginatedTodoListDto>> getTodoLists({
    String? url,
  }) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      // If url is null, use the base endpoint.
      // If url is provided (from 'next'), use it as the full path.
      final response = await dioClient.dio.get(
        url ?? "/$servicePath/todos/tasklist/",
      );

      if (response.statusCode == 200) {
        return Right(PaginatedTodoListDto.fromJson(response.data));
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
          message: "An unexpected error occurred while fetching your lists.",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoListDto>> fetchDefaultTodoList() async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final response = await dioClient.dio.get(
        "/$servicePath/todos/tasklist/default/",
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message:
                "Wrong server code returned while attempting to sync default todo list",
            error: Exception(
              "Wrong status code expected code 200 instead got ${response.statusCode}",
            ),
          ),
        );
      }

      return Right(TodoListDto.fromJson(response.data));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  Future<Either<Failure, Unit>> deleteTodoList(String todoListID) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }
      final response = await dioClient.dio.delete(
        "/$servicePath/todos/tasklist/$todoListID/delete/",
      );

      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        return Left(
          ServerFailure(
            message:
                "Wrong server code returned while attempting to delete todo list",
            error: Exception(
              "Wrong status code expected code 204 instead got ${response.statusCode}",
            ),
          ),
        );
      }

      return Right(unit);
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  Future<Either<Failure, TodoListDto>> updateTodoList(
    TodoListDto todoList,
  ) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.patch(
        "/$servicePath/todos/tasklist/${todoList.id}/update/",
        data: todoList.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoListDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to update the todo list on the server.",
          error: Exception(
            "Expected status code 200, but got ${response.statusCode}",
          ),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(
        ServerFailure(
          message: "An unexpected error occurred during the update.",
          error: e,
        ),
      );
    }
  }

  Future<Either<Failure, TodoListDto>> getTodoListById(String id) async {
    try {
      if (!await isConnectedToInternet()) {
        return handleNoConnection();
      }

      final response = await dioClient.dio.get(
        "/$servicePath/todos/tasklist/$id/",
      );

      if (response.statusCode == 200) {
        return Right(TodoListDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Could not find the requested todo list on the server.",
          error: Exception("Expected 200, got ${response.statusCode}"),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }
}
