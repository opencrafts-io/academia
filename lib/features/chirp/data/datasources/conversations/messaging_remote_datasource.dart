import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MessagingRemoteDatasource {
  Future<Either<Failure, List<ConversationData>>> getConversations();
  Future<Either<Failure, List<MessageData>>> getMessages(String conversationId);
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content,
  );
}

class MessagingRemoteDatasourceImpl
    with DioErrorHandler
    implements MessagingRemoteDatasource {
  final DioClient dioClient;

  MessagingRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ConversationData>>> getConversations() async {
    try {
      final response = await dioClient.dio.get('/conversations/');

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Server returned error ${response.statusCode}',
            error: 'HTTP ${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }

      final conversations = (response.data as List)
          .map((json) => ConversationData.fromJson(json))
          .toList();

      return Right(conversations);
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

  @override
  Future<Either<Failure, List<MessageData>>> getMessages(
    String conversationId,
  ) async {
    try {
      final response = await dioClient.dio.get(
        '/conversations/$conversationId/messages/',
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Server returned error ${response.statusCode}',
            error: 'HTTP ${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }

      final messages = (response.data as List)
          .map((json) => MessageData.fromJson(json))
          .toList();

      return Right(messages);
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

  @override
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content,
  ) async {
    try {
      final response = await dioClient.dio.post(
        '/messages/',
        data: {'receiver_id': receiverId, 'content': content},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(
          ServerFailure(
            message: 'Server returned error ${response.statusCode}',
            error: 'HTTP ${response.statusCode}: ${response.statusMessage}',
          ),
        );
      }

      if (response.data is! Map<String, dynamic>) {
        return Left(
          ServerFailure(
            message: 'Invalid response format from server',
            error: 'Expected Map but got ${response.data.runtimeType}',
          ),
        );
      }

      final message = MessageData.fromJson(response.data);
      return Right(message);
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
            message: 'You don\'t have permission to perform this action.',
            error: dioError,
          ),
        );
      } else if (statusCode == 404) {
        return Left(
          ServerFailure(
            message: 'Resource not found. The API may be unavailable.',
            error: dioError,
          ),
        );
      } else if (statusCode == 400) {
        return Left(
          ServerFailure(
            message: 'Invalid request. Please check your input and try again.',
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
    return handleDioError<T>(dioError);
  }
}
