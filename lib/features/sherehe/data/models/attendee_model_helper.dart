import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/attendee.dart';

extension AttendeeModelHelper on AttendeeData {
  Attendee toEntity() => Attendee(
    id: id,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    eventId: eventId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    email: email
  );
}

extension AttendeeEntityHelper on Attendee {
  AttendeeData toModel() => AttendeeData(
    id: id,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    eventId: eventId,
    createdAt: createdAt,
    updatedAt: DateTime.now(),
    email: email,
  );
}
