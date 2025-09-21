import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../entities/conversations/conversation.dart';
import '../../entities/conversations/message.dart';
import '../../../data/services/websocket_service.dart';

/// Enhanced conversation repository interface
abstract class EnhancedConversationRepository {
  // Conversation management
  Future<Either<Failure, List<Conversation>>> getConversations({
    String? currentUserId,
    bool forceRefresh = false,
  });
  Stream<List<Conversation>> getConversationsStream({String? currentUserId});
  
  Future<Either<Failure, Conversation>> createConversation({
    required String otherUserId,
    required String otherUserName,
    String? currentUserId,
  });
  
  // Message management
  Future<Either<Failure, List<Message>>> getMessages({
    required String conversationId,
    int page = 1,
    int pageSize = 50,
    bool forceRefresh = false,
  });
  Stream<List<Message>> getMessagesStream(String conversationId);
  
  Future<Either<Failure, void>> sendMessage({
    required String conversationId,
    required String content,
    File? file,
  });
  
  Future<Either<Failure, void>> markMessagesAsRead({
    required String conversationId,
    required List<int> messageIds,
  });
  
  // Real-time message operations (WebSocket)
  Future<Either<Failure, void>> editMessage({
    required int messageId,
    required String content,
  });
  
  Future<Either<Failure, void>> deleteMessage(int messageId);
  
  // Typing indicators
  Future<Either<Failure, void>> startTyping(String conversationId);
  Future<Either<Failure, void>> stopTyping(String conversationId);
  
  // Conversation session management
  Future<Either<Failure, void>> joinConversation(String conversationId);
  Future<Either<Failure, void>> leaveConversation();
  
  // Real-time streams
  Stream<Message> get newMessages;
  Stream<String> get typingIndicators; // Returns user ID, empty string for stop
  Stream<WebSocketConnectionState> get connectionState;
  
  // Connection management
  Future<Either<Failure, void>> connectToRealTime();
  Future<void> disconnectFromRealTime();
  
  // Offline support
  Future<Either<Failure, void>> syncOfflineMessages();
  Future<Either<Failure, String?>> getDraft(String conversationId);
  Future<Either<Failure, void>> saveDraft(String conversationId, String content);
  Future<Either<Failure, void>> deleteDraft(String conversationId);
}