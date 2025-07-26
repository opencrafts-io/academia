import '../../domain/entities/attendee.dart';
import 'attendee_model.dart';

extension AttendeeModelHelper on AttendeeModel {
  Attendee toEntity() => Attendee(
    id: id,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    eventId: eventId,
    createdAt: createdAt,
  );
}

extension AttendeeEntityHelper on Attendee {
  AttendeeModel toModel() => AttendeeModel(
    id: id,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    eventId: eventId,
    createdAt: createdAt,
  );
}
