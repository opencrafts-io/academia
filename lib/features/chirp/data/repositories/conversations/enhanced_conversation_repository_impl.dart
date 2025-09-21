import 'dart:io';

import 'package:academia/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/repositories/conversations/enhanced_conversation_repository.dart';
import '../../../domain/repositories/chirp_user_repository.dart';
import '../../datasources/conversations/enhanced_messaging_local_datasource.dart';
import '../../datasources/conversations/enhanced_messaging_remote_datasource.dart';
import '../../models/conversations/enhanced_conversation_model.dart';
import '../../models/conversations/message_api_model.dart';
import '../../models/conversations/conversation_api_model.dart';
import '../../models/chirp_user_model.dart';
import '../../services/websocket_service.dart';
import '../../services/messaging_notification_service.dart';

/// Enhanced conversation repository implementation
class EnhancedConversationRepositoryImpl implements EnhancedConversationRepository {
  final EnhancedMessagingRemoteDataSource remoteDataSource;
  final EnhancedMessagingLocalDataSource localDataSource;
  final WebSocketService webSocketService;
  final ChirpUserRepository chirpUserRepository;
  final MessagingNotificationService notificationService;
  final Logger _logger = Logger();

  EnhancedConversationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.webSocketService,
    required this.chirpUserRepository,
    required this.notificationService,
  });

  @override
  Future<Either<Failure, List<Conversation>>> getConversations({
    String? currentUserId,
    bool forceRefresh = false,
  }) async {
    try {
      // Get current user ID (you'd get this from auth service)
      final userId = currentUserId ?? await _getCurrentUserId();
      
      if (!forceRefresh) {
        // Try to get from cache first
        final cachedResult = await localDataSource.getCachedConversations();
        if (cachedResult.isRight()) {
          final cachedConversations = cachedResult.getOrElse(() => []);
          if (cachedConversations.isNotEmpty) {
            final conversations = cachedConversations
                .map((data) => data.toEntity())
                .toList();
            
            _logger.d('Returning ${conversations.length} cached conversations');
            
            // Start background refresh
            _refreshConversationsInBackground(userId);
            
            return Right(conversations);
          }
        }
      }
      
      // Fetch from remote
      final remoteResult = await remoteDataSource.getConversations();
      
      return await remoteResult.fold(
        (failure) async {
          // Remote failed, try cache again
          final cachedResult = await localDataSource.getCachedConversations();
          return cachedResult.fold(
            (cacheFailure) => Left(failure), // Return original failure
            (cachedConversations) {
              final conversations = cachedConversations
                  .map((data) => data.toEntity())
                  .toList();
              return Right(conversations);
            },
          );
        },
        (apiConversations) async {
          // Cache the conversations
          await localDataSource.cacheConversations(apiConversations, userId);
          
          // Convert to entities
          final conversations = apiConversations
              .map((apiModel) => apiModel.toEntity(userId))
              .toList();
          
          _logger.d('Successfully fetched ${conversations.length} conversations from API');
          return Right(conversations);
        },
      );
    } catch (e) {
      _logger.e('Unexpected error getting conversations: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading conversations.',
        ),
      );
    }
  }

  @override
  Stream<List<Conversation>> getConversationsStream({String? currentUserId}) {
    return localDataSource.getConversationsStream()
        .map((conversationDataList) => conversationDataList
            .map((data) => data.toEntity())
            .toList());
  }

  @override
  Future<Either<Failure, Conversation>> createConversation({
    required String otherUserId,
    required String otherUserName,
    String? currentUserId,
  }) async {
    try {
      _logger.d('Creating conversation with user: $otherUserId');
      
      final userId = currentUserId ?? await _getCurrentUserId();
      
      // Try to create conversation on remote
      final result = await remoteDataSource.createConversation(
        otherUserId: otherUserId,
        otherUserName: otherUserName,
      );
      
      return await result.fold(
        (failure) async {
          // Check if it's a conflict (conversation already exists)
          if (failure is ConflictFailure) {
            // Try to find existing conversation in cache
            final cachedResult = await localDataSource.getCachedConversations();
            final cachedConversations = cachedResult.getOrElse(() => []);
            
            final existingConversation = cachedConversations
                .where((data) => data.otherUserId == otherUserId)
                .firstOrNull;
            
            if (existingConversation != null) {
              return Right(existingConversation.toEntity());
            }
          }
          
          return Left(failure);
        },
        (apiConversation) async {
          // Cache the new conversation
          await localDataSource.cacheConversations([apiConversation], userId);
          
          final conversation = apiConversation.toEntity(userId);
          _logger.d('Successfully created conversation: ${conversation.id}');
          
          return Right(conversation);
        },
      );
    } catch (e) {
      _logger.e('Unexpected error creating conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while creating conversation.',
        ),
      );
    }
  }

  /// Enriches messages with cached user information to avoid showing "Unknown User"
  /// Includes fallback API call when cached user data is not available
  Future<List<Message>> _enrichMessagesWithUserInfo(List<Message> messages) async {
    if (messages.isEmpty) {
      return messages;
    }
    
    _logger.d('Enriching ${messages.length} messages with cached user info');
    final enrichedMessages = <Message>[];
    final missingUserIds = <String>{};
    
    for (final message in messages) {
      // Try to get cached user info for the sender
      final cachedUserResult = await localDataSource.getCachedUser(message.sender.userId);
      
      if (cachedUserResult.isRight()) {
        final cachedUser = cachedUserResult.getOrElse(() => throw Exception('Should not happen'));
        
        if (cachedUser != null) {
          _logger.d('Found cached user for ${message.sender.userId}: ${cachedUser.name}');
          
          // Create updated sender participant with cached user info
          final updatedSender = message.sender.copyWith(
            name: cachedUser.name.isNotEmpty ? cachedUser.name : message.sender.name,
            avatar: cachedUser.avatarUrl ?? message.sender.avatar,
          );
          
          // Create enriched message with updated sender
          final enrichedMessage = message.copyWith(
            sender: updatedSender,
          );
          
          enrichedMessages.add(enrichedMessage);
        } else {
          _logger.w('Cached user data is null for ${message.sender.userId}');
          // Mark this user ID for API fallback
          missingUserIds.add(message.sender.userId);
          enrichedMessages.add(message);
        }
      } else {
        _logger.w('No cached user found for ${message.sender.userId}');
        // Mark this user ID for API fallback
        missingUserIds.add(message.sender.userId);
        enrichedMessages.add(message);
      }
    }
    
    // Fetch missing users from API and update messages
    if (missingUserIds.isNotEmpty) {
      _logger.d('Fetching ${missingUserIds.length} missing users from API');
      await _fetchAndCacheMissingUsers(missingUserIds);
      
      // Re-enrich messages that had missing user data
      final finalEnrichedMessages = <Message>[];
      for (final message in enrichedMessages) {
        if (missingUserIds.contains(message.sender.userId)) {
          // Try to get user info again after API fetch
          final userResult = await localDataSource.getCachedUser(message.sender.userId);
          if (userResult.isRight()) {
            final userData = userResult.getOrElse(() => null);
            if (userData != null) {
              _logger.d('Successfully enriched message with API-fetched user: ${userData.name}');
              final updatedSender = message.sender.copyWith(
                name: userData.name.isNotEmpty ? userData.name : message.sender.name,
                avatar: userData.avatarUrl ?? message.sender.avatar,
              );
              final enrichedMessage = message.copyWith(sender: updatedSender);
              finalEnrichedMessages.add(enrichedMessage);
              continue;
            }
          }
        }
        finalEnrichedMessages.add(message);
      }
      
      _logger.d('Message enrichment complete: ${finalEnrichedMessages.length} messages processed');
      return finalEnrichedMessages;
    }
    
    _logger.d('Message enrichment complete: ${enrichedMessages.length} messages processed');
    return enrichedMessages;
  }
  
  /// Fetches missing users from API and caches them
  Future<void> _fetchAndCacheMissingUsers(Set<String> userIds) async {
    for (final userId in userIds) {
      try {
        _logger.d('Fetching user $userId from API');
        final userResult = await chirpUserRepository.getChirpUserById(userId);
        
        userResult.fold(
          (failure) => _logger.w('Failed to fetch user $userId: ${failure.message}'),
          (user) async {
            _logger.d('Successfully fetched user: ${user.name}');
            // The user repository should handle caching, but let's ensure it's cached
            // by converting to data format and caching locally if needed
            try {
              final userData = user.toData();
              await localDataSource.cacheUser(ConversationParticipantApiModel(
                userId: userData.id,
                userName: userData.name,
                email: userData.email,
                avatarUrl: userData.avatarUrl,
              ));
            } catch (e) {
              _logger.w('Error caching user data for $userId: $e');
            }
          },
        );
      } catch (e) {
        _logger.e('Unexpected error fetching user $userId: $e');
      }
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 1,
    int pageSize = 50,
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh && page == 1) {
        // Try to get from cache first for the first page
        final cachedResult = await localDataSource.getCachedMessages(
          conversationId,
          page: page,
          pageSize: pageSize,
        );
        
        if (cachedResult.isRight()) {
          final cachedMessages = cachedResult.getOrElse(() => []);
          if (cachedMessages.isNotEmpty) {
            final messages = cachedMessages
                .map((data) => data.toEntity())
                .toList();
            
            // Enrich messages with cached user info
            final enrichedMessages = await _enrichMessagesWithUserInfo(messages);
            
            _logger.d('Returning ${enrichedMessages.length} cached messages for conversation: $conversationId');
            
            // Start background refresh
            _refreshMessagesInBackground(conversationId, page, pageSize);
            
            return Right(enrichedMessages);
          }
        }
      }
      
      // Fetch from remote
      final remoteResult = await remoteDataSource.getMessages(
        conversationId,
        page: page,
        pageSize: pageSize,
      );
      
      return await remoteResult.fold(
        (failure) async {
          // Remote failed, try cache
          final cachedResult = await localDataSource.getCachedMessages(
            conversationId,
            page: page,
            pageSize: pageSize,
          );
          
          return cachedResult.fold(
            (cacheFailure) => Left(failure), // Return original failure
            (cachedMessages) async {
              final messages = cachedMessages
                  .map((data) => data.toEntity())
                  .toList();
              // Enrich messages with cached user info
              final enrichedMessages = await _enrichMessagesWithUserInfo(messages);
              return Right(enrichedMessages);
            },
          );
        },
        (apiMessages) async {
          // Cache the messages (only for first page to avoid conflicts)
          if (page == 1) {
            await localDataSource.cacheMessages(conversationId, apiMessages);
          }
          
          // Convert to entities
          final messages = apiMessages
              .map((apiModel) => apiModel.toEntity())
              .toList();
          
          // Enrich messages with cached user info
          final enrichedMessages = await _enrichMessagesWithUserInfo(messages);
          
          _logger.d('Successfully fetched ${enrichedMessages.length} messages from API');
          return Right(enrichedMessages);
        },
      );
    } catch (e) {
      _logger.e('Unexpected error getting messages: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'An unexpected error occurred while loading messages.',
        ),
      );
    }
  }

  @override
  Stream<List<Message>> getMessagesStream(String conversationId) {
    // Create a stream that combines local messages with real-time WebSocket messages
    final localStream = localDataSource.getMessagesStream(conversationId)
        .asyncMap((messageDataList) async {
          final messages = messageDataList
              .map((data) => data.toEntity())
              .toList();
          
          // Enrich messages with cached user info
          return await _enrichMessagesWithUserInfo(messages);
        });
    
    // Listen to WebSocket messages and add them to local database when received
    webSocketService.messages
        .where((message) => message.conversationId == conversationId)
        .listen((message) async {
      try {
        // Convert message to API model and add to local cache
        final messageApiModel = MessageApiModel(
          id: message.id,
          conversationId: message.conversationId,
          senderId: message.sender.userId,
          senderName: message.sender.name,
          senderEmail: message.sender.email,
          senderAvatar: message.sender.avatar,
          content: message.content,
          createdAt: message.sentAt.toIso8601String(),
          attachments: const [],
        );
        
        // Add to local database - this will trigger the local stream
        await localDataSource.addMessage(messageApiModel);
        _logger.d('Added real-time message to local cache: ${message.id}');
      } catch (e) {
        _logger.e('Error adding real-time message to cache: $e');
      }
    });
    
    return localStream;
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String conversationId,
    required String content,
    File? file,
  }) async {
    try {
      // If file is provided, upload it first
      if (file != null) {
        return await _uploadFile(
          conversationId: conversationId,
          file: file,
          content: content,
        );
      }
      
      // Send via WebSocket if connected
      if (webSocketService.currentConnectionState == WebSocketConnectionState.connected) {
        final result = await webSocketService.sendMessage(
          conversationId: conversationId,
          content: content,
        );
        
        if (result.isRight()) {
          _logger.d('Message sent via WebSocket');
          return const Right(null);
        } else {
          _logger.w('WebSocket send failed, falling back to offline queue');
        }
      }
      
      // Queue for offline sending
      await localDataSource.queueOfflineMessage(conversationId, content);
      _logger.d('Message queued for offline sending');
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Unexpected error sending message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to send message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead({
    required String conversationId,
    required List<int> messageIds,
  }) async {
    try {
      // Update local cache first for immediate UI feedback
      await localDataSource.markMessagesAsRead(conversationId, messageIds);
      
      // Update remote
      final result = await remoteDataSource.markMessagesAsRead(
        conversationId,
        messageIds,
      );
      
      return result.fold(
        (failure) {
          _logger.w('Failed to mark messages as read on server: ${failure.message}');
          // Don't return failure since local update succeeded
          return const Right(null);
        },
        (_) {
          _logger.d('Successfully marked ${messageIds.length} messages as read');
          return const Right(null);
        },
      );
    } catch (e) {
      _logger.e('Unexpected error marking messages as read: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to mark messages as read.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> editMessage({
    required int messageId,
    required String content,
  }) async {
    try {
      // Send edit via WebSocket if connected
      if (webSocketService.currentConnectionState == WebSocketConnectionState.connected) {
        return await webSocketService.editMessage(
          messageId: messageId,
          content: content,
        );
      } else {
        return Left(
          NetworkFailure(
            message: 'Cannot edit message while offline.',
            error: 'No internet connection',
          ),
        );
      }
    } catch (e) {
      _logger.e('Unexpected error editing message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to edit message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(int messageId) async {
    try {
      // Send delete via WebSocket if connected
      if (webSocketService.currentConnectionState == WebSocketConnectionState.connected) {
        return await webSocketService.deleteMessage(messageId);
      } else {
        return Left(
          NetworkFailure(
            message: 'Cannot delete message while offline.',
            error: 'No internet connection',
          ),
        );
      }
    } catch (e) {
      _logger.e('Unexpected error deleting message: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to delete message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> startTyping(String conversationId) async {
    try {
      return await webSocketService.startTyping();
    } catch (e) {
      _logger.w('Failed to send typing indicator: $e');
      return const Right(null); // Non-critical failure
    }
  }

  @override
  Future<Either<Failure, void>> stopTyping(String conversationId) async {
    try {
      return await webSocketService.stopTyping();
    } catch (e) {
      _logger.w('Failed to send typing stop indicator: $e');
      return const Right(null); // Non-critical failure
    }
  }

  @override
  Future<Either<Failure, void>> joinConversation(String conversationId) async {
    try {
      return await webSocketService.joinConversation(conversationId);
    } catch (e) {
      _logger.e('Failed to join conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to join conversation.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> leaveConversation() async {
    try {
      return await webSocketService.leaveConversation();
    } catch (e) {
      _logger.e('Failed to leave conversation: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to leave conversation.',
        ),
      );
    }
  }

  @override
  Stream<Message> get newMessages => webSocketService.messages;

  @override
  Stream<String> get typingIndicators => webSocketService.typingIndicators;

  @override
  Stream<WebSocketConnectionState> get connectionState => webSocketService.connectionState;

  @override
  Future<Either<Failure, void>> connectToRealTime() async {
    return await webSocketService.connect();
  }

  @override
  Future<void> disconnectFromRealTime() async {
    return await webSocketService.disconnect();
  }

  @override
  Future<Either<Failure, void>> syncOfflineMessages() async {
    try {
      final offlineQueueResult = await localDataSource.getOfflineQueue();
      
      return await offlineQueueResult.fold(
        (failure) async => Left(failure),
        (draftMessages) async {
          if (draftMessages.isEmpty) {
            return const Right(null);
          }
          
          _logger.d('Syncing ${draftMessages.length} offline messages');
          
          // Try to send each offline message
          for (final draft in draftMessages) {
            final sendResult = await sendMessage(
              conversationId: draft.conversationId,
              content: draft.content,
            );
            
            if (sendResult.isRight()) {
              // Successfully sent, remove from queue
              await localDataSource.deleteDraft(draft.conversationId);
            }
          }
          
          return const Right(null);
        },
      );
    } catch (e) {
      _logger.e('Error syncing offline messages: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to sync offline messages.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> getDraft(String conversationId) async {
    final result = await localDataSource.getDraft(conversationId);
    return result.fold(
      (failure) => Left(failure),
      (draft) => Right(draft?.content),
    );
  }

  @override
  Future<Either<Failure, void>> saveDraft(String conversationId, String content) async {
    return await localDataSource.saveDraft(conversationId, content);
  }

  @override
  Future<Either<Failure, void>> deleteDraft(String conversationId) async {
    return await localDataSource.deleteDraft(conversationId);
  }

  /// Upload file with optional text content
  Future<Either<Failure, void>> _uploadFile({
    required String conversationId,
    required File file,
    String? content,
  }) async {
    try {
      final result = await remoteDataSource.uploadFile(
        conversationId: conversationId,
        file: file,
        content: content,
      );
      
      return result.fold(
        (failure) => Left(failure),
        (messageModel) async {
          // Add the uploaded message to local cache
          await localDataSource.addMessage(messageModel);
          return const Right(null);
        },
      );
    } catch (e) {
      _logger.e('Error uploading file: $e');
      return Left(
        NetworkFailure(
          error: e,
          message: 'Failed to upload file.',
        ),
      );
    }
  }

  /// Get current user ID (you'd implement this based on your auth system)
  Future<String> _getCurrentUserId() async {
    // TODO: Get from authenticated user service
    // For now, return a placeholder
    return 'current_user_id';
  }

  /// Refresh conversations in background
  Future<void> _refreshConversationsInBackground(String userId) async {
    try {
      final result = await remoteDataSource.getConversations();
      result.fold(
        (failure) => _logger.w('Background conversation refresh failed: ${failure.message}'),
        (conversations) async {
          await localDataSource.cacheConversations(conversations, userId);
          _logger.d('Background refreshed ${conversations.length} conversations');
        },
      );
    } catch (e) {
      _logger.w('Error in background conversation refresh: $e');
    }
  }

  /// Refresh messages in background
  Future<void> _refreshMessagesInBackground(String conversationId, int page, int pageSize) async {
    try {
      final result = await remoteDataSource.getMessages(
        conversationId,
        page: page,
        pageSize: pageSize,
      );
      result.fold(
        (failure) => _logger.w('Background message refresh failed: ${failure.message}'),
        (messages) async {
          await localDataSource.cacheMessages(conversationId, messages);
          _logger.d('Background refreshed ${messages.length} messages');
        },
      );
    } catch (e) {
      _logger.w('Error in background message refresh: $e');
    }
  }
}