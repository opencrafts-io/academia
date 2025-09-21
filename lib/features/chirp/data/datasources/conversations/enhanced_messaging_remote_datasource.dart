import 'dart:io';

import 'package:academia/core/core.dart';
import 'package:academia/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../models/conversations/conversation_api_model.dart';
import '../../models/conversations/message_api_model.dart';

/// Enhanced remote data source for conversation API
abstract class EnhancedMessagingRemoteDataSource {
  // Conversation endpoints
  Future<Either<Failure, List<ConversationApiModel>>> getConversations();
  Future<Either<Failure, ConversationApiModel>> createConversation({
    required String otherUserId,
    required String otherUserName,
  });
  Future<Either<Failure, ConversationApiModel>> getConversationDetails(String conversationId);
  
  // Message endpoints
  Future<Either<Failure, List<MessageApiModel>>> getMessages(
    String conversationId, {
    int page = 1,
    int pageSize = 50,
  });
  
  // Mark messages as read
  Future<Either<Failure, void>> markMessagesAsRead(
    String conversationId,
    List<int> messageIds,
  );
  
  // File upload
  Future<Either<Failure, MessageApiModel>> uploadFile({
    required String conversationId,
    required File file,
    String? content,
  });
  
  // Get conversation info for WebSocket
  Future<Either<Failure, Map<String, dynamic>>> getConversationInfo(String conversationId);
}

class EnhancedMessagingRemoteDataSourceImpl implements EnhancedMessagingRemoteDataSource {
  final DioClient dioClient;
  final Logger _logger = Logger();
  final String servicePath;

  EnhancedMessagingRemoteDataSourceImpl({
    required this.dioClient,
    this.servicePath = "qa-chirp",
  });

  @override
  Future<Either<Failure, List<ConversationApiModel>>> getConversations() async {
    try {
      _logger.d('Fetching conversations from API');
      
      final response = await dioClient.dio.get('/$servicePath/conversations/');
      
      if (response.statusCode == 200) {
        final List<dynamic> conversationsJson = response.data as List<dynamic>;
        
        final conversations = conversationsJson
            .map((json) => ConversationApiModel.fromJson(json as Map<String, dynamic>))
            .toList();
        
        _logger.d('Successfully fetched ${conversations.length} conversations');
        return Right(conversations);
      } else {
        _logger.e('Failed to fetch conversations: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to load conversations. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while fetching conversations: ${e.message}');
      return Left(_handleDioException(e, 'Failed to load conversations'));
    } catch (e) {
      _logger.e('Unexpected error while fetching conversations: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading conversations.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ConversationApiModel>> createConversation({
    required String otherUserId,
    required String otherUserName,
  }) async {
    try {
      _logger.d('Creating conversation with user: $otherUserId');
      
      final requestData = CreateConversationRequest(
        otherUserId: otherUserId,
        otherUserName: otherUserName,
      );
      
      final response = await dioClient.dio.post(
        '/$servicePath/conversations/create/',
        data: requestData.toJson(),
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        final conversation = ConversationApiModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        
        _logger.d('Successfully created conversation: ${conversation.id}');
        return Right(conversation);
      } else {
        _logger.e('Failed to create conversation: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to create conversation. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while creating conversation: ${e.message}');
      
      // Handle specific error cases
      if (e.response?.statusCode == 409) {
        return Left(
          ConflictFailure(
            message: 'Conversation already exists with this user.',
            error: Exception('Conversation conflict'),
          ),
        );
      }
      
      return Left(_handleDioException(e, 'Failed to create conversation'));
    } catch (e) {
      _logger.e('Unexpected error while creating conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while creating conversation.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ConversationApiModel>> getConversationDetails(String conversationId) async {
    try {
      _logger.d('Fetching conversation details: $conversationId');
      
      final response = await dioClient.dio.get('/$servicePath/conversations/$conversationId/');
      
      if (response.statusCode == 200) {
        final conversation = ConversationApiModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        
        _logger.d('Successfully fetched conversation details: $conversationId');
        return Right(conversation);
      } else {
        _logger.e('Failed to fetch conversation details: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to load conversation details.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while fetching conversation details: ${e.message}');
      return Left(_handleDioException(e, 'Failed to load conversation details'));
    } catch (e) {
      _logger.e('Unexpected error while fetching conversation details: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading conversation details.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MessageApiModel>>> getMessages(
    String conversationId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      _logger.d('Fetching messages for conversation: $conversationId (page: $page, size: $pageSize)');
      
      final response = await dioClient.dio.get(
        '/$servicePath/chat/conversations/$conversationId/messages/',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        
        // Handle different response structures
        List<dynamic> messagesJson;
        if (responseData.containsKey('messages')) {
          // New structure with messages and pagination
          messagesJson = responseData['messages'] as List<dynamic>;
        } else if (responseData.containsKey('results')) {
          // Paginated structure with results
          messagesJson = responseData['results'] as List<dynamic>;
        } else if (responseData is List) {
          // Direct list response
          messagesJson = responseData as List<dynamic>;
        } else {
          // Single message fallback
          messagesJson = [responseData];
        }
        
        final messages = messagesJson
            .map((json) {
              // Ensure conversation_id is included if missing
              final messageJson = json as Map<String, dynamic>;
              if (!messageJson.containsKey('conversation_id')) {
                messageJson['conversation_id'] = conversationId;
              }
              // Ensure has_attachment defaults to false if missing
              if (!messageJson.containsKey('has_attachment')) {
                messageJson['has_attachment'] = messageJson.containsKey('attachments') && 
                    (messageJson['attachments'] as List).isNotEmpty;
              }
              return MessageApiModel.fromJson(messageJson);
            })
            .toList();
        
        _logger.d('Successfully fetched ${messages.length} messages for conversation: $conversationId');
        return Right(messages);
      } else {
        _logger.e('Failed to fetch messages: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to load messages. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while fetching messages: ${e.message}');
      return Left(_handleDioException(e, 'Failed to load messages'));
    } catch (e) {
      _logger.e('Unexpected error while fetching messages: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading messages.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(
    String conversationId,
    List<int> messageIds,
  ) async {
    try {
      _logger.d('Marking messages as read for conversation: $conversationId (temporarily disabled)');
      
      // TODO: Re-enable once backend fixes the 'ne' lookup issue
      // The backend returns: "Unsupported lookup 'ne' for CharField or join on the field not permitted."
      // This is a Django ORM query issue that needs to be fixed on the backend
      
      _logger.w('Mark-as-read temporarily disabled due to backend Django ORM query issue');
      return const Right(null); // Return success to avoid breaking the UI
      
      // Commented out until backend is fixed:
      /*
      final requestData = MarkMessagesAsReadRequest(messageIds: messageIds);
      
      final response = await dioClient.dio.post(
        '/$servicePath/chat/conversations/$conversationId/mark-read/',
        data: requestData.toJson(),
      );
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        _logger.d('Successfully marked ${messageIds.length} messages as read');
        return const Right(null);
      } else {
        _logger.e('Failed to mark messages as read: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to mark messages as read.',
          ),
        );
      }
      */
    } on DioException catch (e) {
      _logger.e('DioException while marking messages as read: ${e.message}');
      return Left(_handleDioException(e, 'Failed to mark messages as read'));
    } catch (e) {
      _logger.e('Unexpected error while marking messages as read: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while marking messages as read.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MessageApiModel>> uploadFile({
    required String conversationId,
    required File file,
    String? content,
  }) async {
    try {
      _logger.d('Uploading file for conversation: $conversationId');
      
      // Step 1: Upload the file first
      final uploadResult = await _uploadFileOnly(conversationId, file);
      
      return await uploadResult.fold(
        (failure) async => Left(failure),
        (fileUploadResponse) async {
          // Step 2: Send a message with the uploaded file attachment
          return await _sendMessageWithAttachment(
            conversationId: conversationId,
            content: content ?? '',
            fileUploadResponse: fileUploadResponse,
          );
        },
      );
    } catch (e) {
      _logger.e('Unexpected error while uploading file: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while uploading file.',
        ),
      );
    }
  }
  
  /// Upload file only and return file upload response
  Future<Either<Failure, FileUploadResponse>> _uploadFileOnly(
    String conversationId,
    File file,
  ) async {
    try {
      // Prepare form data
      final formData = FormData();
      
      // Add file
      final fileName = file.path.split('/').last;
      formData.files.add(
        MapEntry(
          'file',
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        ),
      );
      
      final response = await dioClient.dio.post(
        '/$servicePath/chat/conversations/$conversationId/upload/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
        onSendProgress: (sent, total) {
          final progress = (sent / total * 100).toInt();
          _logger.v('Upload progress: $progress%');
        },
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final fileUploadResponse = FileUploadResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        
        _logger.d('Successfully uploaded file: $fileName');
        return Right(fileUploadResponse);
      } else {
        _logger.e('Failed to upload file: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to upload file. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while uploading file: ${e.message}');
      
      // Handle specific error cases
      if (e.response?.statusCode == 413) {
        return Left(
          ValidationFailure(
            message: 'File is too large. Please choose a smaller file.',
            error: Exception('File too large'),
          ),
        );
      } else if (e.response?.statusCode == 415) {
        return Left(
          ValidationFailure(
            message: 'File type is not supported.',
            error: Exception('Unsupported file type'),
          ),
        );
      }
      
      return Left(_handleDioException(e, 'Failed to upload file'));
    }
  }
  
  /// Send message with file attachment
  Future<Either<Failure, MessageApiModel>> _sendMessageWithAttachment({
    required String conversationId,
    required String content,
    required FileUploadResponse fileUploadResponse,
  }) async {
    try {
      _logger.d('Sending message with attachment for conversation: $conversationId');
      
      final requestData = {
        'content': content.isNotEmpty ? content : '📎 ${fileUploadResponse.filename}',
        'file_upload_id': fileUploadResponse.fileUploadId,
      };
      
      final response = await dioClient.dio.post(
        '/$servicePath/chat/conversations/$conversationId/send/',
        data: requestData,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = MessageApiModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        
        _logger.d('Successfully sent message with attachment');
        return Right(message);
      } else {
        _logger.e('Failed to send message with attachment: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'File uploaded but failed to send message. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while sending message with attachment: ${e.message}');
      return Left(_handleDioException(e, 'File uploaded but failed to send message'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getConversationInfo(String conversationId) async {
    try {
      _logger.d('Fetching conversation info: $conversationId');
      
      final response = await dioClient.dio.get(
        '/$servicePath/chat/conversations/$conversationId/info/',
      );
      
      if (response.statusCode == 200) {
        final info = response.data as Map<String, dynamic>;
        
        _logger.d('Successfully fetched conversation info: $conversationId');
        return Right(info);
      } else {
        _logger.e('Failed to fetch conversation info: ${response.statusCode}');
        return Left(
          ServerFailure(
            error: Exception('HTTP ${response.statusCode}'),
            message: 'Failed to load conversation information.',
          ),
        );
      }
    } on DioException catch (e) {
      _logger.e('DioException while fetching conversation info: ${e.message}');
      return Left(_handleDioException(e, 'Failed to load conversation information'));
    } catch (e) {
      _logger.e('Unexpected error while fetching conversation info: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading conversation information.',
        ),
      );
    }
  }

  /// Handle DioException and return appropriate Failure
  Failure _handleDioException(DioException e, String defaultMessage) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          error: e,
          message: 'Connection timeout. Please check your internet connection and try again.',
        );
        
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        
        switch (statusCode) {
          case 400:
            String message = defaultMessage;
            if (responseData is Map<String, dynamic>) {
              final errors = responseData['errors'] ?? responseData['detail'] ?? responseData['message'];
              if (errors is String) {
                message = errors;
              } else if (errors is Map) {
                final firstError = errors.values.first;
                if (firstError is List && firstError.isNotEmpty) {
                  message = firstError.first.toString();
                } else {
                  message = firstError.toString();
                }
              }
            }
            return ValidationFailure(
              message: message,
              error: e,
            );
            
          case 401:
            return AuthenticationFailure(
              message: 'Authentication failed. Please log in again.',
              error: e,
            );
            
          case 403:
            return AuthorizationFailure(
              message: 'You do not have permission to perform this action.',
              error: e,
            );
            
          case 404:
            return NotFoundFailure(
              message: 'The requested resource was not found.',
              error: e,
            );
            
          case 409:
            return ConflictFailure(
              message: 'A conflict occurred. Please try again.',
              error: e,
            );
            
          case 429:
            return RateLimitFailure(
              message: 'Too many requests. Please wait a moment before trying again.',
              error: e,
            );
            
          case 500:
          case 502:
          case 503:
          case 504:
            return ServerFailure(
              error: e,
              message: 'Server error. Please try again later.',
            );
            
          default:
            return ServerFailure(
              error: e,
              message: defaultMessage,
            );
        }
        
      case DioExceptionType.cancel:
        return NetworkFailure(
          error: e,
          message: 'Request was cancelled.',
        );
        
      case DioExceptionType.connectionError:
        return NetworkFailure(
          error: e,
          message: 'No internet connection. Please check your network and try again.',
        );
        
      case DioExceptionType.badCertificate:
        return NetworkFailure(
          error: e,
          message: 'Security certificate error. Please try again.',
        );
        
      case DioExceptionType.unknown:
      default:
        return NetworkFailure(
          error: e,
          message: defaultMessage,
        );
    }
  }
}

