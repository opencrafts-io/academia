import 'package:academia/config/config.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:academia/core/network/dio_error_handler.dart';
import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

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
  Future<Either<Failure, ConversationData>> createConversation(
    List<String> participants, {
    String? currentUserId,
  });
}

class MessagingRemoteDatasourceImpl
    with DioErrorHandler
    implements MessagingRemoteDatasource {
  final DioClient dioClient;
  late String servicePath;
  final FlavorConfig flavor;

  MessagingRemoteDatasourceImpl({
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
  Future<Either<Failure, List<ConversationData>>> getConversations() async {
    try {
      final response = await dioClient.dio.get('/$servicePath/conversations/');

      if (response.statusCode == 200) {
        final conversations = (response.data as List)
            .map(
              (json) => _parseConversationFromBackend(json, 'default_user_123'),
            )
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
        // The API returns a paginated response with 'results' array
        final responseData = response.data as Map<String, dynamic>;
        final results = responseData['results'] as List? ?? [];

        final messages = results
            .map((json) => _parseMessageFromBackend(json, 'default_user_123'))
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
      if (file != null) {
        debugPrint('Sending file message: ${file.path}');
        debugPrint('File exists: ${file.existsSync()}');
        debugPrint('File size: ${file.lengthSync()} bytes');
        debugPrint('File name: ${file.path.split('/').last}');
        debugPrint('Content type: ${file.path.split('.').last}');

        // Handle file upload with FormData
        final formData = FormData.fromMap({
          'content': content.isNotEmpty
              ? content
              : ' ', // Send space if empty to avoid backend validation error
          'attachments': await MultipartFile.fromFile(
            // Note: 'attachments' not 'file'
            file.path,
            filename: file.path.split('/').last,
          ),
        });

        final response = await dioClient.dio.post(
          '/$servicePath/conversations/$receiverId/messages/',
          data: formData,
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          final message = _parseSentMessageFromBackend(response.data);
          return Right(message);
        }

        return Left(
          NetworkFailure(
            message: "We couldn't send your image. Please try again.",
            error: "Status code: ${response.statusCode}",
          ),
        );
      } else {
        // Text-only message
        if (content.trim().isEmpty) {
          return Left(
            NetworkFailure(
              message: "Message cannot be empty.",
              error: "Empty content",
            ),
          );
        }

        final Map<String, dynamic> data = {'content': content};

        // Send to /conversations/{conversationId}/messages/ instead of /messages/
        final response = await dioClient.dio.post(
          '/$servicePath/conversations/$receiverId/messages/',
          data: data,
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          final message = _parseSentMessageFromBackend(response.data);
          return Right(message);
        }

        return Left(
          NetworkFailure(
            message: "We couldn't send your message. Please try again.",
            error: "Status code: ${response.statusCode}",
          ),
        );
      }
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

  @override
  Future<Either<Failure, ConversationData>> createConversation(
    List<String> participants, {
    String? currentUserId,
  }) async {
    try {
      // Use the provided currentUserId or fallback to default
      final userId = currentUserId ?? 'default_user_123';

      final response = await dioClient.dio.post(
        '/$servicePath/conversations/create/?user_id=$userId',
        data: {'participants': participants},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final conversation = _parseConversationFromBackend(
          response.data,
          userId,
        );
        return Right(conversation);
      }

      return Left(
        NetworkFailure(
          message: "We couldn't create the conversation. Please try again.",
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
              "Something went wrong while creating the conversation. Please try again.",
        ),
      );
    }
  }

  ConversationData _parseConversationFromBackend(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    final participants = List<String>.from(json['participants'] ?? []);
    final otherParticipant = participants.firstWhere(
      (participant) => participant != currentUserId,
      orElse: () =>
          participants.isNotEmpty ? participants.first : 'unknown_user',
    );

    // Check if this is the API response structure (has 'conversation' wrapper)
    final conversationData = json['conversation'] ?? json;
    final conversationParticipants = List<String>.from(
      conversationData['participants'] ?? json['participants'] ?? [],
    );
    final finalOtherParticipant = conversationParticipants.firstWhere(
      (participant) => participant != currentUserId,
      orElse: () => conversationParticipants.isNotEmpty
          ? conversationParticipants.first
          : 'unknown_user',
    );

    return ConversationData(
      id: conversationData['conversation_id'] ?? json['conversation_id'] ?? '',
      createdAt: DateTime.parse(
        conversationData['created_at'] ??
            json['created_at'] ??
            DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        conversationData['updated_at'] ??
            json['updated_at'] ??
            DateTime.now().toIso8601String(),
      ),
      userId: finalOtherParticipant,
      lastMessageId: null,
      lastMessageAt:
          (conversationData['last_message_at'] ?? json['last_message_at']) !=
              null
          ? DateTime.parse(
              conversationData['last_message_at'] ?? json['last_message_at'],
            )
          : null,
      unreadCount:
          conversationData['unread_count'] ?? json['unread_count'] ?? 0,
    );
  }

  MessageData _parseMessageFromBackend(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
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
      for (final attachment in attachments) {
        if (attachment is Map<String, dynamic>) {
          final attachmentType = attachment['attachment_type']
              ?.toString()
              .toLowerCase();
          final fileUrl = attachment['file_url']?.toString();

          if (attachmentType == 'file' && fileUrl != null) {
            final fileName =
                attachment['original_filename']?.toString().toLowerCase() ?? '';
            if (fileName.contains('.jpg') ||
                fileName.contains('.jpeg') ||
                fileName.contains('.png') ||
                fileName.contains('.gif') ||
                fileName.contains('.webp')) {
              return fileUrl;
            }
          }
        }
      }
    }

    return null;
  }
}
