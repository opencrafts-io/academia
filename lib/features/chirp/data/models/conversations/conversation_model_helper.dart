import 'package:academia/database/database.dart';
import '../../../domain/entities/chirp_user.dart';
import '../../../domain/entities/conversations/conversation.dart';

extension StringToChirpUserHelper on String {
  ChirpUser toMinimalChirpUser() {
    String name = '';
    String email = '';
    int vibepoints = 0;

    switch (this) {
      case 'user_1':
        name = 'Scarlett Johansson';
        email = 'scarlett@example.com';
        vibepoints = 150;
        break;
      case 'user_2':
        name = 'Winnie Njuguna';
        email = 'winnie@example.com';
        vibepoints = 75;
        break;
      case 'current_user':
        name = 'Ngigi';
        email = 'ngigi@example.com';
        vibepoints = 100;
        break;
      default:
        name = 'Genos';
        email = '$this@example.com';
        vibepoints = 0;
    }

    return ChirpUser(
      id: this,
      name: name,
      email: email,
      vibepoints: vibepoints,
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
