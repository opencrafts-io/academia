import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';

extension AgendaEventExtension on AgendaEvent {
  AgendaEventData toModel() => AgendaEventData(
    id: id,
    allDay: allDay,
    etag: etag,
    status: status,
    summary: summary,
    ownerId: ownerId,
    created: created,
    updated: updated,
    endTime: endTime,
    location: location,
    htmlLink: htmlLink,
    timezone: timezone,
    startTime: startTime,
    attendees: attendees,
    reminders: reminders,
    calendarId: calendarId,
    recurrence: recurrence,
    description: description,
    transparency: transparency,
  );
}

extension AgendaEventDataExtension on AgendaEventData {
  AgendaEvent toEntity() => AgendaEvent(
    id: id,
    allDay: allDay,
    etag: etag,
    status: status,
    summary: summary,
    ownerId: ownerId,
    created: created,
    updated: updated,
    endTime: endTime,
    location: location,
    htmlLink: htmlLink,
    timezone: timezone,
    startTime: startTime,
    attendees: attendees,
    reminders: reminders,
    calendarId: calendarId,
    recurrence: recurrence,
    description: description,
    transparency: transparency,
  );
}
