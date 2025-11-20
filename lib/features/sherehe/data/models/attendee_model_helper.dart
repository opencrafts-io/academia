import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/data/models/sherehe_user_model_helper.dart';
import 'package:academia/features/sherehe/domain/entities/attendee.dart';

extension AttendeeModelHelper on AttendeeData {
  Attendee toEntity() => Attendee(
    id: id,
    userId: userId,
    eventId: eventId,
    ticketId: ticketId,
    ticketQuantity: ticketQuantity,
    user: ShereheUserData.fromJson(user).toEntity(),
  );
}

extension AttendeeEntityHelper on Attendee {
  AttendeeData toModel() => AttendeeData(
    id: id,
    userId: userId,
    eventId: eventId,
    ticketId: ticketId,
    ticketQuantity: ticketQuantity,
    user: user.toModel().toJson(),
  );
}
