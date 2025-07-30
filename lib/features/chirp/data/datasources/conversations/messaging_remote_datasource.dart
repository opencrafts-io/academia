import 'package:academia/core/network/chirp_dio_client.dart';
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
    String content, {
    String? imagePath,
  });
  Future<Either<Failure, void>> markMessageAsRead(String messageId);
  Future<Either<Failure, void>> deleteMessage(String messageId);
}

class MessagingRemoteDatasourceImpl
    with DioErrorHandler
    implements MessagingRemoteDatasource {
  final ChirpDioClient dioClient;

  MessagingRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ConversationData>>> getConversations() async {
    try {
      final response = await dioClient.dio.get('/conversations/');

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to fetch conversations',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final conversations = (response.data as List)
          .map((json) => _parseConversationFromBackend(json))
          .toList();

      return Right(conversations);
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
            message: 'Failed to fetch messages',
            error: 'Status code: ${response.statusCode}',
          ),
        );
      }

      final messages = (response.data as List)
          .map((json) => _parseMessageFromBackend(json))
          .toList();

      return Right(messages);
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
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content, {
    String? imagePath,
  }) async {
    try {
      // Check if receiverId is a conversation ID (starts with 'conv_')
      final isConversationId = receiverId.startsWith('conv_');

      String endpoint;
      dynamic requestData;

      if (isConversationId) {
        // Send message to conversation
        endpoint = '/conversations/$receiverId/messages/';

        if (imagePath != null) {
          // Upload image with multipart form data
          final formData = FormData.fromMap({
            'content': content,
            'attachments': await MultipartFile.fromFile(imagePath),
          });
          requestData = formData;
        } else {
          // Send text message
          requestData = {'content': content};
        }
      } else {
        // Send message to user
        endpoint = '/messages/';

        if (imagePath != null) {
          // Upload image with multipart form data
          final formData = FormData.fromMap({
            'receiver_id': receiverId,
            'content': content,
            'attachments': await MultipartFile.fromFile(imagePath),
          });
          requestData = formData;
        } else {
          // Send text message
          requestData = {'receiver_id': receiverId, 'content': content};
        }
      }

      final response = await dioClient.dio.post(endpoint, data: requestData);

      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(
          ServerFailure(
            message: 'Failed to send message',
            error: 'Status code: ${response.statusCode}',
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

      final message = _parseSentMessageFromBackend(response.data);
      return Right(message);
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
  Future<Either<Failure, void>> markMessageAsRead(String messageId) async {
    try {
      final response = await dioClient.dio.put('/messages/$messageId/read/');

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            message: 'Failed to mark message as read',
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
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      final response = await dioClient.dio.delete('/messages/$messageId/');

      if (response.statusCode != 200 && response.statusCode != 204) {
        return Left(
          ServerFailure(
            message: 'Failed to delete message',
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

  ConversationData _parseConversationFromBackend(Map<String, dynamic> json) {
    final participants = List<String>.from(json['participants'] ?? []);
    final currentUserId = 'default_user_123'; // This should come from auth
    final otherParticipant = participants.firstWhere(
      (participant) => participant != currentUserId,
      orElse: () =>
          participants.isNotEmpty ? participants.first : 'unknown_user',
    );

    return ConversationData(
      id: json['conversation_id'] ?? '',
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
      userId: otherParticipant,
      lastMessageId: null, // Backend doesn't provide this
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'])
          : null,
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  MessageData _parseMessageFromBackend(Map<String, dynamic> json) {
    // For messages in conversation context, we need to derive recipient_id
    // Since the backend doesn't provide it, we'll use a placeholder
    final currentUserId = 'default_user_123'; // This should come from auth
    final senderId = json['sender_id'] ?? '';
    final recipientId = senderId == currentUserId
        ? 'other_user'
        : currentUserId;

    return MessageData(
      id: json['id']?.toString() ?? '',
      senderId: senderId,
      recipientId: recipientId,
      content: json['content'] ?? '',
      sentAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      isRead: json['is_read'] ?? false,
      imageUrl: _extractImageUrlFromAttachments(json['attachments']),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  MessageData _parseSentMessageFromBackend(Map<String, dynamic> json) {
    // Backend response for sent message has different structure:
    // id, sender_id, recipient_id, content, created_at, updated_at, is_read, is_deleted, attachments, conversation

    return MessageData(
      id: json['id']?.toString() ?? '',
      senderId: json['sender_id'] ?? '',
      recipientId: json['recipient_id'] ?? '',
      content: json['content'] ?? '',
      sentAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      isRead: json['is_read'] ?? false,
      imageUrl: _extractImageUrlFromAttachments(json['attachments']),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  String? _extractImageUrlFromAttachments(dynamic attachments) {
    if (attachments == null) return null;

    if (attachments is List) {
      // Look for the first image attachment
      for (final attachment in attachments) {
        if (attachment is Map<String, dynamic>) {
          final fileType = attachment['file_type']?.toString().toLowerCase();
          final fileUrl = attachment['file_url']?.toString();

          if (fileType != null &&
              (fileType.contains('image') ||
                  fileType.contains('jpg') ||
                  fileType.contains('jpeg') ||
                  fileType.contains('png') ||
                  fileType.contains('gif'))) {
            return fileUrl;
          }
        }
      }
    }

    return null;
  }
}
