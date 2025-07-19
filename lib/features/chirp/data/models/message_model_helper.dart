import 'package:academia/database/database.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';

// Convert from database model TO domain entity
extension MessageModelHelper on MessageData {
  Message toEntity() {
    return Message(
      id: id,
      sender: User(id: senderId, name: '', email: ''),
      recipient: User(id: recipientId, name: '', email: ''),
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
