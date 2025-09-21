import 'package:academia/database/database.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';

extension StringHelper on String {
  ChirpUser toMinimalChirpUser() {
    return ChirpUser(
      id: this,
      name: 'User $this',
      email: 'user$this@example.com',
      vibepoints: 0,
      avatarUrl: null,
    );
  }
}

extension ConversationModelHelper on ConversationData {
  Conversation toEntity() {
    // Create a minimal conversation participant from the user ID
    final participant = ConversationParticipant(
      id: userId,
      userId: userId,
      name: 'User $userId',
      email: 'user$userId@example.com',
      avatar: null,
      isOnline: false,
      lastSeen: null,
      isCurrentUser: false, // Default, should be determined by calling code
    );

    return Conversation(
      id: id,
      participants: [participant],
      lastMessage: null, // repository will fetch actual message ;)
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ConversationEntityHelper on Conversation {
  ConversationData toData() {
    // Use the first participant as the user (this is a simplified mapping)
    final firstParticipant = participants.isNotEmpty 
        ? participants.first 
        : null;
    
    return ConversationData(
      id: id,
      userId: firstParticipant?.userId ?? '',
      lastMessageId: lastMessage?.id.toString(),
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
