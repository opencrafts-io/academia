import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';

import '../../models/conversations/conversation_api_model.dart';
import '../../models/conversations/message_api_model.dart';
import '../../models/conversations/enhanced_conversation_model.dart';
import '../chirp_user_remote_datasource.dart';

/// Enhanced local data source for messaging with API support
abstract class EnhancedMessagingLocalDataSource {
  // Conversation caching
  Future<Either<Failure, void>> cacheConversations(
    List<ConversationApiModel> conversations,
    String currentUserId,
  );
  Future<Either<Failure, List<EnhancedConversationData>>> getCachedConversations();
  Stream<List<EnhancedConversationData>> getConversationsStream();
  
  // Message caching with pagination
  Future<Either<Failure, void>> cacheMessages(
    String conversationId,
    List<MessageApiModel> messages,
  );
  Future<Either<Failure, List<EnhancedMessageData>>> getCachedMessages(
    String conversationId, {
    int page = 1,
    int pageSize = 50,
  });
  Stream<List<EnhancedMessageData>> getMessagesStream(String conversationId);
  
  // Individual message operations
  Future<Either<Failure, EnhancedMessageData>> addMessage(MessageApiModel message);
  Future<Either<Failure, void>> updateMessage(MessageApiModel message);
  Future<Either<Failure, void>> deleteMessage(int messageId);
  Future<Either<Failure, EnhancedMessageData?>> getMessageById(int messageId);
  
  // User caching for participants
  Future<Either<Failure, void>> cacheUser(ConversationParticipantApiModel user);
  Future<Either<Failure, ChirpUserData?>> getCachedUser(String userId);
  
  // Draft messages for offline support
  Future<Either<Failure, void>> saveDraft(String conversationId, String content);
  Future<Either<Failure, DraftMessageData?>> getDraft(String conversationId);
  Future<Either<Failure, void>> deleteDraft(String conversationId);
  
  // Connection state management
  Future<Either<Failure, void>> updateConnectionState(
    String connectionId,
    String state,
    String? errorMessage,
  );
  Future<Either<Failure, WebSocketConnectionData?>> getConnectionState(String connectionId);
  
  // Cache invalidation
  Future<Either<Failure, void>> invalidateConversationsCache();
  Future<Either<Failure, void>> invalidateMessagesCache(String conversationId);
  Future<Either<Failure, void>> clearAllCache();
  
  // Unread message management
  Future<Either<Failure, void>> markMessagesAsRead(String conversationId, List<int> messageIds);
  Future<Either<Failure, int>> getUnreadCount(String conversationId, String currentUserId);
  
  // Offline queue management
  Future<Either<Failure, void>> queueOfflineMessage(String conversationId, String content);
  Future<Either<Failure, List<DraftMessageData>>> getOfflineQueue();
  Future<Either<Failure, void>> clearOfflineQueue();
}

class EnhancedMessagingLocalDataSourceImpl implements EnhancedMessagingLocalDataSource {
  final AppDataBase localDB;
  final Logger _logger = Logger();

  EnhancedMessagingLocalDataSourceImpl({required this.localDB});

  @override
  Future<Either<Failure, void>> cacheConversations(
    List<ConversationApiModel> conversations,
    String currentUserId,
  ) async {
    try {
      await localDB.transaction(() async {
        // Clear existing conversations
        await localDB.delete(localDB.enhancedConversationTable).go();
        
        // Insert new conversations
        for (final conversation in conversations) {
          final otherParticipant = conversation.participants.firstWhere(
            (p) => p.userId != currentUserId,
            orElse: () => conversation.participants.first,
          );
          
          final conversationData = EnhancedConversationData(
            conversationId: conversation.id,
            otherUserId: otherParticipant.userId,
            otherUserName: otherParticipant.userName,
            otherUserEmail: otherParticipant.email,
            otherUserAvatar: otherParticipant.avatarUrl,
            isOnline: false, // API model doesn't provide this, default to false
            lastMessageId: conversation.lastMessage?.id,
            lastMessageContent: conversation.lastMessage?.content,
            lastMessageAt: conversation.lastMessage != null 
                ? DateTime.tryParse(conversation.lastMessage!.createdAt) 
                : null,
            unreadCount: 0, // Will be calculated separately
            apiUpdatedAt: DateTime.tryParse(conversation.updatedAt),
            updatedAt: DateTime.tryParse(conversation.updatedAt) ?? DateTime.now(),
            createdAt: DateTime.tryParse(conversation.createdAt) ?? DateTime.now(),
          );
          
          await localDB.into(localDB.enhancedConversationTable).insert(conversationData);
          
          // Cache the participant
          await _cacheUserInternal(otherParticipant);
        }
      });
      
      _logger.d('Cached ${conversations.length} conversations');
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to cache conversations: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to save conversations locally.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<EnhancedConversationData>>> getCachedConversations() async {
    try {
      final conversations = await (localDB.select(localDB.enhancedConversationTable)
            ..orderBy([
              (c) => OrderingTerm(
                expression: c.lastMessageAt ?? c.apiUpdatedAt ?? c.updatedAt,
                mode: OrderingMode.desc,
              ),
            ]))
          .get();
      
      return Right(conversations);
      
    } catch (e) {
      _logger.e('Failed to get cached conversations: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load conversations.',
        ),
      );
    }
  }

  @override
  Stream<List<EnhancedConversationData>> getConversationsStream() {
    return (localDB.select(localDB.enhancedConversationTable)
          ..orderBy([
            (c) => OrderingTerm(
              expression: c.lastMessageAt ?? c.apiUpdatedAt ?? c.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .watch();
  }

  @override
  Future<Either<Failure, void>> cacheMessages(
    String conversationId,
    List<MessageApiModel> messages,
  ) async {
    try {
      await localDB.transaction(() async {
        // Delete existing messages for this conversation
        await (localDB.delete(localDB.enhancedMessageTable)
              ..where((m) => m.conversationId.equals(conversationId)))
            .go();
        
        // Insert new messages
        for (final message in messages) {
          final messageData = EnhancedMessageTableCompanion(
            // Don't set id - let it auto-increment
            apiMessageId: Value(message.id),
            conversationId: Value(conversationId),
            senderId: Value(message.senderId),
            senderName: Value(message.senderName ?? 'Unknown'),
            senderEmail: Value(message.senderEmail),
            senderAvatar: Value(message.senderAvatar),
            content: Value(message.content),
            imageUrl: const Value(null), // Would need to extract from attachments
            isRead: const Value(false), // Will be updated based on read status
            isEdited: const Value(false),
            isDeleted: const Value(false),
            apiCreatedAt: Value(DateTime.tryParse(message.createdAt) ?? DateTime.now()),
            sentAt: Value(DateTime.tryParse(message.createdAt) ?? DateTime.now()),
            status: const Value('sent'),
            updatedAt: Value(DateTime.now()),
            createdAt: Value(DateTime.now()),
          );
          
          final insertedMessage = await localDB.into(localDB.enhancedMessageTable).insertReturning(messageData);
          
          // Cache attachments if any
          for (final attachment in message.attachments) {
            final attachmentData = MessageAttachmentData(
              id: 0, // Will be auto-generated by database
              messageId: insertedMessage.id,
              attachmentType: 'file', // Default type
              url: attachment.url,
              fileName: attachment.fileName,
              fileSize: attachment.fileSize,
              mimeType: attachment.mimeType,
              createdAt: attachment.createdAt != null 
                  ? DateTime.tryParse(attachment.createdAt!) ?? DateTime.now()
                  : DateTime.now(),
            );
            
            await localDB.into(localDB.messageAttachmentsTable).insert(attachmentData);
          }
        }
      });
      
      _logger.d('Cached ${messages.length} messages for conversation $conversationId');
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to cache messages: $e');
      
      // If table doesn't exist, return success to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Enhanced messaging tables not created yet, skipping cache operation');
        return const Right(null);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to save messages locally.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<EnhancedMessageData>>> getCachedMessages(
    String conversationId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      
      final messages = await (localDB.select(localDB.enhancedMessageTable)
            ..where((m) => m.conversationId.equals(conversationId))
            ..orderBy([
              (m) => OrderingTerm(
                expression: m.apiCreatedAt,
                mode: OrderingMode.asc,
              ),
            ])
            ..limit(pageSize, offset: offset))
          .get();
      
      return Right(messages);
      
    } catch (e) {
      _logger.e('Failed to get cached messages: $e');
      
      // If table doesn't exist, return empty list to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Enhanced messaging tables not created yet, returning empty messages');
        return const Right([]);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load messages.',
        ),
      );
    }
  }

  @override
  Stream<List<EnhancedMessageData>> getMessagesStream(String conversationId) {
    try {
      return (localDB.select(localDB.enhancedMessageTable)
            ..where((m) => m.conversationId.equals(conversationId))
            ..orderBy([
              (m) => OrderingTerm(
                expression: m.apiCreatedAt,
                mode: OrderingMode.asc,
              ),
            ]))
          .watch();
    } catch (e) {
      _logger.w('Enhanced messaging table not available, returning empty stream');
      return Stream.value(<EnhancedMessageData>[]);
    }
  }

  @override
  Future<Either<Failure, EnhancedMessageData>> addMessage(MessageApiModel message) async {
    try {
      final messageData = EnhancedMessageTableCompanion(
        // Don't set id - let it auto-increment
        apiMessageId: Value(message.id),
        conversationId: Value(message.conversationId ?? ''),
        senderId: Value(message.senderId),
        senderName: Value(message.senderName ?? 'Unknown'),
        senderEmail: Value(message.senderEmail),
        senderAvatar: Value(message.senderAvatar),
        content: Value(message.content),
        imageUrl: const Value(null), // Would need to extract from attachments
        isRead: const Value(false),
        isEdited: const Value(false),
        isDeleted: const Value(false),
        apiCreatedAt: Value(DateTime.tryParse(message.createdAt) ?? DateTime.now()),
        sentAt: Value(DateTime.tryParse(message.createdAt) ?? DateTime.now()),
        status: const Value('sent'),
        updatedAt: Value(DateTime.now()),
        createdAt: Value(DateTime.now()),
      );
      
      final inserted = await localDB.into(localDB.enhancedMessageTable)
          .insertReturning(messageData);
      
      // Update conversation last message
      await _updateConversationLastMessage(message.conversationId ?? '', message);
      
      return Right(inserted);
      
    } catch (e) {
      _logger.e('Failed to add message: $e');
      
      // If table doesn't exist, create a dummy message data to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Enhanced messaging tables not created yet, skipping add operation');
        final dummyMessage = EnhancedMessageData(
          id: -1, // Dummy ID
          apiMessageId: message.id,
          conversationId: message.conversationId ?? '',
          senderId: message.senderId,
          senderName: message.senderName ?? 'Unknown',
          senderEmail: message.senderEmail,
          senderAvatar: message.senderAvatar,
          content: message.content,
          imageUrl: null,
          isRead: false,
          isEdited: false,
          isDeleted: false,
          apiCreatedAt: DateTime.tryParse(message.createdAt) ?? DateTime.now(),
          sentAt: DateTime.tryParse(message.createdAt) ?? DateTime.now(),
          status: 'sent',
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
        );
        return Right(dummyMessage);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to save message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateMessage(MessageApiModel message) async {
    try {
      await (localDB.update(localDB.enhancedMessageTable)
            ..where((m) => m.apiMessageId.equals(message.id)))
          .write(
        EnhancedMessageTableCompanion(
          content: Value(message.content),
          updatedAt: Value(DateTime.now()),
        ),
      );
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to update message: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to update message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage(int messageId) async {
    try {
      await (localDB.delete(localDB.enhancedMessageTable)
            ..where((m) => m.apiMessageId.equals(messageId)))
          .go();
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to delete message: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to delete message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, EnhancedMessageData?>> getMessageById(int messageId) async {
    try {
      final message = await (localDB.select(localDB.enhancedMessageTable)
            ..where((m) => m.apiMessageId.equals(messageId)))
          .getSingleOrNull();
      
      return Right(message);
      
    } catch (e) {
      _logger.e('Failed to get message by ID: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load message.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cacheUser(ConversationParticipantApiModel user) async {
    return _cacheUserInternal(user);
  }

  Future<Either<Failure, void>> _cacheUserInternal(ConversationParticipantApiModel user) async {
    try {
      final userData = ChirpUserData(
        id: user.userId,
        name: user.userName,
        email: user.email ?? '',
        vibepoints: 0,
        avatarUrl: user.avatarUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await localDB.into(localDB.chirpUserTable).insertOnConflictUpdate(userData);
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to cache user: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to save user data.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChirpUserData?>> getCachedUser(String userId) async {
    try {
      final user = await (localDB.select(localDB.chirpUserTable)
            ..where((u) => u.id.equals(userId)))
          .getSingleOrNull();
      
      return Right(user);
      
    } catch (e) {
      _logger.e('Failed to get cached user: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load user data.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveDraft(String conversationId, String content) async {
    try {
      final draftData = DraftMessageData(
        conversationId: conversationId,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await localDB.into(localDB.draftMessagesTable).insertOnConflictUpdate(draftData);
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to save draft: $e');
      
      // If table doesn't exist, return success to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Draft messages table not created yet, skipping save operation');
        return const Right(null);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to save draft.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DraftMessageData?>> getDraft(String conversationId) async {
    try {
      final draft = await (localDB.select(localDB.draftMessagesTable)
            ..where((d) => d.conversationId.equals(conversationId)))
          .getSingleOrNull();
      
      return Right(draft);
      
    } catch (e) {
      _logger.e('Failed to get draft: $e');
      
      // If table doesn't exist, return null to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Draft messages table not created yet, returning null');
        return const Right(null);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load draft.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteDraft(String conversationId) async {
    try {
      await (localDB.delete(localDB.draftMessagesTable)
            ..where((d) => d.conversationId.equals(conversationId)))
          .go();
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to delete draft: $e');
      
      // If table doesn't exist, return success to avoid breaking the app
      if (e.toString().contains('no such table')) {
        _logger.w('Draft messages table not created yet, skipping delete operation');
        return const Right(null);
      }
      
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to delete draft.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateConnectionState(
    String connectionId,
    String state,
    String? errorMessage,
  ) async {
    try {
      final connectionData = WebSocketConnectionData(
        connectionId: connectionId,
        state: state,
        lastConnectedAt: state == 'connected' ? DateTime.now() : null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await localDB.into(localDB.webSocketConnectionTable)
          .insertOnConflictUpdate(connectionData);
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to update connection state: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to update connection state.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, WebSocketConnectionData?>> getConnectionState(String connectionId) async {
    try {
      final connection = await (localDB.select(localDB.webSocketConnectionTable)
            ..where((c) => c.connectionId.equals(connectionId)))
          .getSingleOrNull();
      
      return Right(connection);
      
    } catch (e) {
      _logger.e('Failed to get connection state: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load connection state.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> invalidateConversationsCache() async {
    try {
      await localDB.delete(localDB.enhancedConversationTable).go();
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to invalidate conversations cache: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to clear conversations cache.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> invalidateMessagesCache(String conversationId) async {
    try {
      await (localDB.delete(localDB.enhancedMessageTable)
            ..where((m) => m.conversationId.equals(conversationId)))
          .go();
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to invalidate messages cache: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to clear messages cache.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearAllCache() async {
    try {
      await localDB.transaction(() async {
        await localDB.delete(localDB.enhancedConversationTable).go();
        await localDB.delete(localDB.enhancedMessageTable).go();
        await localDB.delete(localDB.messageAttachmentsTable).go();
        await localDB.delete(localDB.draftMessagesTable).go();
        await localDB.delete(localDB.webSocketConnectionTable).go();
      });
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to clear all cache: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to clear cache.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(String conversationId, List<int> messageIds) async {
    try {
      for (final messageId in messageIds) {
        await (localDB.update(localDB.enhancedMessageTable)
              ..where((m) => m.apiMessageId.equals(messageId)))
            .write(
          const EnhancedMessageTableCompanion(
            isRead: Value(true),
            updatedAt: Value.absent(),
          ),
        );
      }
      
      // Update conversation unread count
      await (localDB.update(localDB.enhancedConversationTable)
            ..where((c) => c.conversationId.equals(conversationId)))
          .write(
        const EnhancedConversationTableCompanion(
          unreadCount: Value(0),
          updatedAt: Value.absent(),
        ),
      );
      
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to mark messages as read: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to mark messages as read.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount(String conversationId, String currentUserId) async {
    try {
      final result = await (localDB.selectOnly(localDB.enhancedMessageTable)
            ..addColumns([localDB.enhancedMessageTable.id.count()])
            ..where(
              localDB.enhancedMessageTable.conversationId.equals(conversationId) &
              localDB.enhancedMessageTable.senderId.equals(currentUserId).not() &
              localDB.enhancedMessageTable.isRead.equals(false),
            ))
          .getSingle();
      
      final count = result.read(localDB.enhancedMessageTable.id.count()) ?? 0;
      return Right(count);
      
    } catch (e) {
      _logger.e('Failed to get unread count: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to get unread count.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> queueOfflineMessage(String conversationId, String content) async {
    // Use draft system for offline messages
    return saveDraft(conversationId, content);
  }

  @override
  Future<Either<Failure, List<DraftMessageData>>> getOfflineQueue() async {
    try {
      final drafts = await localDB.select(localDB.draftMessagesTable).get();
      return Right(drafts);
      
    } catch (e) {
      _logger.e('Failed to get offline queue: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to load offline messages.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearOfflineQueue() async {
    try {
      await localDB.delete(localDB.draftMessagesTable).go();
      return const Right(null);
      
    } catch (e) {
      _logger.e('Failed to clear offline queue: $e');
      return Left(
        CacheFailure(
          error: e,
          message: 'Failed to clear offline messages.',
        ),
      );
    }
  }

  /// Update conversation with last message info
  Future<void> _updateConversationLastMessage(String conversationId, MessageApiModel message) async {
    try {
      await (localDB.update(localDB.enhancedConversationTable)
            ..where((c) => c.conversationId.equals(conversationId)))
          .write(
        EnhancedConversationTableCompanion(
          lastMessageId: Value(message.id),
          lastMessageContent: Value(message.content),
          lastMessageAt: Value(DateTime.tryParse(message.createdAt)),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      _logger.w('Failed to update conversation last message: $e');
    }
  }
}