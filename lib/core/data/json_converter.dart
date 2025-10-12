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

class JsonListConverter extends TypeConverter<List<dynamic>, String> {
  const JsonListConverter();

  @override
  List<dynamic> fromSql(String? dbValue) {
    if (dbValue?.isEmpty ?? true) {
      // Return empty map if the DB value is null or empty
      return [];
    }
    try {
      final decoded = jsonDecode(dbValue!);
      if (decoded is List<dynamic>) {
        return decoded;
      } else {
        // If it’s not a map (e.g., list or invalid JSON), fallback to {}
        return [];
      }
    } catch (e) {
      // On JSON parse error, fallback to {}
      return [];
    }
  }

  @override
  String toSql(List<dynamic>? value) {
    if (value == null || value.isEmpty) {
      // Store empty JSON object if null or empty
      return "[]";
    }
    try {
      return jsonEncode(value);
    } catch (e) {
      // On serialization error, store empty JSON
      return "[]";
    }
  }
}

/// Converter for List`<String>` <-> JSON string
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb);
    return (decoded as List).map((e) => e.toString()).toList();
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }

}

//TODO: Remove this
/// Converter for List`Map<String, dynamic>` 
class JsonMapListConverter extends TypeConverter<List<Map<String, dynamic>>, String> {
  const JsonMapListConverter();

  @override
  List<Map<String, dynamic>> fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) return [];

    try {
      final decoded = jsonDecode(fromDb);
      if (decoded is List) {
        return decoded
            .whereType<Map>() // ensure each is a Map
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  String toSql(List<Map<String, dynamic>>? value) {
    if (value == null || value.isEmpty) return "[]";

    try {
      return jsonEncode(value);
    } catch (e) {
      return "[]";
    }
  }
}

