// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationApiModel _$ConversationApiModelFromJson(
  Map<String, dynamic> json,
) => ConversationApiModel(
  id: json['id'] as String,
  participants: (json['participants'] as List<dynamic>)
      .map(
        (e) =>
            ConversationParticipantApiModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  lastMessage: json['last_message'] == null
      ? null
      : MessageApiModel.fromJson(json['last_message'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$ConversationApiModelToJson(
  ConversationApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'participants': instance.participants,
  'last_message': instance.lastMessage,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

ConversationParticipantApiModel _$ConversationParticipantApiModelFromJson(
  Map<String, dynamic> json,
) => ConversationParticipantApiModel(
  userId: json['user_id'] as String,
  userName: json['user_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$ConversationParticipantApiModelToJson(
  ConversationParticipantApiModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'user_name': instance.userName,
  'avatar_url': instance.avatarUrl,
  'email': instance.email,
};
