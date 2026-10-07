import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_activity_request_dto.freezed.dart';
part 'complete_activity_request_dto.g.dart';

@freezed
abstract class CompletionMetadataDto with _$CompletionMetadataDto {
  const factory CompletionMetadataDto({
    required String source,
    required String event,
  }) = _CompletionMetadataDto;

  factory CompletionMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$CompletionMetadataDtoFromJson(json);
}

@freezed
abstract class CompleteActivityRequestDto with _$CompleteActivityRequestDto {
  const factory CompleteActivityRequestDto({
    @JsonKey(name: 'account_id') required String accountId,
    @JsonKey(name: 'activity_id') required String activityId,
    @JsonKey(name: 'idempotency_key') required String idempotencyKey,
    required CompletionMetadataDto metadata,
  }) = _CompleteActivityRequestDto;

  factory CompleteActivityRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteActivityRequestDtoFromJson(json);
}
