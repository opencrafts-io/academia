import 'dart:convert';
import 'package:drift/drift.dart';

class JsonConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonConverter();

  @override
  Map<String, dynamic> fromSql(String? dbValue) {
    if (dbValue?.isEmpty ?? true) {
      // Return empty map if the DB value is null or empty
      return {};
    }
    try {
      final decoded = jsonDecode(dbValue!);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        // If it’s not a map (e.g., list or invalid JSON), fallback to {}
        return {};
      }
    } catch (e) {
      // On JSON parse error, fallback to {}
      return {};
    }
  }

  @override
  String toSql(Map<String, dynamic>? value) {
    if (value == null || value.isEmpty) {
      // Store empty JSON object if null or empty
      return "{}";
    }
    try {
      return jsonEncode(value);
    } catch (e) {
      // On serialization error, store empty JSON
      return "{}";
    }
  }
}
