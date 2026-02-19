import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

/// A [TypeConverter] that maps Flutter [Color] objects to [int] values
/// for storage in SQLite via Drift.
///
/// The color is stored as a 32-bit integer representing the ARGB value.
///
/// ### Example Usage:
/// ```dart
/// IntColumn get color => integer().map(const ColorConverter())();
/// ```
class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  /// Converts the integer stored in the database back into a Flutter [Color].
  ///
  /// Expects the [fromDb] value to be a valid 32-bit ARGB integer.
  @override
  Color fromSql(int fromDb) {
    return Color(fromDb);
  }

  /// Converts a Flutter [Color] into an integer for database storage.
  ///
  /// Uses the [Color.toARGB32] property which returns the 32-bit ARGB representation.
  @override
  int toSql(Color value) {
    return value.toARGB32();
  }
}
