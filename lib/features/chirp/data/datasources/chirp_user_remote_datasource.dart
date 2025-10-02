import 'package:academia/config/config.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/chirp_user_model.dart';

abstract class ChirpUserRemoteDatasource {
  Future<Either<Failure, List<ChirpUserData>>> getChirpUsers();
  Future<Either<Failure, ChirpUserData>> getChirpUserById(String userId);
  Future<Either<Failure, ChirpUserData>> createChirpUser(ChirpUserData user);
  Future<Either<Failure, ChirpUserData>> updateChirpUser(ChirpUserData user);
  Future<Either<Failure, void>> deleteChirpUser(String userId);
  Future<Either<Failure, List<ChirpUserData>>> searchChirpUsers(
    String query, {
    String type = 'combined',
    int limit = 10,
  });
}

class ChirpUserRemoteDatasourceImpl
    with DioErrorHandler
    implements ChirpUserRemoteDatasource {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  ChirpUserRemoteDatasourceImpl({
    required this.dioClient,
    required this.flavor,
  }) {
    if (flavor.isProduction) {
      servicePath = "chirp";
    } else if (flavor.isStaging) {
      servicePath = 'qa-chirp';
    } else {
      servicePath = "dev-chirp";
    }
  }

  @override
  Future<Either<Failure, List<ChirpUserData>>> getChirpUsers() async {
    try {
      final response = await dioClient.dio.get('/$servicePath/users/');

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to fetch chirp users',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final users = (response.data as List)
          .map((json) => ChirpUserData.fromJson(json))
          .toList();

      return Right(users);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUserData>> getChirpUserById(String userId) async {
    try {
      final response = await dioClient.dio.get('/$servicePath/users/$userId');

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to fetch chirp user',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final user = ChirpUserData.fromJson(response.data);
      return Right(user);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUserData>> createChirpUser(
    ChirpUserData user,
  ) async {
    try {
      final response = await dioClient.dio.post(
        '/$servicePath/users/',
        data: user.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(
          ServerFailure(
            message: 'Failed to create chirp user',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final createdUser = ChirpUserData.fromJson(response.data);
      return Right(createdUser);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUserData>> updateChirpUser(
    ChirpUserData user,
  ) async {
    try {
      final response = await dioClient.dio.put(
        '/$servicePath/users/${user.id}',
        data: user.toJson(),
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to update chirp user',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final updatedUser = ChirpUserData.fromJson(response.data);
      return Right(updatedUser);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteChirpUser(String userId) async {
    try {
      final response = await dioClient.dio.delete(
        '/$servicePath/users/$userId',
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        return Left(
          ServerFailure(
            message: 'Failed to delete chirp user',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      return const Right(null);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChirpUserData>>> searchChirpUsers(
    String query, {
    String type = 'combined',
    int limit = 10,
  }) async {
    try {
      final response = await dioClient.dio.get(
        '/$servicePath/users/search/',
        queryParameters: {'q': query, 'type': type, 'limit': limit},
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to search chirp users',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final responseData = response.data;

      final users = (responseData['users'] as List)
          .map((json) => ChirpUserData.fromJson(json))
          .toList();

      return Right(users);
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }
}
