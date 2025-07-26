import 'package:academia/database/database.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import '../../../domain/entities/conversations/conversation.dart';

extension StringToUserProfileHelper on String {
  UserProfile toMinimalUserProfile() {
    return UserProfile(
      id: this,
      name: '',
      email: '',
      termsAccepted: false,
      onboarded: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      bio: '',
      phone: '',
      username: '',
      nationalID: '',
      vibePoints: 0,
      avatarUrl: null,
    );
  }
}

extension ConversationModelHelper on ConversationData {
  Conversation toEntity() {
    return Conversation(
      id: id,
      user: userId.toMinimalUserProfile(),
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
