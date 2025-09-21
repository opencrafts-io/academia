import 'package:equatable/equatable.dart';
import 'message.dart';
import 'conversation_participant.dart';

class Conversation extends Equatable {
  final String id;
  final List<ConversationParticipant> participants;
  final Message? lastMessage;
  final int unreadCount;
  final DateTime? lastMessageAt;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Conversation({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.unreadCount = 0,
    this.lastMessageAt,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        participants,
        lastMessage,
        unreadCount,
        lastMessageAt,
        updatedAt,
        createdAt,
      ];

  Conversation copyWith({
    String? id,
    List<ConversationParticipant>? participants,
    Message? lastMessage,
    int? unreadCount,
    DateTime? lastMessageAt,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Get the other participant in a conversation (not the current user)
  ConversationParticipant? getOtherParticipant(String? currentUserId) {
    if (currentUserId == null) return participants.isNotEmpty ? participants.first : null;
    
    try {
      return participants.firstWhere((p) => p.userId != currentUserId);
    } catch (e) {
      return participants.isNotEmpty ? participants.first : null;
    }
  }

  /// Check if conversation has unread messages
  bool get hasUnreadMessages => unreadCount > 0;

  /// Get display title for the conversation
  String getDisplayTitle(String? currentUserId) {
    final otherParticipant = getOtherParticipant(currentUserId);
    return otherParticipant?.name ?? 'Unknown User';
  }

  @override
  bool? get stringify => true;
}
