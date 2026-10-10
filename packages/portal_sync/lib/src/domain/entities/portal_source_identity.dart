import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Stable, deterministic identity hashing shared by every portal import path
/// (live DOM capture, calendar feeds, and the document/image fallback) so the
/// same course or meeting resolves to the same source id regardless of which
/// capture path observed it. Never hash private credentials (feed URLs,
/// cookies, raw page text) into these components; hash a derived identifier
/// instead.
class PortalSourceIdentity {
  const PortalSourceIdentity._();

  static String hash(List<Object?> components) =>
      sha256.convert(utf8.encode(jsonEncode(components))).toString();
}

/// Normalizes free-text day-of-week labels to the canonical capitalized
/// English name used across every portal draft, or null when unrecognized.
/// Never guesses a day from context; an unrecognized label stays null so the
/// caller can skip or hold the record instead of inventing a value.
String? normalizePortalDay(String value) {
  final normalized = value.trim().toLowerCase().replaceAll('.', '');
  return switch (normalized) {
    'monday' || 'mon' => 'Monday',
    'tuesday' || 'tue' || 'tues' => 'Tuesday',
    'wednesday' || 'wed' => 'Wednesday',
    'thursday' || 'thu' || 'thur' || 'thurs' => 'Thursday',
    'friday' || 'fri' => 'Friday',
    'saturday' || 'sat' => 'Saturday',
    'sunday' || 'sun' => 'Sunday',
    _ => null,
  };
}

/// Normalizes a 12- or 24-hour clock time string to zero-padded 24-hour
/// `HH:mm`, or null when it cannot be parsed unambiguously.
String? normalizePortalTime(String value) {
  final match = RegExp(
    r'^(\d{1,2}):(\d{2})(?:\s*([AP]M))?$',
    caseSensitive: false,
  ).firstMatch(value.trim());
  if (match == null) return null;
  var hour = int.parse(match.group(1)!);
  final minute = int.parse(match.group(2)!);
  final meridiem = match.group(3)?.toUpperCase();
  if (minute > 59 || (meridiem == null ? hour > 23 : hour < 1 || hour > 12)) {
    return null;
  }
  if (meridiem == 'AM' && hour == 12) hour = 0;
  if (meridiem == 'PM' && hour != 12) hour += 12;
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

/// True when [start] is strictly before [end] as zero-padded `HH:mm` values.
bool validPortalTimeRange(String start, String end) => start.compareTo(end) < 0;
