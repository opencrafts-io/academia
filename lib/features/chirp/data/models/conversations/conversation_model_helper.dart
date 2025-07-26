import 'package:academia/database/database.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import '../../../domain/entities/conversations/conversation.dart';

extension StringToUserProfileHelper on String {
  UserProfile toMinimalUserProfile() {
    String name = '';
    String bio = '';

    switch (this) {
      case 'user_1':
        name = 'Scarlett Johansson';
        bio = 'Software Engineer | Secretly has a crush on SAM';
        break;
      case 'user_2':
        name = 'Winnie Njuguna';
        bio = 'Product Designer | Unworthy of SAM';
        break;
      case 'current_user':
        name = 'Ngigi';
        bio = 'Online';
        break;
      default:
        name = 'Genos';
        bio = '';
    }

    return UserProfile(
      id: this,
      name: name,
      email: '$this@example.com',
      termsAccepted: true,
      onboarded: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      bio: bio,
      phone: '',
      username: this,
      nationalID: null,
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
