import 'package:freezed_annotation/freezed_annotation.dart';

part 'entitlement_dto.freezed.dart';
part 'entitlement_dto.g.dart';

@freezed
abstract class EntitlementDto with _$EntitlementDto {
  const factory EntitlementDto({
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required String? description,
    required String key,
    @JsonKey(name: 'plan_code')
    required String planCode,
    required String unit,
    required int value,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _EntitlementDto;

  factory EntitlementDto.fromJson(Map<String, Object?> json) =>
      _$EntitlementDtoFromJson(json);
}
