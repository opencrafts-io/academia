import '../../domain/entities/agenda_event.dart';

class AgendaEventDto {
  const AgendaEventDto({required this.event});

  final AgendaEvent event;

  factory AgendaEventDto.fromJson(Map<String, dynamic> json) {
    return AgendaEventDto(
      event: AgendaEvent(
        id: _string(json['id']) ?? '',
        summary: _string(json['summary']),
        description: _string(json['description']),
        location: _string(json['location']),
        startTime: _dateTime(json['start_time']),
        endTime: _dateTime(json['end_time']),
        allDay: json['all_day'] == true,
        timezone: _string(json['timezone']),
        status: _string(json['status']),
        transparency: _string(json['transparency']),
        calendarId: _string(json['calendar_id']),
        htmlLink: _string(json['html_link']),
        created: _dateTime(json['created']),
        updated: _dateTime(json['updated']),
        etag: _string(json['etag']),
        attendees: _attendees(json['attendees']),
        reminders: _map(json['reminders']),
        recurrence: _strings(json['recurrence']),
        ownerId: _string(json['owner_id']),
        deleted: _dateTime(json['deleted']),
        syncStatus: _string(json['sync_status']),
      ),
    );
  }

  static AgendaPage pageFromJson(Map<String, dynamic> json) {
    final results = json['results'];
    return AgendaPage(
      count: json['count'] is num ? (json['count'] as num).toInt() : 0,
      next: _string(json['next']),
      previous: _string(json['previous']),
      results: results is List
          ? results
                .whereType<Map>()
                .map(
                  (value) =>
                      AgendaEventDto.fromJson(Map<String, dynamic>.from(value))
                          .event,
                )
                .toList()
          : const [],
    );
  }

  static Map<String, dynamic> requestJson(AgendaEventDraft draft) {
    return {
      'summary': draft.summary.trim(),
      'description': draft.description,
      'location': draft.location,
      'start_time': _dateTimeWithOffset(draft.startTime),
      'end_time': _dateTimeWithOffset(draft.endTime),
      'all_day': draft.allDay,
      'timezone': draft.timezone,
      'status': draft.status,
      'transparency': draft.transparency,
      'attendees': draft.attendees
          .map(
            (attendee) => {
              'email': attendee.email,
              'displayName': attendee.displayName,
            },
          )
          .toList(),
      'reminders': draft.reminders,
      'recurrence': draft.recurrence,
    };
  }
}

String? _string(Object? value) => value is String ? value : null;

DateTime? _dateTime(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

List<AgendaAttendee> _attendees(Object? value) {
  if (value is! List) return const [];
  return value.whereType<Map>().map((attendee) {
    final json = Map<String, dynamic>.from(attendee);
    return AgendaAttendee(
      email: _string(json['email']),
      displayName: _string(json['displayName']),
    );
  }).toList();
}

Map<String, dynamic> _map(Object? value) {
  if (value is! Map) return const {};
  return Map<String, dynamic>.from(value);
}

List<String> _strings(Object? value) {
  if (value is! List) return const [];
  return value.whereType<String>().toList();
}

String _dateTimeWithOffset(DateTime value) {
  final wallTime = DateTime(
    value.year,
    value.month,
    value.day,
    value.hour,
    value.minute,
    value.second,
    value.millisecond,
    value.microsecond,
  );
  final localValue = wallTime.toIso8601String();
  final dateTime = localValue.endsWith('Z')
      ? localValue.substring(0, localValue.length - 1)
      : localValue;
  final base = dateTime.split('.').first;
  final offset = value.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final hours = offset.inHours.abs().toString().padLeft(2, '0');
  final minutes = offset.inMinutes
      .abs()
      .remainder(60)
      .toString()
      .padLeft(2, '0');
  return '$base$sign$hours:$minutes';
}
