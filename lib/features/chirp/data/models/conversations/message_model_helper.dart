import 'package:academia/database/database.dart';
import '../../../domain/entities/conversations/message.dart';
import 'conversation_model_helper.dart';

// Convert from database model TO domain entity
extension MessageModelHelper on MessageData {
  Message toEntity() {
    return Message(
      id: id,
      sender: senderId.toMinimalChirpUser(),
      recipient: recipientId.toMinimalChirpUser(),
      content: content,
      sentAt: sentAt,
      isRead: isRead,
    );
  }
}

// Convert from domain entity TO database model
extension MessageEntityHelper on Message {
  MessageData toData() => MessageData(
    id: id,
    senderId: sender.id,
    recipientId: recipient.id,
    content: content,
    sentAt: sentAt,
    isRead: isRead,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
