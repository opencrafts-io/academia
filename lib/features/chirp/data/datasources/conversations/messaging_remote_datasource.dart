import 'package:academia/core/network/dio_client.dart';
import 'package:academia/database/database.dart';
import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

abstract class MessagingRemoteDatasource {
  Future<Either<Failure, List<ConversationData>>> getConversations();
  Future<Either<Failure, List<MessageData>>> getMessages(String conversationId);
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content,
  );
}

class MessagingRemoteDatasourceImpl implements MessagingRemoteDatasource {
  final DioClient dioClient;
  final Logger _logger = Logger();

  MessagingRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ConversationData>>> getConversations() async {
    try {
      _logger.i('Fetching conversations from remote API');
      final response = await dioClient.dio.get('/conversations/');

      final conversations = (response.data as List)
          .map((json) => ConversationData.fromJson(json))
          .toList();

      _logger.i('Successfully fetched ${conversations.length} conversations');
      return Right(conversations);
    } on DioException catch (dioError) {
      _logger.e(
        'DioException occurred while fetching conversations',
        error: dioError,
      );

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(
            ServerFailure(
              message:
                  'Request timed out. Please check your internet connection and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.connectionError:
          return Left(
            ServerFailure(
              message:
                  'No internet connection. Please check your network and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.badResponse:
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
                message: 'You don\'t have permission to access conversations.',
                error: dioError,
              ),
            );
          } else if (statusCode == 404) {
            return Left(
              ServerFailure(
                message: 'Conversations endpoint not found.',
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
          } else {
            return Left(
              ServerFailure(
                message: 'Failed to fetch conversations. Please try again.',
                error: dioError,
              ),
            );
          }
        case DioExceptionType.cancel:
          return Left(
            ServerFailure(message: 'Request was cancelled.', error: dioError),
          );
        default:
          return Left(
            ServerFailure(
              message:
                  'Network error occurred. Please check your connection and try again.',
              error: dioError,
            ),
          );
      }
    } catch (e) {
      _logger.e(
        'Unexpected error occurred while fetching conversations',
        error: e,
      );
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
      _logger.i('Fetching messages for conversation: $conversationId');
      final response = await dioClient.dio.get(
        '/conversations/$conversationId/messages/',
      );

      final messages = (response.data as List)
          .map((json) => MessageData.fromJson(json))
          .toList();

      _logger.i(
        'Successfully fetched ${messages.length} messages for conversation: $conversationId',
      );
      return Right(messages);
    } on DioException catch (dioError) {
      _logger.e(
        'DioException occurred while fetching messages for conversation: $conversationId',
        error: dioError,
      );

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(
            ServerFailure(
              message:
                  'Request timed out. Please check your internet connection and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.connectionError:
          return Left(
            ServerFailure(
              message:
                  'No internet connection. Please check your network and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.badResponse:
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
                message:
                    'You don\'t have permission to access this conversation.',
                error: dioError,
              ),
            );
          } else if (statusCode == 404) {
            return Left(
              ServerFailure(
                message: 'Conversation not found.',
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
          } else {
            return Left(
              ServerFailure(
                message: 'Failed to fetch messages. Please try again.',
                error: dioError,
              ),
            );
          }
        case DioExceptionType.cancel:
          return Left(
            ServerFailure(message: 'Request was cancelled.', error: dioError),
          );
        default:
          return Left(
            ServerFailure(
              message:
                  'Network error occurred. Please check your connection and try again.',
              error: dioError,
            ),
          );
      }
    } catch (e) {
      _logger.e(
        'Unexpected error occurred while fetching messages for conversation: $conversationId',
        error: e,
      );
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
      _logger.i('Sending message to receiver: $receiverId');
      final response = await dioClient.dio.post(
        '/messages/',
        data: {'receiver_id': receiverId, 'content': content},
      );

      final message = MessageData.fromJson(response.data);
      _logger.i('Successfully sent message with ID: ${message.id}');
      return Right(message);
    } on DioException catch (dioError) {
      _logger.e(
        'DioException occurred while sending message to receiver: $receiverId',
        error: dioError,
      );

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Left(
            ServerFailure(
              message:
                  'Request timed out. Please check your internet connection and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.connectionError:
          return Left(
            ServerFailure(
              message:
                  'No internet connection. Please check your network and try again.',
              error: dioError,
            ),
          );
        case DioExceptionType.badResponse:
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
                message: 'You don\'t have permission to send messages.',
                error: dioError,
              ),
            );
          } else if (statusCode == 404) {
            return Left(
              ServerFailure(message: 'Receiver not found.', error: dioError),
            );
          } else if (statusCode == 400) {
            return Left(
              ServerFailure(
                message:
                    'Invalid message content. Please check your message and try again.',
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
          } else {
            return Left(
              ServerFailure(
                message: 'Failed to send message. Please try again.',
                error: dioError,
              ),
            );
          }
        case DioExceptionType.cancel:
          return Left(
            ServerFailure(message: 'Request was cancelled.', error: dioError),
          );
        default:
          return Left(
            ServerFailure(
              message:
                  'Network error occurred. Please check your connection and try again.',
              error: dioError,
            ),
          );
      }
    } catch (e) {
      _logger.e(
        'Unexpected error occurred while sending message to receiver: $receiverId',
        error: e,
      );
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred. Please try again.',
          error: e,
        ),
      );
    }
  }
}
