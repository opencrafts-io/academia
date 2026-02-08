import 'package:academia/database/database.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:drift/drift.dart';

extension TimetableEntryDataX on TimetableEntryData {
  /// Converts Drift [TimetableEntryData] to Domain [TimetableEntryEntity]
  TimetableEntryEntity toEntity() {
    return TimetableEntryEntity(
      id: id,
      serverId: serverId,
      userId: userId,
      institutionId: institutionId,
      courseId: courseId,
      timetableId: timetableId,
      rrule: rrule,
      startDate: startDate,
      durationMinutes: durationMinutes,
      location: location,
      room: room,
      building: building,
      isSynced: isSynced,
      isDeleted: isDeleted,
      lastUpdated: lastUpdated,
    );
  }
}

extension TimetableEntryEntityX on TimetableEntryEntity {
  /// Converts Domain [TimetableEntryEntity] to Drift [TimetableEntryData] for DB reads
  TimetableEntryData toData() {
    return TimetableEntryData(
      id: id ?? '',
      serverId: serverId,
      userId: userId,
      institutionId: institutionId,
      courseId: courseId,
      timetableId: timetableId,
      rrule: rrule,
      startDate: startDate,
      durationMinutes: durationMinutes,
      location: location,
      room: room,
      building: building,
      isSynced: isSynced,
      isDeleted: isDeleted,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }

  /// Converts Domain [TimetableEntryEntity] to Drift [TimetableEntryCompanion] for DB writes
  TimetableEntryCompanion toCompanion() {
    return TimetableEntryCompanion(
      id: (id == null || id!.isEmpty) ? const Value.absent() : Value(id!),
      serverId: serverId == null ? const Value.absent() : Value(serverId),
      userId: Value(userId),
      institutionId: Value(institutionId),
      courseId: Value(courseId),
      timetableId: Value(timetableId),
      rrule: rrule == null ? const Value.absent() : Value(rrule),
      startDate: Value(startDate),
      durationMinutes: Value(durationMinutes),
      location: location == null ? const Value.absent() : Value(location),
      room: room == null ? const Value.absent() : Value(room),
      building: building == null ? const Value.absent() : Value(building),
      isSynced: Value(isSynced),
      isDeleted: Value(isDeleted),
      lastUpdated: Value(lastUpdated ?? DateTime.now()),
    );
  }
}
