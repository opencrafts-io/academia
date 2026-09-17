import 'package:database/database.dart' as database;
import 'package:billing/src/domain/domain.dart' as domain;
import 'package:billing/src/data/data.dart';

/// Maps a network [PlanDto] to the domain [domain.Plan] and to a local
/// [database.PlansCompanion] for persistence.
extension PlanDtoMapper on PlanDto {
  /// Converts this DTO into the domain entity.
  domain.Plan toDomain() {
    return domain.Plan(
      id: id,
      active: active,
      billingIntervalDays: billingIntervalDays,
      code: code,
      createdAt: createdAt,
      createdBy: createdBy,
      currency: currency,
      description: description,
      name: name,
      price: price.round(),
      updatedAt: updatedAt,
      visible: visible,
    );
  }

  /// Converts this DTO into a companion for writing to the local database.
  ///
  /// Pass [id] when updating an existing row (typically looked up by
  /// [code]); leave it `null` when inserting a new row with an
  /// autoincrementing primary key.
  database.PlansCompanion toCompanion({int? existingId}) {
    final resolvedId = existingId ?? id;
    return database.PlansCompanion(
      id: resolvedId == null
          ? const database.Value.absent()
          : database.Value(resolvedId),
      active: database.Value(active),
      billingIntervalDays: database.Value(billingIntervalDays),
      code: database.Value(code),
      createdAt: database.Value(createdAt),
      createdBy: database.Value(createdBy),
      currency: database.Value(currency),
      description: database.Value(description),
      name: database.Value(name),
      price: database.Value(price.toDouble()),
      updatedAt: database.Value(updatedAt),
      visible: database.Value(visible),
    );
  }
}

/// Maps the domain [domain.Plan] to a network [PlanDto] and to a local
/// [database.PlansCompanion] for persistence.
extension PlanMapper on domain.Plan {
  /// Converts this domain entity into a network DTO (e.g. for a
  /// create/update request body).
  PlanDto toDto() {
    return PlanDto(
      id: id,
      active: active,
      billingIntervalDays: billingIntervalDays,
      code: code,
      createdAt: createdAt,
      createdBy: createdBy,
      currency: currency,
      description: description,
      name: name,
      price: price.round(),
      updatedAt: updatedAt,
      visible: visible,
    );
  }

  /// Converts this domain entity into a companion for writing to the
  /// local database. Pass [id] when updating an existing row; leave it
  /// `null` when inserting a new row with an autoincrementing primary key.
  database.PlansCompanion toCompanion({int? existingId}) {
    final resolvedId = existingId ?? id;
    return database.PlansCompanion(
      id: resolvedId == null
          ? const database.Value.absent()
          : database.Value(resolvedId),
      active: database.Value(active),
      billingIntervalDays: database.Value(billingIntervalDays),
      code: database.Value(code),
      createdAt: database.Value(createdAt),
      createdBy: database.Value(createdBy),
      currency: database.Value(currency),
      description: database.Value(description),
      name: database.Value(name),
      price: database.Value(price.toDouble()),
      updatedAt: database.Value(updatedAt),
      visible: database.Value(visible),
    );
  }
}

/// Maps a local [database.Plan] row back to the domain [domain.Plan].
extension PlanEntityMapper on database.Plan {
  domain.Plan toDomain() {
    return domain.Plan(
      id: id,
      active: active,
      billingIntervalDays: billingIntervalDays,
      code: code,
      createdAt: createdAt,
      createdBy: createdBy,
      currency: currency,
      description: description,
      name: name,
      price: price.round(),
      updatedAt: updatedAt,
      visible: visible,
    );
  }
}
