import 'dart:convert';

/// Applies a conservative schema and size policy to data crossing the page bridge.
class PortalSnapshotSanitizer {
  PortalSnapshotSanitizer._();

  static const int maxTitleLength = 160;
  static const int maxLabelLength = 120;
  static const int maxCellLength = 180;
  static const int maxNodes = 80;
  static const int maxRows = 60;
  static const int maxColumns = 16;
  static const int maxSnapshotCharacters = 24000;

  static const Set<String> _kinds = {'table', 'heading', 'link', 'field'};
  static final RegExp _identifierSegment = RegExp(
    r'^(?:\d{5,}|[0-9a-f]{8}-[0-9a-f-]{27,}|(?=[A-Z0-9]{8,}$)(?=.*\d)[A-Z0-9]+)$',
    caseSensitive: false,
  );
  static final RegExp _sensitiveLabel = RegExp(
    r'password|passcode|secret|token|csrf|session|student\s*(?:id|number|no\.?|email|name)|full\s*name|profile|account|welcome|hello|registration\s*(?:id|number)|matric(?:ulation)?\s*(?:id|number)|national\s*(?:id|identity)|email|phone|mobile',
    caseSensitive: false,
  );
  static final RegExp _sensitiveHeader = RegExp(
    r'^(?:name|first\s*name|last\s*name|full\s*name)$',
    caseSensitive: false,
  );
  static final RegExp _sensitiveValue = RegExp(
    r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b|\b\d{6,}\b|\b[A-Z]{1,3}[-/]?\d{5,}\b',
    caseSensitive: false,
  );

  /// Returns only the supported, bounded snapshot schema, or null when invalid.
  static Map<String, dynamic>? sanitize(
    Object? value, {
    required String expectedOrigin,
  }) {
    if (value is! Map) return null;
    final origin = normalizeHttpsOrigin(value['origin']);
    final expected = normalizeHttpsOrigin(expectedOrigin);
    if (origin == null || expected == null || origin != expected) return null;
    if (_isAuthenticationPage(value['path'], value['title'])) return null;

    final nodes = <Map<String, dynamic>>[];
    final seenNodeIds = <String>{};
    final rawNodes = value['nodes'];
    if (rawNodes is List) {
      for (final raw in rawNodes.take(maxNodes)) {
        final node = _sanitizeNode(raw);
        if (node != null && seenNodeIds.add(node['id'] as String)) {
          nodes.add(node);
        }
      }
    }
    final title = _text(value['title'], maxTitleLength);
    final result = <String, dynamic>{
      'origin': origin,
      'path': _sanitizePath(value['path']),
      'title':
          _sensitiveLabel.hasMatch(title) || _sensitiveValue.hasMatch(title)
          ? ''
          : title,
      'language': _language(value['language']),
      'nodes': nodes,
    };
    while (_jsonLength(result) > maxSnapshotCharacters && nodes.isNotEmpty) {
      Map<String, dynamic>? oversizedTable;
      for (final node in nodes.reversed) {
        if (node['kind'] == 'table' && (node['rows'] as List).isNotEmpty) {
          oversizedTable = node;
          break;
        }
      }
      if (oversizedTable != null) {
        (oversizedTable['rows'] as List).removeLast();
      } else {
        nodes.removeLast();
      }
    }
    return result;
  }

  /// Distinguishes lost table rows from deliberate privacy exclusions.
  static bool hasTrimmedTableRows(Object? raw, Map<String, dynamic> snapshot) {
    if (raw is! Map || raw['nodes'] is! List) return false;
    final retainedRows = <String, int>{};
    for (final node in (snapshot['nodes'] as List).whereType<Map>()) {
      if (node['kind'] == 'table' && node['id'] is String) {
        retainedRows[node['id'] as String] = (node['rows'] as List).length;
      }
    }
    final seen = <String>{};
    for (final node in (raw['nodes'] as List).whereType<Map>()) {
      if (node['kind'] != 'table' ||
          node['id'] is! String ||
          node['rows'] is! List) {
        continue;
      }
      final id = node['id'] as String;
      if (!seen.add(id) || _sanitizeNode(node) == null) continue;
      if ((node['rows'] as List).whereType<List>().length >
          (retainedRows[id] ?? 0)) {
        return true;
      }
    }
    return false;
  }

  static Map<String, dynamic>? _sanitizeNode(Object? value) {
    if (value is! Map) return null;
    final id = value['id'];
    final kind = value['kind'];
    if (id is! String || !RegExp(r'^n\d{1,3}$').hasMatch(id)) return null;
    if (kind is! String || !_kinds.contains(kind)) return null;
    final label = _text(value['label'], maxLabelLength);
    if (label.isEmpty ||
        _sensitiveLabel.hasMatch(label) ||
        _sensitiveValue.hasMatch(label)) {
      return null;
    }

    switch (kind) {
      case 'table':
        final rawHeaders = value['headers'];
        final rawRows = value['rows'];
        if (rawHeaders is! List || rawRows is! List) return null;
        final headers = rawHeaders
            .take(maxColumns)
            .map((item) => _text(item, maxCellLength))
            .toList();
        if (headers.isEmpty ||
            headers.any(
              (item) =>
                  item.isEmpty ||
                  _sensitiveLabel.hasMatch(item) ||
                  _sensitiveHeader.hasMatch(item) ||
                  _sensitiveValue.hasMatch(item),
            )) {
          return null;
        }
        final rows = <List<String>>[];
        for (final row in rawRows.take(maxRows)) {
          if (row is! List) continue;
          rows.add(
            List<String>.generate(headers.length, (index) {
              final cell = index < row.length
                  ? _text(row[index], maxCellLength)
                  : '';
              return _sensitiveValue.hasMatch(cell) ? '' : cell;
            }),
          );
        }
        return {
          'id': id,
          'kind': kind,
          'label': label,
          'headers': headers,
          'rows': rows,
        };
      case 'field':
        final fieldValue = _text(value['value'], maxCellLength);
        if (_sensitiveValue.hasMatch(fieldValue)) return null;
        return {'id': id, 'kind': kind, 'label': label, 'value': fieldValue};
      case 'heading':
      case 'link':
        return {'id': id, 'kind': kind, 'label': label};
    }
    return null;
  }

  static String? normalizeHttpsOrigin(Object? value) {
    if (value is! String) return null;
    final uri = Uri.tryParse(value);
    if (uri == null ||
        uri.scheme.toLowerCase() != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        (uri.path.isNotEmpty && uri.path != '/') ||
        uri.hasQuery ||
        uri.hasFragment) {
      return null;
    }
    final port = uri.hasPort && uri.port != 443 ? ':${uri.port}' : '';
    return 'https://${uri.host.toLowerCase()}$port';
  }

  static String _sanitizePath(Object? value) {
    if (value is! String || !value.startsWith('/')) return '/';
    final pathOnly = Uri.tryParse(value)?.path ?? '/';
    final rawSegments = pathOnly.split('/').skip(1);
    final segments = rawSegments.take(18).map((segment) {
      String decoded;
      try {
        decoded = Uri.decodeComponent(segment);
      } on FormatException {
        return '';
      }
      if (_identifierSegment.hasMatch(decoded) || decoded.length > 80) {
        return ':id';
      }
      return decoded.replaceAll(RegExp(r'[^a-zA-Z0-9._~-]'), '');
    });
    final path = '/${segments.join('/')}';
    return path.substring(0, path.length.clamp(0, 240));
  }

  static String _text(Object? value, int maxLength) {
    if (value is! String) return '';
    final normalized = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    return normalized.substring(0, normalized.length.clamp(0, maxLength));
  }

  static String _language(Object? value) {
    if (value is! String ||
        !RegExp(r'^[a-zA-Z]{2,8}(?:-[a-zA-Z0-9]{1,8})*$').hasMatch(value)) {
      return 'und';
    }
    return value.substring(0, value.length.clamp(0, 24));
  }

  static bool _isAuthenticationPage(Object? path, Object? title) {
    final text = '${path ?? ''} ${title ?? ''}'.toLowerCase();
    return RegExp(
      r'(^|[/\s_-])(login|log-in|signin|sign-in|oauth|authorize|authentication)([/\s_?&#-]|$)',
    ).hasMatch(text);
  }

  static int _jsonLength(Object value) => jsonEncode(value).length;
}
