import 'package:academia/core/core.dart';
import '../../../../../database/database.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';
import '../../../domain/entities/conversations/message.dart';

/// Enhanced conversation data extensions
extension EnhancedConversationDataHelper on EnhancedConversationData {
  /// Convert to domain entity
  Conversation toEntity() {
    final otherParticipant = ConversationParticipant(
      id: otherUserId,
      userId: otherUserId,
      name: otherUserName,
      email: otherUserEmail ?? '',
      avatar: otherUserAvatar,
      isOnline: isOnline,
      lastSeen: null,
      isCurrentUser: false,
    );

    return Conversation(
      id: conversationId,
      participants: [otherParticipant],
      lastMessage: lastMessageContent != null
          ? _createMessageFromCachedData()
          : null,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  Message? _createMessageFromCachedData() {
    if (lastMessageContent == null || lastMessageId == null) return null;

    final sender = ConversationParticipant(
      id: otherUserId, // This should be the actual sender ID
      userId: otherUserId,
      name: otherUserName,
      email: otherUserEmail ?? '',
      avatar: otherUserAvatar,
      isOnline: isOnline,
      lastSeen: null,
      isCurrentUser: false,
    );

    return Message(
      id: lastMessageId!,
      conversationId: conversationId,
      sender: sender,
      content: lastMessageContent!,
      sentAt: lastMessageAt ?? DateTime.now(),
      isRead: true, // Assume read for last messages
      isEdited: false,
      isDeleted: false,
      status: MessageStatus.sent,
    );
  }
}

/// Enhanced message data extensions
extension EnhancedMessageDataHelper on EnhancedMessageData {
  /// Convert to domain entity
  Message toEntity() {
    final sender = ConversationParticipant(
      id: senderId,
      userId: senderId,
      name: senderName ?? 'User $senderId',
      email: senderEmail ?? '',
      avatar: senderAvatar,
      isOnline: false,
      lastSeen: null,
      isCurrentUser: false,
    );

    return Message(
      id: id,
      conversationId: conversationId,
      sender: sender,
      content: content,
      sentAt: sentAt,
      isRead: isRead,
      isEdited: isEdited,
      isDeleted: isDeleted,
      status: MessageStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => MessageStatus.sent,
      ),
    );
  }
}

/// Conversation entity to enhanced data
extension ConversationToEnhancedData on Conversation {
  EnhancedConversationData toEnhancedData(String currentUserId) {
    // Get the other participant (not the current user)
    final otherParticipant = participants.firstWhere(
      (p) => p.userId != currentUserId,
      orElse: () => participants.first,
    );
    
    return EnhancedConversationData(
      conversationId: id,
      otherUserId: otherParticipant.userId,
      otherUserName: otherParticipant.name,
      otherUserAvatar: otherParticipant.avatar,
      otherUserEmail: otherParticipant.email,
      isOnline: otherParticipant.isOnline,
      lastMessageId: lastMessage != null ? lastMessage!.id : null,
      lastMessageContent: lastMessage?.content,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      apiUpdatedAt: updatedAt,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}

/// Message entity to enhanced data
extension MessageToEnhancedData on Message {
  EnhancedMessageData toEnhancedData(String conversationId) {
    return EnhancedMessageData(
      id: id,
      apiMessageId: id,
      senderId: sender.userId,
      conversationId: conversationId,
      senderName: sender.name,
      senderEmail: sender.email,
      senderAvatar: sender.avatar,
      content: content,
      imageUrl: null, // Would need to handle attachments separately
      isRead: isRead,
      isEdited: isEdited,
      isDeleted: isDeleted,
      apiCreatedAt: sentAt,
      sentAt: sentAt,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      status: status.name,
    );
  }
}
