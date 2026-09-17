import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';

@freezed
abstract class Plan with _$Plan {
  const factory Plan({
    /// Server identifier used when attaching this plan to an order item.
    int? id,
    required bool active,
    required int billingIntervalDays,
    required String code,
    required DateTime createdAt,
    required String createdBy,
    required String currency,
    required String description,
    required String name,
    required int price,
    required DateTime updatedAt,
    required bool visible,
  }) = _Plan;
}
