import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_dto.freezed.dart';
part 'plan_dto.g.dart';

@freezed
abstract class PlanDto with _$PlanDto {
  const factory PlanDto({
    required bool active,
    @JsonKey(name: "billing_interval_days") required int billingIntervalDays,
    required String code,
    @JsonKey(name: "created_at") required DateTime createdAt,
    @JsonKey(name: "created_by") required String createdBy,
    required String currency,
    required String description,
    required String name,
    required int price,
    @JsonKey(name: "updated_at") required DateTime updatedAt,
    required bool visible,
  }) = _PlanDto;

  factory PlanDto.fromJson(Map<String, Object?> json) =>
      _$PlanDtoFromJson(json);
}
