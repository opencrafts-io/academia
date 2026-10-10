import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'portal_snapshot.dart';

enum PortalPageType { courses, timetable, profile, feeStatement, other }

enum PortalTableKind { courses, meetings, feeLineItems }

/// The bounded set of profile fields a page/field mapping may reference.
/// Mirrors `AcademicProfileFieldKey` in `package:institutions` by name so
/// the composition-root importer can map by name without this package
/// depending on that domain type. National identity, disability status and
/// any other field outside this list can never be produced by a plan,
/// because the schema only allows these enum values.
enum PortalProfileFieldKey {
  fullName,
  registrationNumber,
  programme,
  faculty,
  yearOfStudy,
  enrollmentStatus,
  institutionEmail,
  phoneNumber,
}

class PortalColumnMap {
  const PortalColumnMap({
    this.code,
    this.title,
    this.day,
    this.start,
    this.end,
    this.venue,
    this.term,
    this.date,
    this.description,
    this.debit,
    this.credit,
    this.balance,
    this.currency,
  });

  final int? code;
  final int? title;
  final int? day;
  final int? start;
  final int? end;
  final int? venue;
  final int? term;

  // Fee-statement columns. `balance` covers both a running balance and a
  // balance-due total; `PortalTablePlan.feeLineKind` on the row itself (via
  // extraction) distinguishes which, since a single table's "Balance"
  // column can carry either meaning depending on the row label.
  final int? date;
  final int? description;
  final int? debit;
  final int? credit;
  final int? balance;
  final int? currency;

  static const List<String> _keys = [
    'code',
    'title',
    'day',
    'start',
    'end',
    'venue',
    'term',
    'date',
    'description',
    'debit',
    'credit',
    'balance',
    'currency',
  ];

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
      date: read('date'),
      description: read('description'),
      debit: read('debit'),
      credit: read('credit'),
      balance: read('balance'),
      currency: read('currency'),
    );
  }

  Iterable<int> get indices sync* {
    for (final key in _keys) {
      final index = this[key];
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
    'date' => date,
    'description' => description,
    'debit' => debit,
    'credit' => credit,
    'balance' => balance,
    'currency' => currency,
    _ => null,
  };

  Map<String, Object?> toJson() => {
    for (final key in _keys) if (this[key] != null) key: this[key],
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

  Map<String, Object?> toJson() => {
    'nodeId': nodeId,
    'kind': kind.name,
    'columns': columns.toJson(),
  };
}

/// Maps one labelled `field` snapshot node (e.g. a profile dashboard's
/// "Registration No: 12345") to a single supported profile field.
class PortalFieldPlan {
  const PortalFieldPlan({required this.nodeId, required this.fieldKey});

  final String nodeId;
  final PortalProfileFieldKey fieldKey;

  factory PortalFieldPlan.fromJson(Map raw) {
    final nodeId = raw['nodeId'];
    final fieldKey = raw['fieldKey'];
    if (nodeId is! String || nodeId.isEmpty || nodeId.length > 128) {
      throw const FormatException('Invalid field mapping.');
    }
    return PortalFieldPlan(
      nodeId: nodeId,
      fieldKey: PortalProfileFieldKey.values.firstWhere(
        (value) => value.name == fieldKey,
        orElse: () => throw const FormatException('Invalid profile field key.'),
      ),
    );
  }

  Map<String, Object?> toJson() => {'nodeId': nodeId, 'fieldKey': fieldKey.name};
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
    this.fields = const [],
    this.hint,
  });

  // Schema version 2 adds the profile/fee_statement page categories, the
  // feeLineItems table kind, fee columns and field mappings. Bumping both
  // this and promptVersion invalidates stale cached plans rather than
  // reinterpreting them under the new, stricter contract.
  static const int schemaVersion = 2;
  static const String promptVersion = 'portal-structure-v3';
  final PortalPageType pageType;
  final List<PortalTablePlan> tables;
  final List<PortalFieldPlan> fields;
  final PortalNavigationHint? hint;

  factory PortalAnalysisPlan.fromJson(Map raw) {
    final pageType = raw['pageType'];
    final tables = raw['tables'] ?? const [];
    final fields = raw['fields'] ?? const [];
    final hint = raw['hint'];
    if (tables is! List ||
        tables.length > 32 ||
        fields is! List ||
        fields.length > 32 ||
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
      fields: List.unmodifiable(
        fields.map((field) {
          if (field is! Map) {
            throw const FormatException('Invalid field mapping.');
          }
          return PortalFieldPlan.fromJson(field);
        }),
      ),
      hint: hint == null ? null : PortalNavigationHint.fromJson(hint as Map),
    );
  }

  Map<String, Object?> toJson() => {
    'pageType': pageType.name,
    'tables': tables.map((table) => table.toJson()).toList(),
    'fields': fields.map((field) => field.toJson()).toList(),
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

  // A fee table must look like one on its own terms; a page merely titled
  // "fees" or "profile" does not make a generic table a fee table. This is
  // what keeps a generic fee/profile table failing validation while an
  // explicit fee-statement table still maps successfully.
  static final _feeTable = RegExp(
    r'\b(fees?|invoice|statement|tuition|charges?|debit|credit|balance|paid|payment|receipt)\b',
    caseSensitive: false,
  );

  bool validateFor(PortalSnapshot snapshot) =>
      validationFailureFor(snapshot) == null;

  /// Safe diagnostic codes and dimensions only; never page text or model IDs.
  String? validationFailureFor(PortalSnapshot snapshot) {
    final nodes = {for (final node in snapshot.nodes) node.id: node};
    if (pageType == PortalPageType.other &&
        (tables.isNotEmpty || fields.isNotEmpty)) {
      return 'page_type_mismatch';
    }
    // An empty mapping is valid on an unsupported page: continue browsing.
    if ((tables.isNotEmpty || fields.isNotEmpty) &&
        _neverWeeklyPage.hasMatch('${snapshot.path} ${snapshot.title}')) {
      return 'unsupported_page_context';
    }
    final usedTables = <String>{};
    for (var tableIndex = 0; tableIndex < tables.length; tableIndex++) {
      final table = tables[tableIndex];
      final node = nodes[table.nodeId];
      if (node == null) return 'unknown_table_node table=$tableIndex';
      if (node.kind != 'table') return 'non_table_node table=$tableIndex';
      if (!usedTables.add('${table.nodeId}|${table.kind.name}')) {
        return 'duplicate_table_node table=$tableIndex';
      }
      final tableContext = '${node.label} ${node.headers.join(' ')}';
      final columns = table.columns;
      if (table.kind == PortalTableKind.feeLineItems) {
        if (!_feeTable.hasMatch(tableContext)) {
          return 'missing_fee_context table=$tableIndex';
        }
        if (columns.description == null ||
            (columns.debit == null &&
                columns.credit == null &&
                columns.balance == null)) {
          return 'missing_fee_columns table=$tableIndex';
        }
      } else {
        // Courses/meetings tables must not be a generic table that merely
        // happens to sit on (or mention) a fee/payment/profile page.
        if (_unsupportedPage.hasMatch('${snapshot.path} ${snapshot.title}') &&
            !_academicTable.hasMatch(tableContext)) {
          return 'unsupported_page_context table=$tableIndex';
        }
        if (_unsupportedPage.hasMatch(tableContext)) {
          return 'unsupported_table_context table=$tableIndex';
        }
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
      }
      for (final index in columns.indices) {
        if (index < 0 || index > 63 || index >= node.headers.length) {
          return 'column_out_of_bounds table=$tableIndex column=$index headers=${node.headers.length}';
        }
      }
    }
    final usedFieldNodes = <String>{};
    final usedFieldKeys = <String>{};
    for (var fieldIndex = 0; fieldIndex < fields.length; fieldIndex++) {
      final field = fields[fieldIndex];
      final node = nodes[field.nodeId];
      if (node == null) return 'unknown_field_node field=$fieldIndex';
      if (node.kind != 'field') return 'non_field_node field=$fieldIndex';
      if (!usedFieldNodes.add(field.nodeId)) {
        return 'duplicate_field_node field=$fieldIndex';
      }
      if (!usedFieldKeys.add(field.fieldKey.name)) {
        return 'duplicate_field_key field=$fieldIndex';
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

  /// Retain individually validated tables/fields; an optional hint cannot
  /// block data. Unusable mappings never reach extraction or the cache.
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
        fields: const [],
        hint: safeHint,
      );
    }
    final retainedTables = <PortalTablePlan>[];
    final usedTables = <String>{};
    for (final table in tables) {
      final candidate = PortalAnalysisPlan(pageType: pageType, tables: [table]);
      if (candidate.validateFor(snapshot) &&
          usedTables.add('${table.nodeId}|${table.kind.name}')) {
        retainedTables.add(table);
      }
    }
    final retainedFields = <PortalFieldPlan>[];
    final usedFieldKeys = <String>{};
    for (final field in fields) {
      final candidate = PortalAnalysisPlan(
        pageType: pageType,
        tables: const [],
        fields: [field],
      );
      if (candidate.validateFor(snapshot) &&
          usedFieldKeys.add(field.fieldKey.name)) {
        retainedFields.add(field);
      }
    }
    return PortalAnalysisPlan(
      pageType: pageType,
      tables: List.unmodifiable(retainedTables),
      fields: List.unmodifiable(retainedFields),
      hint: safeHint,
    );
  }

  String get cacheJson => jsonEncode(toJson());

  String planHash() => sha256.convert(utf8.encode(cacheJson)).toString();
}
