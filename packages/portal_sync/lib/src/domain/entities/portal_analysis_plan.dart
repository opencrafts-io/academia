import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'portal_snapshot.dart';

enum PortalPageType { courses, timetable, other }

enum PortalTableKind { courses, meetings }

class PortalColumnMap {
  const PortalColumnMap({
    this.code,
    this.title,
    this.day,
    this.start,
    this.end,
    this.venue,
    this.term,
  });

  final int? code;
  final int? title;
  final int? day;
  final int? start;
  final int? end;
  final int? venue;
  final int? term;

  factory PortalColumnMap.fromJson(Map raw) {
    int? read(String key) {
      final value = raw[key];
      if (value == null) return null;
      if (value is! int || value < 0 || value > 63) {
        throw const FormatException('Invalid column index.');
      }
      return value;
    }

    return PortalColumnMap(
      code: read('code'),
      title: read('title'),
      day: read('day'),
      start: read('start'),
      end: read('end'),
      venue: read('venue'),
      term: read('term'),
    );
  }

  Iterable<int> get indices sync* {
    for (final index in [code, title, day, start, end, venue, term]) {
      if (index != null) yield index;
    }
  }

  int? operator [](String key) => switch (key) {
    'code' => code,
    'title' => title,
    'day' => day,
    'start' => start,
    'end' => end,
    'venue' => venue,
    'term' => term,
    _ => null,
  };
}

class PortalTablePlan {
  const PortalTablePlan({
    required this.nodeId,
    required this.kind,
    required this.columns,
  });

  final String nodeId;
  final PortalTableKind kind;
  final PortalColumnMap columns;

  factory PortalTablePlan.fromJson(Map raw) {
    final nodeId = raw['nodeId'];
    final kind = raw['kind'];
    final columns = raw['columns'];
    if (nodeId is! String ||
        nodeId.isEmpty ||
        nodeId.length > 128 ||
        columns is! Map) {
      throw const FormatException('Invalid table mapping.');
    }
    return PortalTablePlan(
      nodeId: nodeId,
      kind: PortalTableKind.values.firstWhere(
        (value) => value.name == kind,
        orElse: () => throw const FormatException('Invalid table kind.'),
      ),
      columns: PortalColumnMap.fromJson(columns),
    );
  }
}

class PortalNavigationHint {
  const PortalNavigationHint({required this.nodeId, required this.label});
  final String nodeId;
  final String label;

  factory PortalNavigationHint.fromJson(Map raw) {
    final nodeId = raw['nodeId'];
    final label = raw['label'];
    if (nodeId is! String ||
        nodeId.isEmpty ||
        nodeId.length > 128 ||
        label is! String ||
        label.trim().isEmpty ||
        label.length > 256) {
      throw const FormatException('Invalid navigation hint.');
    }
    return PortalNavigationHint(nodeId: nodeId, label: label.trim());
  }
}

class PortalAnalysisPlan {
  const PortalAnalysisPlan({
    required this.pageType,
    required this.tables,
    this.hint,
  });

  static const int schemaVersion = 1;
  static const String promptVersion = 'portal-structure-v2';
  final PortalPageType pageType;
  final List<PortalTablePlan> tables;
  final PortalNavigationHint? hint;

  factory PortalAnalysisPlan.fromJson(Map raw) {
    final pageType = raw['pageType'];
    final tables = raw['tables'] ?? const [];
    final hint = raw['hint'];
    if (tables is! List ||
        tables.length > 32 ||
        (hint != null && hint is! Map)) {
      throw const FormatException('Invalid portal analysis response.');
    }
    return PortalAnalysisPlan(
      pageType: PortalPageType.values.firstWhere(
        (value) => value.name == pageType,
        orElse: () => throw const FormatException('Invalid page type.'),
      ),
      tables: List.unmodifiable(
        tables.map((table) {
          if (table is! Map) {
            throw const FormatException('Invalid table mapping.');
          }
          return PortalTablePlan.fromJson(table);
        }),
      ),
      hint: hint == null ? null : PortalNavigationHint.fromJson(hint as Map),
    );
  }

  Map<String, Object?> toJson() => {
    'pageType': pageType.name,
    'tables': tables
        .map(
          (table) => {
            'nodeId': table.nodeId,
            'kind': table.kind.name,
            'columns': {
              for (final key in [
                'code',
                'title',
                'day',
                'start',
                'end',
                'venue',
                'term',
              ])
                if (table.columns[key] != null) key: table.columns[key],
            },
          },
        )
        .toList(),
    if (hint != null) 'hint': {'nodeId': hint!.nodeId, 'label': hint!.label},
  };

  static final _unsupportedPage = RegExp(
    r'\b(exams?|assessments?|deadlines?|events?|holidays?|fees?|payments?|profiles?)\b',
    caseSensitive: false,
  );

  static final _neverWeeklyPage = RegExp(
    r'\b(exams?|assessments?|deadlines?|events?|holidays?)\b',
    caseSensitive: false,
  );
  static final _academicTable = RegExp(
    r'\b(courses?|subjects?|units?|modules?|classes?|lectures?)\b',
    caseSensitive: false,
  );

  bool validateFor(PortalSnapshot snapshot) =>
      validationFailureFor(snapshot) == null;

  /// Safe diagnostic codes and dimensions only; never page text or model IDs.
  String? validationFailureFor(PortalSnapshot snapshot) {
    final nodes = {for (final node in snapshot.nodes) node.id: node};
    if (pageType == PortalPageType.other && tables.isNotEmpty) {
      return 'page_type_mismatch';
    }
    // An empty mapping is valid on an unsupported page: continue browsing.
    if (tables.isNotEmpty &&
        _neverWeeklyPage.hasMatch('${snapshot.path} ${snapshot.title}')) {
      return 'unsupported_page_context';
    }
    final used = <String>{};
    for (var tableIndex = 0; tableIndex < tables.length; tableIndex++) {
      final table = tables[tableIndex];
      final node = nodes[table.nodeId];
      if (node == null) return 'unknown_table_node table=$tableIndex';
      if (node.kind != 'table') return 'non_table_node table=$tableIndex';
      if (!used.add('${table.nodeId}|${table.kind.name}')) {
        return 'duplicate_table_node table=$tableIndex';
      }
      final tableContext = '${node.label} ${node.headers.join(' ')}';
      if (_unsupportedPage.hasMatch('${snapshot.path} ${snapshot.title}') &&
          !_academicTable.hasMatch(tableContext)) {
        return 'unsupported_page_context table=$tableIndex';
      }
      if (_unsupportedPage.hasMatch(tableContext)) {
        return 'unsupported_table_context table=$tableIndex';
      }
      final columns = table.columns;
      if (table.kind == PortalTableKind.courses &&
          (columns.code == null || columns.title == null)) {
        return 'missing_course_columns table=$tableIndex';
      }
      if (table.kind == PortalTableKind.meetings &&
          (columns.code == null ||
              columns.day == null ||
              columns.start == null ||
              columns.end == null)) {
        return 'missing_meeting_columns table=$tableIndex';
      }
      if (table.kind == PortalTableKind.meetings &&
          RegExp(
            r'\b(weeks?|odd|even|recurrence|repeat|frequency|cycle|date|time\s*zone|timezone|utc)\b',
            caseSensitive: false,
          ).hasMatch(node.headers.join(' '))) {
        return 'unsupported_recurrence table=$tableIndex';
      }
      for (final index in columns.indices) {
        if (index < 0 || index > 63 || index >= node.headers.length) {
          return 'column_out_of_bounds table=$tableIndex column=$index headers=${node.headers.length}';
        }
      }
    }
    if (hint != null && !nodes.containsKey(hint!.nodeId)) {
      return 'unknown_hint_node';
    }
    if (hint != null && hint!.label.trim().isEmpty) {
      return 'empty_hint_label';
    }
    return null;
  }

  /// Retain individually validated tables; an optional hint cannot block data.
  /// Unusable mappings never reach extraction or the cache.
  PortalAnalysisPlan supportedSubsetFor(PortalSnapshot snapshot) {
    final nodes = {for (final node in snapshot.nodes) node.id: node};
    final safeHint =
        hint != null &&
            nodes.containsKey(hint!.nodeId) &&
            hint!.label.trim().isNotEmpty
        ? hint
        : null;
    if (pageType == PortalPageType.other ||
        _neverWeeklyPage.hasMatch('${snapshot.path} ${snapshot.title}')) {
      return PortalAnalysisPlan(
        pageType: PortalPageType.other,
        tables: const [],
        hint: safeHint,
      );
    }
    final retained = <PortalTablePlan>[];
    final used = <String>{};
    for (final table in tables) {
      final candidate = PortalAnalysisPlan(pageType: pageType, tables: [table]);
      if (candidate.validateFor(snapshot) &&
          used.add('${table.nodeId}|${table.kind.name}')) {
        retained.add(table);
      }
    }
    return PortalAnalysisPlan(
      pageType: pageType,
      tables: List.unmodifiable(retained),
      hint: safeHint,
    );
  }

  String get cacheJson => jsonEncode(toJson());

  String planHash() => sha256.convert(utf8.encode(cacheJson)).toString();
}
