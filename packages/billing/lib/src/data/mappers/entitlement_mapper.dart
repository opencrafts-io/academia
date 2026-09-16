import 'package:billing/src/data/data.dart';
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:database/database.dart' as database;

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

  database.BillingEntitlementsCompanion toCompanion() {
    return database.BillingEntitlementsCompanion(
      planCode: database.Value(planCode),
      key: database.Value(key),
      description: database.Value(description),
      unit: database.Value(unit),
      value: database.Value(value),
      createdAt: database.Value(createdAt),
      updatedAt: database.Value(updatedAt),
    );
  }
}

extension EntitlementMapper on domain.Entitlement {
  EntitlementDto toDto() {
    return EntitlementDto(
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

extension BillingEntitlementMapper on database.BillingEntitlement {
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
