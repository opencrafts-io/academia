import 'package:academia/core/network/chirp_dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserSearchRemoteDatasource {
  Future<Either<Failure, List<UserProfile>>> searchUsers(String query);
}

class UserSearchRemoteDatasourceImpl
    with DioErrorHandler
    implements UserSearchRemoteDatasource {
  final ChirpDioClient dioClient;

  UserSearchRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<UserProfile>>> searchUsers(String query) async {
    try {
      final response = await dioClient.dio.get(
        '/users/search/',
        queryParameters: {'q': query},
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Server returned error ${response.statusCode}',
            error: 'HTTP ${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }

      final users = (response.data as List)
          .map((json) => UserProfile.fromJson(json))
          .toList();

      return Right(users);
    } on DioException catch (dioError) {
      return _handleDioErrorWithAuthCheck(dioError);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }

  Either<Failure, T> _handleDioErrorWithAuthCheck<T>(DioException dioError) {
    // authentication and authorization errors
    if (dioError.type == DioExceptionType.badResponse) {
      final statusCode = dioError.response?.statusCode;

      if (statusCode == 401) {
        return Left(
          AuthenticationFailure(
            message: 'Your session has expired. Please log in again.',
            error: dioError,
          ),
        );
      } else if (statusCode == 403) {
        return Left(
          AuthenticationFailure(
            message: 'You don\'t have permission to search users.',
            error: dioError,
          ),
        );
      } else if (statusCode == 404) {
        return Left(
          ServerFailure(
            message: 'Search service not found. The API may be unavailable.',
            error: dioError,
          ),
        );
      } else if (statusCode == 400) {
        return Left(
          ServerFailure(
            message:
                'Invalid search query. Please check your input and try again.',
            error: dioError,
          ),
        );
      } else if (statusCode! >= 500) {
        return Left(
          ServerFailure(
            message: 'Server error occurred. Please try again later.',
            error: dioError,
          ),
        );
      }
    }

    // default error handling
    return handleDioError<T>(dioError);
  }
}
