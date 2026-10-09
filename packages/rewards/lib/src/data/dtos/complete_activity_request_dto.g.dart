// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_activity_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompletionMetadataDto _$CompletionMetadataDtoFromJson(
  Map<String, dynamic> json,
) => _CompletionMetadataDto(
  source: json['source'] as String,
  event: json['event'] as String,
);

Map<String, dynamic> _$CompletionMetadataDtoToJson(
  _CompletionMetadataDto instance,
) => <String, dynamic>{'source': instance.source, 'event': instance.event};

_CompleteActivityRequestDto _$CompleteActivityRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CompleteActivityRequestDto(
  accountId: json['account_id'] as String,
  activityId: json['activity_id'] as String,
  idempotencyKey: json['idempotency_key'] as String,
  metadata: CompletionMetadataDto.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CompleteActivityRequestDtoToJson(
  _CompleteActivityRequestDto instance,
) => <String, dynamic>{
  'account_id': instance.accountId,
  'activity_id': instance.activityId,
  'idempotency_key': instance.idempotencyKey,
  'metadata': instance.metadata,
};
