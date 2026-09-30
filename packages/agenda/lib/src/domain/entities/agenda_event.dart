class AgendaAttendee {
  const AgendaAttendee({this.email, this.displayName});

  final String? email;
  final String? displayName;
}

/// An agenda event as returned by the agenda service.
class AgendaEvent {
  const AgendaEvent({
    required this.id,
    this.summary,
    this.description,
    this.location,
    this.startTime,
    this.endTime,
    this.allDay = false,
    this.timezone,
    this.status,
    this.transparency,
    this.calendarId,
    this.htmlLink,
    this.created,
    this.updated,
    this.etag,
    this.attendees = const [],
    this.reminders = const {},
    this.recurrence = const [],
    this.ownerId,
    this.deleted,
    this.syncStatus,
  });

  final String id;
  final String? summary;
  final String? description;
  final String? location;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool allDay;
  final String? timezone;
  final String? status;
  final String? transparency;
  final String? calendarId;
  final String? htmlLink;
  final DateTime? created;
  final DateTime? updated;
  final String? etag;
  final List<AgendaAttendee> attendees;
  final Map<String, dynamic> reminders;
  final List<String> recurrence;
  final String? ownerId;
  final DateTime? deleted;
  final String? syncStatus;
}

/// Client-owned fields accepted by create and update requests.
class AgendaEventDraft {
  const AgendaEventDraft({
    required this.summary,
    required this.startTime,
    required this.endTime,
    this.description,
    this.location,
    this.allDay = false,
    this.timezone = 'Africa/Nairobi',
    this.status = 'confirmed',
    this.transparency = 'opaque',
    this.attendees = const [],
    this.reminders = const {'useDefault': true},
    this.recurrence = const [],
  });

  final String summary;
  final String? description;
  final String? location;
  final DateTime startTime;
  final DateTime endTime;
  final bool allDay;
  final String timezone;
  final String status;
  final String transparency;
  final List<AgendaAttendee> attendees;
  final Map<String, dynamic> reminders;
  final List<String> recurrence;
}

class AgendaPage {
  const AgendaPage({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  final int count;
  final List<AgendaEvent> results;
  final String? next;
  final String? previous;
}
