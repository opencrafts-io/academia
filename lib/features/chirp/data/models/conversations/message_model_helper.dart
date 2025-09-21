import 'package:academia/database/database.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';

// Convert from database model TO domain entity
extension MessageModelHelper on MessageData {
  Message toEntity() {
    // Create a ConversationParticipant from the sender ID
    // Note: In a real scenario, we'd need to fetch participant details
    final senderParticipant = ConversationParticipant(
      id: senderId,
      userId: senderId,
      name: 'Unknown', // Would need to be fetched from user data
      email: '', // Would need to be fetched from user data
      isOnline: false,
      isCurrentUser: false,
    );
    
    return Message(
      id: int.tryParse(id) ?? 0, // Convert String id to int
      conversationId: recipientId, // Using recipientId as conversationId for now
      sender: senderParticipant,
      content: content,
      sentAt: sentAt,
      isRead: isRead,
      imageUrl: imageUrl,
      status: MessageStatus.sent, // Default status
    );
  }
}

// Convert from domain entity TO database model
extension MessageEntityHelper on Message {
  MessageData toData() => MessageData(
    id: id.toString(), // Convert int id to String
    senderId: sender.userId,
    recipientId: conversationId, // Using conversationId as recipientId
    content: content,
    sentAt: sentAt,
    isRead: isRead,
    imageUrl: imageUrl,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
