import 'package:drift/drift.dart';

class DateTimeConverter extends TypeConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromSql(String? dbValue) {
    if (dbValue?.isEmpty ?? true) {
      // Return Unix epoch (January 1st, 1970) if the date string is empty
      return DateTime.utc(1970, 1, 1); // Use UTC
    }
    try {
      // Parse the DateTime string as UTC by ensuring the string contains the "Z" suffix
      final dateTime = DateTime.parse(dbValue!);
      return dateTime.isUtc ? dateTime : dateTime.toUtc(); // Ensure UTC time
    } catch (e) {
      return DateTime.utc(
        1970,
        1,
        1,
      ); // Fallback to Unix epoch if parsing fails
    }
  }

  @override
  String toSql(DateTime? value) {
    if (value == null) {
      return DateTime.utc(1, 1, 1).toIso8601String();
    }
    return value
        .toUtc()
        .toIso8601String(); // Convert DateTime to ISO 8601 string
  }
}
