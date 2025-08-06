import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';

abstract class MessagingRemoteDatasource {
  Future<Either<Failure, List<ConversationData>>> getConversations();
  Future<Either<Failure, List<MessageData>>> getMessages(String conversationId);
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content, {
    File? file,
  });
  Future<Either<Failure, void>> markMessageAsRead(String messageId);
  Future<Either<Failure, void>> deleteMessage(String messageId);
  Future<Either<Failure, void>> markConversationAsRead(String conversationId);
}

class MessagingRemoteDatasourceImpl
    with DioErrorHandler
    implements MessagingRemoteDatasource {
  final DioClient dioClient;
  final String servicePath;

  MessagingRemoteDatasourceImpl({
    required this.dioClient,
    this.servicePath = "qa-chirp",
  });

  @override
  Future<Either<Failure, List<ConversationData>>> getConversations() async {
    try {
      final response = await dioClient.dio.get('/$servicePath/conversations/');

      if (response.statusCode == 200) {
        final conversations = (response.data as List)
            .map((json) => _parseConversationFromBackend(json))
            .toList();

        return Right(conversations);
      }

      return Left(
        NetworkFailure(
          message:
              "We couldn't load your conversations right now. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while loading conversations. Please try again.",
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
        '/$servicePath/conversations/$conversationId/messages/',
      );

      if (response.statusCode == 200) {
        final messages = (response.data as List)
            .map((json) => _parseMessageFromBackend(json))
            .toList();

        return Right(messages);
      }

      return Left(
        NetworkFailure(
          message: "We couldn't load the messages. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while loading messages. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MessageData>> sendMessage(
    String receiverId,
    String content, {
    File? file,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'receiver_id': receiverId,
        'content': content,
      };

      if (file != null) {
        // Handle file upload logic here
        // For now, we'll just send the message without file
      }

      final response = await dioClient.dio.post(
        '/$servicePath/messages/',
        data: data,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final message = _parseMessageFromBackend(response.data);
        return Right(message);
      }

      return Left(
        NetworkFailure(
          message: "We couldn't send your message. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while sending your message. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead(String messageId) async {
    try {
      final response = await dioClient.dio.put(
        '/$servicePath/messages/$messageId/read/',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(null);
      }

      return Left(
        NetworkFailure(
          message: "We couldn't mark the message as read. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while marking message as read. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      final response = await dioClient.dio.delete(
        '/$servicePath/messages/$messageId/',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(null);
      }

      return Left(
        NetworkFailure(
          message: "We couldn't delete the message. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while deleting the message. Please try again.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markConversationAsRead(
    String conversationId,
  ) async {
    try {
      final response = await dioClient.dio.put(
        '/$servicePath/conversations/$conversationId/read/',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(null);
      }

      return Left(
        NetworkFailure(
          message:
              "We couldn't mark the conversation as read. Please try again.",
          error: "Status code: ${response.statusCode}",
        ),
      );
    } on DioException catch (dioError) {
      return handleDioError(dioError);
    } catch (e) {
      return Left(
        CacheFailure(
          error: e,
          message:
              "Something went wrong while marking conversation as read. Please try again.",
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
