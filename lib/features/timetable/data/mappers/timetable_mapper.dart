import 'package:academia/database/database.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:drift/drift.dart';

extension TimetableDataX on TimetableData {
  /// Converts Drift [TimetableData] to Domain [TimetableEntity]
  TimetableEntity toEntity() {
    return TimetableEntity(
      id: id,
      serverId: serverId,
      name: name,
      userId: userId,
      institutionId: institution,
      isSynced: isSynced,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension TimetableEntityX on TimetableEntity {
  /// Converts Domain [TimetableEntity] to Drift [TimetableData] for DB reads
  TimetableData toData() {
    return TimetableData(
      id: id ?? '',
      serverId: serverId,
      name: name,
      userId: userId,
      institution: institutionId,
      isSynced: isSynced,
      isDeleted: isDeleted,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Converts Domain [TimetableEntity] to Drift [TimetableCompanion] for DB writes
  TimetableCompanion toCompanion() {
    return TimetableCompanion(
      id: (id == null || id!.isEmpty) ? const Value.absent() : Value(id!),
      serverId: serverId == null ? const Value.absent() : Value(serverId),
      name: Value(name),
      userId: Value(userId),
      institution: institutionId == null
          ? const Value.absent()
          : Value(institutionId),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt ?? DateTime.now()),
      updatedAt: Value(updatedAt ?? DateTime.now()),
    );
  }
}
