import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/attendee.dart';

extension AttendeeModelHelper on AttendeeData {
  Attendee toEntity() => Attendee(
    id: id,
    userId: userId,
    eventId: eventId,
    deleteTag: deleteTag,
    createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
  );
}

extension AttendeeEntityHelper on Attendee {
  AttendeeData toModel() => AttendeeData(
    id: id,
    userId: userId,
    eventId: eventId,
    deleteTag: deleteTag,
    createdAt: createdAt.toIso8601String(),
    updatedAt: updatedAt.toIso8601String(),
  );
}
