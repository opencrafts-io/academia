import 'package:academia/config/config.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/features/todos/data/dtos/paginated_todo_item_dto.dart';
import 'package:academia/features/todos/data/dtos/todo_item_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TodoItemRemoteDatasource with ConnectivityChecker, DioErrorHandler {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  TodoItemRemoteDatasource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePath = "keepup";
    } else if (flavor.isStaging) {
      servicePath = 'qa-keepup';
    } else {
      servicePath = "dev-keepup";
    }
  }

  /// GET /todos/ — List tasks, optionally filtered by task list
  Future<Either<Failure, PaginatedTodoItemDto>> getTodoItems({
    String? url,
    String? taskListId,
  }) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.get(
        url ?? "/$servicePath/todos/",
        queryParameters: {if (taskListId != null) 'task_list_id': taskListId},
      );

      if (response.statusCode == 200) {
        return Right(PaginatedTodoItemDto.fromJson(response.data));
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
          message: "An unexpected error occurred while fetching tasks.",
          error: e,
        ),
      );
    }
  }

  /// GET /todos/{task_id}/ — Retrieve a single task by remote ID
  Future<Either<Failure, TodoItemDto>> getTodoItemById(String taskId) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.get("/$servicePath/todos/$taskId/");

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Could not find the requested task on the server.",
          error: Exception("Expected 200, got ${response.statusCode}"),
        ),
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), error: e));
    }
  }

  /// POST /todos/add — Create a new task
  Future<Either<Failure, TodoItemDto>> createTodoItem(TodoItemDto item) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/add",
        data: item.toJson(),
      );

      // API returns 200 for creation per the schema
      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to create task on the server.",
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

  /// PATCH /todos/{task_id}/update — Partially update a task
  Future<Either<Failure, TodoItemDto>> updateTodoItem(TodoItemDto item) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.patch(
        "/$servicePath/todos/${item.id}/update",
        data: item.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to update task on the server.",
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

  /// DELETE /todos/{task_id}/delete — Soft delete a task
  Future<Either<Failure, Unit>> deleteTodoItem(String taskId) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.delete(
        "/$servicePath/todos/$taskId/delete",
      );

      if (response.statusCode == 204) {
        return const Right(unit);
      }

      return Left(
        ServerFailure(
          message: "Failed to delete task on the server.",
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

  /// POST /todos/{task_id}/complete — Mark a task as completed
  Future<Either<Failure, TodoItemDto>> completeTodoItem(
    String taskId,
    TodoItemDto item,
  ) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/$taskId/complete",
        data: item.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to mark task as completed.",
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

  /// POST /todos/{task_id}/reopen — Reopen a completed task
  Future<Either<Failure, TodoItemDto>> reopenTodoItem(
    String taskId,
    TodoItemDto item,
  ) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/$taskId/reopen",
        data: item.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to reopen task.",
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

  /// POST /todos/{task_id}/move — Move a task to a different list
  Future<Either<Failure, TodoItemDto>> moveTodoItem({
    required String taskId,
    required String taskListId,
  }) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/$taskId/move",
        data: {'task_list_id': taskListId},
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to move task to the specified list.",
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

  /// POST /todos/{task_id}/convert-to-subtask — Convert a task to a subtask
  Future<Either<Failure, TodoItemDto>> convertToSubtask({
    required String taskId,
    required String parentTaskId,
  }) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/$taskId/convert-to-subtask",
        data: {'parent_task_id': parentTaskId},
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to convert task to subtask.",
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

  /// POST /todos/{task_id}/promote — Promote a subtask to a top-level task
  Future<Either<Failure, TodoItemDto>> promoteToTask({
    required String taskId,
    required TodoItemDto item,
  }) async {
    try {
      if (!await isConnectedToInternet()) return handleNoConnection();

      final response = await dioClient.dio.post(
        "/$servicePath/todos/$taskId/promote",
        data: item.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(TodoItemDto.fromJson(response.data));
      }

      return Left(
        ServerFailure(
          message: "Failed to promote subtask.",
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
}
