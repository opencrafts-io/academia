import 'package:academia/config/flavor.dart';
import 'package:academia/core/core.dart';
import 'package:academia/core/network/network.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TodoRemoteDatasource with DioErrorHandler {
  final DioClient dioClient;
  final FlavorConfig flavor;
  late String servicePath;

  TodoRemoteDatasource({required this.dioClient, required this.flavor}) {
    if (flavor.isProduction) {
      servicePath = "keepup";
    } else if (flavor.isStaging) {
      servicePath = 'qa-keepup';
    } else {
      servicePath = "dev-keepup";
    }
  }

  Future<Either<Failure, PaginatedResult<TodoData>>> refreshTodos({
    int page = 0,
    int pageSize = 100,
  }) async {
    try {
      final response = await dioClient.dio.get(
        "/$servicePath/todos/",
        queryParameters: {"page": page, "pageSize": pageSize},
      );
      if (response.statusCode == 200) {
        return Right(
          PaginatedResult(
            results: ((response.data["results"] as List)
                .map((e) => TodoData.fromJson(e))
                .toList()),
            currentPage: page,
            next: response.data["next"],
            previous: response.data["previous"],
          ),
        );
      }
      return left(NetworkFailure(error: "", message: ""));
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left(
        CacheFailure(error: e, message: "We couldn't fetch your todos"),
      );
    }
  }

  Future<Either<Failure, TodoData>> createTodo(TodoData todo) async {
    try {
      final response = await dioClient.dio.post(
        "/$servicePath/todos/add",
        data: todo.toJson(),
      );
      if (response.statusCode == 201) {
        return Right(TodoData.fromJson(response.data));
      }
      return Left(
        NetworkFailure(message: "Fatal error while creating todo", error: ""),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't create your todo at the moment",
        ),
      );
    }
  }

  Future<Either<Failure, TodoData>> updateTodo(TodoData todo) async {
    try {
      final response = await dioClient.dio.put(
        "/$servicePath/todos/update/${todo.id}",
        data: todo.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(TodoData.fromJson(response.data));
      }
      return Left(
        NetworkFailure(
          message: "Fatal error while updating todo todo",
          error: "",
        ),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't update your todo at the moment",
        ),
      );
    }
  }

  Future<Either<Failure, TodoData>> completeTodo(TodoData todo) async {
    try {
      final response = await dioClient.dio.put(
        "/$servicePath/todos/complete/${todo.id}",
        data: todo.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(TodoData.fromJson(response.data));
      }
      return Left(
        NetworkFailure(message: "Fatal error while updating todo", error: ""),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't update your todo at the moment",
        ),
      );
    }
  }

  Future<Either<Failure, TodoData>> deleteTodo(TodoData todo) async {
    try {
      final response = await dioClient.dio.delete(
        "/$servicePath/todos/delete/${todo.id}",
        data: todo.toJson(),
      );
      if (response.statusCode == 204) {
        return Right(todo);
      }
      return Left(
        NetworkFailure(message: "Fatal error while deleting todo", error: ""),
      );
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "We couldn't delete your todo at the moment",
        ),
      );
    }
  }
}
