import 'package:freezed_annotation/freezed_annotation.dart';

part 'entitlement.freezed.dart';

@freezed
abstract class Entitlement with _$Entitlement {
  const factory Entitlement({
    required String? description,
    required String key,
    required String planCode,
    required String unit,
    required int value,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Entitlement;
}
