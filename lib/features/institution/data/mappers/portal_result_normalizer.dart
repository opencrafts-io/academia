/// Maps portal table headings into the existing institution and course import
/// shape. Recipes declare the mapping; the portal's row values remain on the
/// device and are never sent to the recipe service.
class PortalResultNormalizer {
  static const _allowedColumns = <String, Set<String>>{
    'courses': {'course_code', 'course_name', 'instructor'},
    'fees_fees_statements': {
      'reference_number',
      'balance',
      'debit',
      'credit',
      'posting_date',
      'description',
      'currency',
      'title',
    },
    'course_schedules': {
      'course_code',
      'start_date',
      'duration_minutes',
      'rrule',
      'location',
      'room',
      'building',
    },
  };

  static Map<String, dynamic> normalize({
    required Map<String, dynamic> raw,
    required Map<String, Map<String, String>> columnMappings,
    required int institutionId,
  }) {
    final output = <String, dynamic>{};
    for (final key in const ['student_id', 'student_name']) {
      final value = raw[key];
      if (value is String && value.trim().isNotEmpty) {
        output[key] = value.trim();
      }
    }

    for (final key in _allowedColumns.keys) {
      final rawRows = raw[key];
      if (rawRows == null) continue;
      if (rawRows is! List) {
        throw FormatException('$key is not a table.');
      }
      final allowed = _allowedColumns[key]!;
      final mapping = columnMappings[key] ?? const <String, String>{};
      final rows = <Map<String, dynamic>>[];
      for (final row in rawRows) {
        if (row is! Map) throw FormatException('$key contains an invalid row.');
        final mapped = <String, dynamic>{};
        for (final entry in row.entries) {
          if (entry.key is! String) continue;
          final target =
              mapping[entry.key] ??
              (allowed.contains(entry.key) ? entry.key : null);
          if (target == null || !allowed.contains(target)) continue;
          final value = entry.value;
          if (value is String && value.trim().isNotEmpty) {
            mapped[target] = value.trim();
          }
        }
        if (mapped.isNotEmpty) {
          if (key == 'fees_fees_statements') {
            mapped['institution'] = institutionId;
          }
          rows.add(mapped);
        }
      }
      output[key] = rows;
    }

    final courses = output['courses'];
    final schedules = output.remove('course_schedules');
    if (courses is List && schedules is List) {
      for (final course in courses.whereType<Map<String, dynamic>>()) {
        final code = course['course_code'];
        course['course_schedules'] = schedules
            .whereType<Map<String, dynamic>>()
            .where(
              (schedule) => code != null && schedule['course_code'] == code,
            )
            .map(
              (schedule) =>
                  Map<String, dynamic>.from(schedule)..remove('course_code'),
            )
            .toList();
      }
    }

    if (output.isEmpty) {
      throw const FormatException('Recipe found no supported student data.');
    }
    return output;
  }
}
