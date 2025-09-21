import 'package:equatable/equatable.dart';
import 'conversation_participant.dart';

class Message extends Equatable {
  final int id;
  final String conversationId;
  final String content;
  final ConversationParticipant sender;
  final DateTime sentAt;
  final bool isRead;
  final bool isEdited;
  final bool isDeleted;
  final String? imageUrl;
  final MessageStatus status;
  final DateTime? editedAt;

  const Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.sender,
    required this.sentAt,
    this.isRead = false,
    this.isEdited = false,
    this.isDeleted = false,
    this.imageUrl,
    this.status = MessageStatus.sent,
    this.editedAt,
  });

  @override
  List<Object?> get props => [
        id,
        conversationId,
        content,
        sender,
        sentAt,
        isRead,
        isEdited,
        isDeleted,
        imageUrl,
        status,
        editedAt,
      ];

  Message copyWith({
    int? id,
    String? conversationId,
    String? content,
    ConversationParticipant? sender,
    DateTime? sentAt,
    bool? isRead,
    bool? isEdited,
    bool? isDeleted,
    String? imageUrl,
    MessageStatus? status,
    DateTime? editedAt,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      editedAt: editedAt ?? this.editedAt,
    );
  }

  /// Check if message has been delivered
  bool get isDelivered => status == MessageStatus.delivered || status == MessageStatus.read;

  /// Check if message sending failed
  bool get isFailed => status == MessageStatus.failed;

  /// Get display content (handles deleted messages)
  String get displayContent {
    if (isDeleted) return 'This message was deleted';
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return content.isNotEmpty ? content : 'Image';
    }
    return content;
  }

  @override
  bool? get stringify => true;
}

enum MessageStatus {
  pending,
  sent,
  delivered,
  read,
  failed,
}

class SendMessageParams {
  final String conversationId;
  final String content;
  final String? imagePath;

  SendMessageParams({
    required this.conversationId,
    required this.content,
    this.imagePath,
  });
}
