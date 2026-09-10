import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;

extension EntitlementDtoMapper on EntitlementDto {
  domain.Entitlement toDomain() {
    return domain.Entitlement(
      description: description,
      key: key,
      planCode: planCode,
      unit: unit,
      value: value,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
