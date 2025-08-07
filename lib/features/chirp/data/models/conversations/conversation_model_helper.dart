import 'package:academia/database/database.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../domain/entities/conversations/conversation.dart';

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
    return Conversation(
      id: id,
      user: userId.toMinimalChirpUser(),
      lastMessage: null, // repository will fetch actual message ;)
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
    );
  }
}

extension ConversationEntityHelper on Conversation {
  ConversationData toData() => ConversationData(
    id: id,
    userId: user.id,
    lastMessageId: lastMessage?.id,
    lastMessageAt: lastMessageAt,
    unreadCount: unreadCount,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
