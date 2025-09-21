import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/conversations/message.dart';
import '../../../domain/entities/conversations/conversation_participant.dart';

part 'message_api_model.g.dart';

/// Message API model matching exact backend WebSocket and API response
@JsonSerializable()
class MessageApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  
  @JsonKey(name: 'sender_id')
  final String senderId;
  
  @JsonKey(name: 'content')
  final String content;
  
  @JsonKey(name: 'created_at')
  final String createdAt;
  
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  
  @JsonKey(name: 'has_attachment')
  final bool? hasAttachment;
  
  @JsonKey(name: 'attachments')
  final List<MessageAttachmentApiModel> attachments;

  // Optional fields that might be present in some responses
  @JsonKey(name: 'sender_name')
  final String? senderName;
  
  @JsonKey(name: 'sender_avatar')
  final String? senderAvatar;
  
  @JsonKey(name: 'sender_email')
  final String? senderEmail;

  const MessageApiModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.createdAt,
    this.conversationId,
    this.hasAttachment,
    required this.attachments,
    this.senderName,
    this.senderAvatar,
    this.senderEmail,
  });

  factory MessageApiModel.fromJson(Map<String, dynamic> json) =>
      _$MessageApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageApiModelToJson(this);

  /// Convert to domain entity
  Message toEntity() {
    final sender = ConversationParticipant(
      id: senderId,
      userId: senderId,
      name: senderName ?? 'User $senderId',
      email: senderEmail ?? '',
      avatar: senderAvatar,
      isOnline: false, // API doesn't provide this info
      lastSeen: null,
      isCurrentUser: false, // Will be determined by calling context
    );

    return Message(
      id: id,
      conversationId: conversationId ?? '',
      sender: sender,
      content: content,
      sentAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      isRead: false, // TODO: Implement read status based on backend logic
      isEdited: false, // API doesn't provide this yet
      isDeleted: false, // API doesn't provide this yet
      status: MessageStatus.sent, // Assume sent if we received from API
    );
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        content,
        createdAt,
        conversationId,
        hasAttachment,
        attachments,
        senderName,
        senderAvatar,
        senderEmail,
      ];
}

/// Message attachment model from API
@JsonSerializable()
class MessageAttachmentApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  
  @JsonKey(name: 'url')
  final String url;
  
  @JsonKey(name: 'file_name')
  final String fileName;
  
  @JsonKey(name: 'file_size')
  final int? fileSize;
  
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  
  @JsonKey(name: 'created_at')
  final String? createdAt;

  const MessageAttachmentApiModel({
    this.id,
    required this.url,
    required this.fileName,
    this.fileSize,
    this.mimeType,
    this.createdAt,
  });

  factory MessageAttachmentApiModel.fromJson(Map<String, dynamic> json) =>
      _$MessageAttachmentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAttachmentApiModelToJson(this);

  @override
  List<Object?> get props => [id, url, fileName, fileSize, mimeType, createdAt];
}

/// WebSocket message wrapper for different message types
@JsonSerializable()
class WebSocketMessageWrapper extends Equatable {
  @JsonKey(name: 'type')
  final String type;
  
  @JsonKey(name: 'message')
  final MessageApiModel? message;
  
  @JsonKey(name: 'message_id')
  final int? messageId;
  
  @JsonKey(name: 'user_id')
  final String? userId;
  
  @JsonKey(name: 'conversation_id')
  final String? conversationId;
  
  @JsonKey(name: 'content')
  final String? content;
  
  @JsonKey(name: 'timestamp')
  final double? timestamp;
  
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  const WebSocketMessageWrapper({
    required this.type,
    this.message,
    this.messageId,
    this.userId,
    this.conversationId,
    this.content,
    this.timestamp,
    this.errorMessage,
  });

  factory WebSocketMessageWrapper.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketMessageWrapperToJson(this);

  @override
  List<Object?> get props => [
        type,
        message,
        messageId,
        userId,
        conversationId,
        content,
        timestamp,
        errorMessage,
      ];
}

/// Create conversation request model
@JsonSerializable()
class CreateConversationRequest extends Equatable {
  @JsonKey(name: 'other_user_id')
  final String otherUserId;
  
  @JsonKey(name: 'other_user_name')
  final String otherUserName;

  const CreateConversationRequest({
    required this.otherUserId,
    required this.otherUserName,
  });

  factory CreateConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateConversationRequestToJson(this);

  @override
  List<Object?> get props => [otherUserId, otherUserName];
}

/// File upload response model
@JsonSerializable()
class FileUploadResponse extends Equatable {
  @JsonKey(name: 'file_upload_id')
  final String fileUploadId;
  
  @JsonKey(name: 'filename')
  final String filename;
  
  @JsonKey(name: 'file_size')
  final int fileSize;
  
  @JsonKey(name: 'content_type')
  final String contentType;
  
  @JsonKey(name: 'url')
  final String? url;

  const FileUploadResponse({
    required this.fileUploadId,
    required this.filename,
    required this.fileSize,
    required this.contentType,
    this.url,
  });

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);

  @override
  List<Object?> get props => [fileUploadId, filename, fileSize, contentType, url];
}

/// Mark messages as read request model
@JsonSerializable()
class MarkMessagesAsReadRequest extends Equatable {
  @JsonKey(name: 'message_ids')
  final List<int> messageIds;

  const MarkMessagesAsReadRequest({
    required this.messageIds,
  });

  factory MarkMessagesAsReadRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkMessagesAsReadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkMessagesAsReadRequestToJson(this);

  @override
  List<Object?> get props => [messageIds];
}