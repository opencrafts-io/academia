class AgendaEvent {
  final String id;
  final bool allDay;
  final String? summary;
  final String? description;
  final String? location;
  final String? htmlLink;
  final String? calendarId;
  final String? ownerId;
  final String? timezone;
  final String? status;
  final String? transparency;
  final String? etag;

  final DateTime? created;
  final DateTime? updated;
  final DateTime? startTime;
  final DateTime? endTime;

  final List<dynamic> attendees;
  final List<dynamic> recurrence;
  final Map<String, dynamic> reminders;

  AgendaEvent({
    required this.id,
    this.allDay = false,
    this.summary,
    this.description,
    this.location,
    this.htmlLink,
    this.calendarId,
    this.ownerId,
    this.timezone,
    this.status,
    this.transparency,
    this.etag,
    required this.created,
    required this.updated,
    required this.startTime,
    required this.endTime,
    List<dynamic>? attendees,
    List<dynamic>? recurrence,
    Map<String, dynamic>? reminders,
  }) : attendees = attendees ?? [],
       recurrence = recurrence ?? [],
       reminders = reminders ?? {};

  AgendaEvent copyWith({
    String? id,
    bool? allDay,
    String? summary,
    String? description,
    String? location,
    String? htmlLink,
    String? calendarId,
    String? ownerId,
    String? timezone,
    String? status,
    String? transparency,
    String? etag,
    DateTime? created,
    DateTime? updated,
    DateTime? startTime,
    DateTime? endTime,
    List<dynamic>? attendees,
    List<dynamic>? recurrence,
    Map<String, dynamic>? reminders,
  }) {
    return AgendaEvent(
      id: id ?? this.id,
      allDay: allDay ?? this.allDay,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      location: location ?? this.location,
      htmlLink: htmlLink ?? this.htmlLink,
      calendarId: calendarId ?? this.calendarId,
      ownerId: ownerId ?? this.ownerId,
      timezone: timezone ?? this.timezone,
      status: status ?? this.status,
      transparency: transparency ?? this.transparency,
      etag: etag ?? this.etag,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendees: attendees ?? this.attendees,
      recurrence: recurrence ?? List<dynamic>.from(this.recurrence),
      reminders: reminders ?? this.reminders,
    );
  }
}
