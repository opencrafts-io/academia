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
    // TODO: Uncomment
    // try {
    //   final response = await dioClient.dio.get('/conversations/');
    //
    //   if (response.statusCode != 200) {
    //     return Left(
    //       ServerFailure(
    //         message: 'Failed to fetch conversations',
    //         error: 'Status code: ${response.statusCode}',
    //       ),
    //     );
    //   }
    //
    //   final conversations = (response.data as List)
    //       .map((json) => ConversationData.fromJson(json))
    //       .toList();
    //
    //   return Right(conversations);
    // } on DioException catch (dioError) {
    //   return Left(handleDioError(dioError));
    // } catch (e) {
    //   return Left(
    //     ServerFailure(
    //       message: 'An unexpected error occurred. Please try again.',
    //       error: e,
    //     ),
    //   );
    // }

    // DUMMY DATA
    return _getDummyConversations();
  }

  // TODO: Remove
  Either<Failure, List<ConversationData>> _getDummyConversations() {
    final dummyConversations = [
      ConversationData(
        id: 'conv_1',
        userId: 'user_1',
        lastMessageId: 'msg_1',
        lastMessageAt: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ConversationData(
        id: 'conv_2',
        userId: 'user_2',
        lastMessageId: null,
        lastMessageAt: null,
        unreadCount: 0,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];

    return Right(dummyConversations);
  }

  @override
  Future<Either<Failure, List<MessageData>>> getMessages(
    String conversationId,
  ) async {
    // TODO: Uncomment
    // try {
    //   final response = await dioClient.dio.get(
    //     '/conversations/$conversationId/messages/',
    //   );
    //
    //   if (response.statusCode != 200) {
    //     return Left(
    //       ServerFailure(
    //         message: 'Failed to fetch messages',
    //         error: 'Status code: ${response.statusCode}',
    //       ),
    //     );
    //   }
    //
    //   final messages = (response.data as List)
    //       .map((json) => MessageData.fromJson(json))
    //       .toList();
    //
    //   return Right(messages);
    // } on DioException catch (dioError) {
    //   return Left(handleDioError(dioError));
    // } catch (e) {
    //   return Left(
    //     ServerFailure(
    //       message: 'An unexpected error occurred. Please try again.',
    //       error: e,
    //     ),
    //   );
    // }

    // DUMMY DATA
    return _getDummyMessages(conversationId);
  }

  // TODO: Remove
  Either<Failure, List<MessageData>> _getDummyMessages(String conversationId) {
    if (conversationId == 'conv_1') {
      final dummyMessages = [
        MessageData(
          id: 'msg_1',
          content: 'Rada rada ni gani',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        MessageData(
          id: 'msg_2',
          content: 'Tuingie ndanee',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(minutes: 10)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        MessageData(
          id: 'msg_3',
          content: 'Juu mi si bane',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 15)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        MessageData(
          id: 'msg_4',
          content: 'Mi najua uko _____',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(minutes: 20)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 20)),
        ),
        MessageData(
          id: 'msg_5',
          content: 'Janta ni janta joh',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 25)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 25)),
        ),
        MessageData(
          id: 'msg_6',
          content: 'Doh ndo ina matter',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        MessageData(
          id: 'msg_7',
          content: 'Ganja farmer ni ya wale wanjanja',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 35)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 35)),
        ),
        MessageData(
          id: 'msg_8',
          content: 'wana? wanachora namba saba',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(minutes: 40)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 40)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 40)),
        ),
        MessageData(
          id: 'msg_9',
          content: 'Shughlibagli shughli body',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 45)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 45)),
        ),
        MessageData(
          id: 'msg_10',
          content: 'nden nden nden nden',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(minutes: 50)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 50)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 50)),
        ),
        MessageData(
          id: 'msg_11',
          content: 'Katika',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(minutes: 55)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(minutes: 55)),
          updatedAt: DateTime.now().subtract(const Duration(minutes: 55)),
        ),
        MessageData(
          id: 'msg_12',
          content: 'Katika',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(const Duration(hours: 1)),
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        MessageData(
          id: 'msg_13',
          content:
              'Should we schedule a team meeting to discuss the next sprint?',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 5)),
          isRead: true,
          createdAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 5),
          ),
          updatedAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 5),
          ),
        ),
        MessageData(
          id: 'msg_14',
          content: 'Good idea! How about tomorrow at 2 PM?',
          senderId: 'current_user',
          recipientId: 'user_1',
          sentAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 10),
          ),
          isRead: true,
          createdAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 10),
          ),
          updatedAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 10),
          ),
        ),
        MessageData(
          id: 'msg_15',
          content: 'Perfect! WANTAM!',
          senderId: 'user_1',
          recipientId: 'current_user',
          sentAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 15),
          ),
          isRead: true,
          createdAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 15),
          ),
          updatedAt: DateTime.now().subtract(
            const Duration(hours: 1, minutes: 15),
          ),
        ),
      ];
      return Right(dummyMessages);
    } else {
      return Right([]); // Empty conversation
    }
  }

  @override
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content,
  ) async {
    // TODO: Uncomment
    // try {
    //   final response = await dioClient.dio.post(
    //     '/messages/',
    //     data: {'receiver_id': receiverId, 'content': content},
    //   );
    //
    //   if (response.statusCode != 200 && response.statusCode != 201) {
    //     return Left(
    //       ServerFailure(
    //         message: 'Failed to send message',
    //         error: 'Status code: ${response.statusCode}',
    //       ),
    //     );
    //   }
    //
    //   if (response.data is! Map<String, dynamic>) {
    //     return Left(
    //       ServerFailure(
    //         message: 'Invalid response format from server',
    //         error: 'Expected Map but got ${response.data.runtimeType}',
    //       ),
    //     );
    //   }
    //
    //   final message = MessageData.fromJson(response.data);
    //   return Right(message);
    // } on DioException catch (dioError) {
    //   return Left(handleDioError(dioError));
    // } catch (e) {
    //   return Left(
    //     ServerFailure(
    //       message: 'An unexpected error occurred. Please try again.',
    //       error: e,
    //     ),
    //   );
    // }

    // DUMMY DATA
    return _getDummySentMessage(receiverId, content);
  }

  // TODO: Remove
  Either<Failure, MessageData> _getDummySentMessage(
    String receiverId,
    String content,
  ) {
    final dummyMessage = MessageData(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: content,
      senderId: 'current_user',
      recipientId: receiverId,
      sentAt: DateTime.now(),
      isRead: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return Right(dummyMessage);
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
