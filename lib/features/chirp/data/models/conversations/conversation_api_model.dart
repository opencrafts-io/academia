import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/conversations/conversation.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';
import '../../../domain/entities/chirp_user.dart';
import 'message_api_model.dart';

part 'conversation_api_model.g.dart';

/// Conversation API model matching exact backend response from GET /conversations/
@JsonSerializable()
class ConversationApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  
  @JsonKey(name: 'participants')
  final List<ConversationParticipantApiModel> participants;
  
  @JsonKey(name: 'last_message')
  final MessageApiModel? lastMessage;
  
  @JsonKey(name: 'created_at')
  final String createdAt;
  
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const ConversationApiModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationApiModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationApiModelToJson(this);

  /// Convert to domain entity
  Conversation toEntity(String currentUserId) {
    // Convert all participants to ConversationParticipant entities
    final domainParticipants = participants.map((participant) => 
      ConversationParticipant(
        id: participant.userId,
        userId: participant.userId,
        name: participant.userName,
        email: participant.email ?? '',
        avatar: participant.avatarUrl,
        isOnline: false, // API doesn't provide this, default to false
        lastSeen: null, // API doesn't provide this
        isCurrentUser: participant.userId == currentUserId,
      ),
    ).toList();

    return Conversation(
      id: id,
      participants: domainParticipants,
      lastMessage: lastMessage?.toEntity(),
      lastMessageAt: lastMessage != null ? DateTime.tryParse(lastMessage!.createdAt) : null,
      unreadCount: _calculateUnreadCount(currentUserId),
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
    );
  }

  int _calculateUnreadCount(String currentUserId) {
    // TODO: Implement based on actual unread logic from backend
    // For now, return 0 as backend might provide this directly in future
    return 0;
  }

  @override
  List<Object?> get props => [id, participants, lastMessage, createdAt, updatedAt];
}

/// Conversation participant model from API
@JsonSerializable()
class ConversationParticipantApiModel extends Equatable {
  @JsonKey(name: 'user_id')
  final String userId;
  
  @JsonKey(name: 'user_name')
  final String userName;
  
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  
  @JsonKey(name: 'email')
  final String? email;

  const ConversationParticipantApiModel({
    required this.userId,
    required this.userName,
    this.avatarUrl,
    this.email,
  });

  factory ConversationParticipantApiModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationParticipantApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationParticipantApiModelToJson(this);

  /// Convert to ChirpUser entity
  ChirpUser toChirpUser() {
    return ChirpUser(
      username: "",
      id: userId,
      name: userName,
      email: email ?? '',
      vibepoints: 0, // Default value, not provided by API
      avatarUrl: avatarUrl,
    );
  }

  @override
  List<Object?> get props => [userId, userName, avatarUrl, email];
}
