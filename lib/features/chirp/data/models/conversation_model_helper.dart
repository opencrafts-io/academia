import 'package:academia/database/database.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/message.dart';

extension ConversationModelHelper on ConversationData {
  Conversation toEntity() {
    return Conversation(
      id: id,
      user: User(id: userId, name: '', email: ''),
      lastMessage: lastMessageId != null
          ? Message(
              id: lastMessageId!,
              sender: User(id: '', name: '', email: ''),
              recipient: User(id: '', name: '', email: ''),
              content: '',
              sentAt: DateTime.now(),
            ) // TODO: Fetch actual message
          : null,
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
