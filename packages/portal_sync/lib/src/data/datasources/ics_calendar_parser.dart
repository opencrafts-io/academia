import '../../domain/entities/ics_calendar_event.dart';

/// The result of parsing one calendar feed: its events plus any declared
/// `VTIMEZONE` offsets, keyed by `TZID`. Offsets are a representative UTC
/// offset (e.g. `+0300`) taken from the timezone's last `STANDARD`/
/// `DAYLIGHT` sub-component; full historical DST transition rules are not
/// expanded.
class IcsParsedCalendar {
  const IcsParsedCalendar({
    required this.events,
    required this.timeZoneOffsets,
  });
  final List<IcsCalendarEvent> events;
  final Map<String, String> timeZoneOffsets;
}

/// A defensive, bounded parser for the RFC 5545 subset Academia needs:
/// `VEVENT` summary/description/location/UID, `DTSTART`/`DTEND` with
/// `TZID`/`VALUE=DATE`/UTC `Z` forms, `RRULE`, `EXDATE`, and a representative
/// `VTIMEZONE` offset. The feed is untrusted, attacker-reachable input, so
/// every bound here is a hard rejection rather than a best-effort guess.
///
/// This is implemented directly rather than via a pub.dev ICS package: the
/// subset required is small and precisely bounded, every other parser in
/// this codebase (`PortalSnapshot`, `PortalAnalysisPlan`) already follows
/// this same hand-rolled, defensively-bounded style for untrusted input, and
/// a hand-rolled parser avoids pulling an unvetted third-party parser onto
/// an attacker-reachable path for marginal convenience.
class IcsCalendarParser {
  const IcsCalendarParser._();

  static const int maxFeedTextLength = 2 * 1024 * 1024;
  static const int maxLines = 20000;
  static const int maxEvents = 1000;
  static const int maxExceptionDatesPerEvent = 500;
  static const int maxPropertyValueLength = 4096;

  /// Parses [icsText] or throws [FormatException] when it is not a
  /// structurally valid calendar, oversized, or missing a property RFC 5545
  /// requires on every `VEVENT` (`UID`, `DTSTART`).
  static IcsParsedCalendar parse(String icsText) {
    if (icsText.isEmpty || icsText.length > maxFeedTextLength) {
      throw const FormatException('Calendar feed is empty or too large.');
    }
    if (!icsText.contains('BEGIN:VCALENDAR')) {
      throw const FormatException('Not a VCALENDAR feed.');
    }
    final lines = icsText.split(RegExp(r'\r\n|\r|\n'));
    if (lines.length > maxLines) {
      throw const FormatException('Calendar feed has too many lines.');
    }
    final unfolded = _unfold(lines);

    final events = <IcsCalendarEvent>[];
    final timeZoneOffsets = <String, String>{};
    final stack = <String>[];
    Map<String, List<_IcsProperty>>? eventProps;
    String? tzId;
    String? tzOffset;

    for (final line in unfolded) {
      if (line.trim().isEmpty) continue;
      if (line.length > maxPropertyValueLength) {
        throw const FormatException('Calendar property value is too long.');
      }
      final upper = line.toUpperCase();
      if (upper.startsWith('BEGIN:')) {
        final name = upper.substring('BEGIN:'.length).trim();
        stack.add(name);
        if (name == 'VEVENT') {
          eventProps = <String, List<_IcsProperty>>{};
        } else if (name == 'VTIMEZONE') {
          tzId = null;
          tzOffset = null;
        }
        continue;
      }
      if (upper.startsWith('END:')) {
        final name = upper.substring('END:'.length).trim();
        if (stack.isEmpty || stack.last != name) {
          throw const FormatException('Unbalanced calendar component.');
        }
        stack.removeLast();
        if (name == 'VEVENT') {
          final props = eventProps;
          eventProps = null;
          if (props != null) {
            events.add(_buildEvent(props));
            if (events.length > maxEvents) {
              throw const FormatException(
                'Calendar feed exceeds the supported event count.',
              );
            }
          }
        } else if (name == 'VTIMEZONE') {
          if (tzId != null && tzOffset != null) {
            timeZoneOffsets[tzId] = tzOffset;
          }
          tzId = null;
          tzOffset = null;
        }
        continue;
      }
      final property = _parseProperty(line);
      if (property == null) continue;
      final currentComponent = stack.isEmpty ? '' : stack.last;
      switch (currentComponent) {
        case 'VEVENT':
          eventProps!.putIfAbsent(property.name, () => []).add(property);
        case 'VTIMEZONE':
          if (property.name == 'TZID') tzId = property.value.trim();
        case 'STANDARD':
        case 'DAYLIGHT':
          if (property.name == 'TZOFFSETTO') tzOffset = property.value.trim();
      }
    }
    if (stack.isNotEmpty) {
      throw const FormatException('Calendar feed has unterminated components.');
    }
    if (events.isEmpty) {
      throw const FormatException('Calendar feed has no usable events.');
    }
    return IcsParsedCalendar(
      events: List.unmodifiable(events),
      timeZoneOffsets: Map.unmodifiable(timeZoneOffsets),
    );
  }

  static List<String> _unfold(List<String> lines) {
    final unfolded = <String>[];
    for (final line in lines) {
      if (line.isEmpty) continue;
      if ((line.startsWith(' ') || line.startsWith('\t')) &&
          unfolded.isNotEmpty) {
        unfolded[unfolded.length - 1] += line.substring(1);
      } else {
        unfolded.add(line);
      }
    }
    return unfolded;
  }

  static _IcsProperty? _parseProperty(String line) {
    final colon = _unquotedIndexOf(line, ':');
    if (colon == -1) return null;
    final head = line.substring(0, colon);
    final value = line.substring(colon + 1);
    final headParts = _splitUnquoted(head, ';');
    if (headParts.isEmpty) return null;
    final name = headParts.first.trim().toUpperCase();
    final params = <String, String>{};
    for (final rawParam in headParts.skip(1)) {
      final eq = rawParam.indexOf('=');
      if (eq == -1) continue;
      final key = rawParam.substring(0, eq).trim().toUpperCase();
      var paramValue = rawParam.substring(eq + 1).trim();
      if (paramValue.startsWith('"') && paramValue.endsWith('"')) {
        paramValue = paramValue.substring(1, paramValue.length - 1);
      }
      params[key] = paramValue;
    }
    return _IcsProperty(name: name, params: params, value: _unescape(value));
  }

  static int _unquotedIndexOf(String line, String char) {
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final c = line[i];
      if (c == '"') inQuotes = !inQuotes;
      if (!inQuotes && c == char) return i;
    }
    return -1;
  }

  static List<String> _splitUnquoted(String text, String separator) {
    final parts = <String>[];
    var start = 0;
    var inQuotes = false;
    for (var i = 0; i < text.length; i++) {
      final c = text[i];
      if (c == '"') inQuotes = !inQuotes;
      if (!inQuotes && c == separator) {
        parts.add(text.substring(start, i));
        start = i + 1;
      }
    }
    parts.add(text.substring(start));
    return parts;
  }

  static String _unescape(String value) => value
      .replaceAll(r'\n', '\n')
      .replaceAll(r'\N', '\n')
      .replaceAll(r'\,', ',')
      .replaceAll(r'\;', ';')
      .replaceAll(r'\\', r'\');

  static IcsCalendarEvent _buildEvent(Map<String, List<_IcsProperty>> props) {
    final uid = props['UID']?.first.value.trim();
    final dtstart = props['DTSTART']?.first;
    if (uid == null || uid.isEmpty || dtstart == null) {
      throw const FormatException('A VEVENT is missing UID or DTSTART.');
    }
    final dtend = props['DTEND']?.first;
    final rruleRaw = props['RRULE']?.first;
    final exdateProps = props['EXDATE'] ?? const [];
    final exceptionDates = <IcsDateTime>[];
    for (final exdate in exdateProps) {
      for (final part in exdate.value.split(',')) {
        if (part.trim().isEmpty) continue;
        final parsed = _parseDateTime(part.trim(), exdate.params);
        if (parsed != null) exceptionDates.add(parsed);
        if (exceptionDates.length > maxExceptionDatesPerEvent) {
          throw const FormatException(
            'A VEVENT has too many EXDATE exceptions.',
          );
        }
      }
    }
    final start = _parseDateTime(dtstart.value.trim(), dtstart.params);
    if (start == null) {
      throw const FormatException('A VEVENT has an invalid DTSTART.');
    }
    final end = dtend == null
        ? null
        : _parseDateTime(dtend.value.trim(), dtend.params);
    return IcsCalendarEvent(
      uid: uid,
      summary: (props['SUMMARY']?.first.value ?? '').trim(),
      description: props['DESCRIPTION']?.first.value.trim(),
      location: props['LOCATION']?.first.value.trim(),
      start: start,
      end: end,
      recurrenceRule: rruleRaw == null ? null : _parseRule(rruleRaw.value),
      exceptionDates: List.unmodifiable(exceptionDates),
    );
  }

  static IcsDateTime? _parseDateTime(String value, Map<String, String> params) {
    if (params['VALUE'] == 'DATE') {
      final match = RegExp(r'^(\d{4})(\d{2})(\d{2})$').firstMatch(value);
      if (match == null) return null;
      return IcsDateTime(
        value: DateTime.utc(
          int.parse(match.group(1)!),
          int.parse(match.group(2)!),
          int.parse(match.group(3)!),
        ),
        isAllDay: true,
      );
    }
    final match = RegExp(r'^(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2})(Z)?$')
        .firstMatch(value);
    if (match == null) return null;
    final isUtc = match.group(7) == 'Z';
    final tzId = isUtc ? 'UTC' : params['TZID']?.trim();
    final dateTime = isUtc
        ? DateTime.utc(
            int.parse(match.group(1)!),
            int.parse(match.group(2)!),
            int.parse(match.group(3)!),
            int.parse(match.group(4)!),
            int.parse(match.group(5)!),
            int.parse(match.group(6)!),
          )
        : DateTime(
            int.parse(match.group(1)!),
            int.parse(match.group(2)!),
            int.parse(match.group(3)!),
            int.parse(match.group(4)!),
            int.parse(match.group(5)!),
            int.parse(match.group(6)!),
          );
    return IcsDateTime(
      value: dateTime,
      isAllDay: false,
      timeZoneId: (tzId == null || tzId.isEmpty) ? null : tzId,
    );
  }

  static IcsRecurrenceRule _parseRule(String raw) {
    final parts = <String, String>{};
    for (final pair in raw.split(';')) {
      final eq = pair.indexOf('=');
      if (eq == -1) continue;
      parts[pair.substring(0, eq).trim().toUpperCase()] = pair
          .substring(eq + 1)
          .trim();
    }
    final until = parts['UNTIL'] == null
        ? null
        : _parseDateTime(parts['UNTIL']!, const {})?.value;
    return IcsRecurrenceRule(
      raw: raw,
      frequency: parts['FREQ']?.toUpperCase(),
      interval: int.tryParse(parts['INTERVAL'] ?? ''),
      count: int.tryParse(parts['COUNT'] ?? ''),
      until: until,
      byDay: (parts['BYDAY'] ?? '')
          .split(',')
          .map((day) => day.replaceAll(RegExp(r'^[+-]?\d*'), '').trim())
          .where((day) => day.isNotEmpty)
          .toList(growable: false),
    );
  }
}

class _IcsProperty {
  const _IcsProperty({
    required this.name,
    required this.params,
    required this.value,
  });
  final String name;
  final Map<String, String> params;
  final String value;
}
