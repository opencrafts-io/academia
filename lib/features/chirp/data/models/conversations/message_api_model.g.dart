// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageApiModel _$MessageApiModelFromJson(Map<String, dynamic> json) =>
    MessageApiModel(
      id: (json['id'] as num).toInt(),
      senderId: json['sender_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      conversationId: json['conversation_id'] as String?,
      hasAttachment: json['has_attachment'] as bool?,
      attachments: (json['attachments'] as List<dynamic>)
          .map(
            (e) =>
                MessageAttachmentApiModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      senderName: json['sender_name'] as String?,
      senderAvatar: json['sender_avatar'] as String?,
      senderEmail: json['sender_email'] as String?,
    );

Map<String, dynamic> _$MessageApiModelToJson(MessageApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'content': instance.content,
      'created_at': instance.createdAt,
      'conversation_id': instance.conversationId,
      'has_attachment': instance.hasAttachment,
      'attachments': instance.attachments,
      'sender_name': instance.senderName,
      'sender_avatar': instance.senderAvatar,
      'sender_email': instance.senderEmail,
    };

MessageAttachmentApiModel _$MessageAttachmentApiModelFromJson(
  Map<String, dynamic> json,
) => MessageAttachmentApiModel(
  id: (json['id'] as num?)?.toInt(),
  url: json['url'] as String,
  fileName: json['file_name'] as String,
  fileSize: (json['file_size'] as num?)?.toInt(),
  mimeType: json['mime_type'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$MessageAttachmentApiModelToJson(
  MessageAttachmentApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'file_name': instance.fileName,
  'file_size': instance.fileSize,
  'mime_type': instance.mimeType,
  'created_at': instance.createdAt,
};

WebSocketMessageWrapper _$WebSocketMessageWrapperFromJson(
  Map<String, dynamic> json,
) => WebSocketMessageWrapper(
  type: json['type'] as String,
  message: json['message'] == null
      ? null
      : MessageApiModel.fromJson(json['message'] as Map<String, dynamic>),
  messageId: (json['message_id'] as num?)?.toInt(),
  userId: json['user_id'] as String?,
  conversationId: json['conversation_id'] as String?,
  content: json['content'] as String?,
  timestamp: (json['timestamp'] as num?)?.toDouble(),
  errorMessage: json['error_message'] as String?,
);

Map<String, dynamic> _$WebSocketMessageWrapperToJson(
  WebSocketMessageWrapper instance,
) => <String, dynamic>{
  'type': instance.type,
  'message': instance.message,
  'message_id': instance.messageId,
  'user_id': instance.userId,
  'conversation_id': instance.conversationId,
  'content': instance.content,
  'timestamp': instance.timestamp,
  'error_message': instance.errorMessage,
};

CreateConversationRequest _$CreateConversationRequestFromJson(
  Map<String, dynamic> json,
) => CreateConversationRequest(
  otherUserId: json['other_user_id'] as String,
  otherUserName: json['other_user_name'] as String,
);

Map<String, dynamic> _$CreateConversationRequestToJson(
  CreateConversationRequest instance,
) => <String, dynamic>{
  'other_user_id': instance.otherUserId,
  'other_user_name': instance.otherUserName,
};

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      fileUploadId: json['file_upload_id'] as String,
      filename: json['filename'] as String,
      fileSize: (json['file_size'] as num).toInt(),
      contentType: json['content_type'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'file_upload_id': instance.fileUploadId,
      'filename': instance.filename,
      'file_size': instance.fileSize,
      'content_type': instance.contentType,
      'url': instance.url,
    };

MarkMessagesAsReadRequest _$MarkMessagesAsReadRequestFromJson(
  Map<String, dynamic> json,
) => MarkMessagesAsReadRequest(
  messageIds: (json['message_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$MarkMessagesAsReadRequestToJson(
  MarkMessagesAsReadRequest instance,
) => <String, dynamic>{'message_ids': instance.messageIds};
