import 'dart:convert';

import 'package:crypto/crypto.dart';

const int maxSnapshotBytes = 256 * 1024;

class PortalSnapshotNode {
  const PortalSnapshotNode({
    required this.id,
    required this.kind,
    required this.label,
    required this.headers,
    required this.rows,
    this.value,
  });

  final String id;
  final String kind;
  final String label;
  final List<String> headers;
  final List<List<String>> rows;
  final String? value;

  Map<String, Object?> toAnalysisJson() => {
    'id': id,
    'kind': kind,
    'label': label,
    'headers': headers,
    // Only coarse types are sent. Cell text stays on the device.
    'rowTypes': rows.take(3).map((row) => row.map(_typeOf).toList()).toList(),
    if (value != null) 'valueType': _typeOf(value!),
  };

  Map<String, Object?> toJson() => {
    'id': id,
    'kind': kind,
    'label': label,
    'headers': headers,
    'rows': rows,
    if (value != null) 'value': value,
  };

  static String _typeOf(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return 'empty';
    if (RegExp(
      r'^\d{1,2}:\d{2}(?:\s*[AP]M)?$',
      caseSensitive: false,
    ).hasMatch(normalized)) {
      return 'time';
    }
    if (RegExp(r'^\d{1,2}[/-]\d{1,2}(?:[/-]\d{2,4})?$').hasMatch(normalized)) {
      return 'date';
    }
    if (double.tryParse(normalized.replaceAll(',', '')) != null) {
      return 'number';
    }
    return 'text';
  }
}

class PortalSnapshot {
  PortalSnapshot._({
    required this.origin,
    required this.path,
    required this.title,
    required this.language,
    required this.nodes,
  });

  factory PortalSnapshot.fromJson(Map raw) {
    final json = Map<String, dynamic>.from(raw);
    if (utf8.encode(jsonEncode(json)).length > maxSnapshotBytes) {
      throw const FormatException('Portal snapshot exceeds the size limit.');
    }
    final origin = _requiredText(json, 'origin', 2048);
    final uri = Uri.tryParse(origin);
    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty ||
        uri.path != '/' && uri.path.isNotEmpty ||
        uri.query.isNotEmpty ||
        uri.fragment.isNotEmpty) {
      throw const FormatException(
        'Portal snapshot origin must be an HTTPS origin.',
      );
    }
    final path = _requiredText(json, 'path', 4096);
    if (!path.startsWith('/') || path.contains('://')) {
      throw const FormatException('Invalid portal path.');
    }
    final rawNodes = json['nodes'];
    if (rawNodes is! List || rawNodes.length > 150) {
      throw const FormatException('Invalid portal nodes.');
    }
    final ids = <String>{};
    final nodes = <PortalSnapshotNode>[];
    const allowedKinds = {'table', 'heading', 'link', 'field'};
    for (final rawNode in rawNodes) {
      if (rawNode is! Map) throw const FormatException('Invalid portal node.');
      final node = Map<String, dynamic>.from(rawNode);
      final id = _requiredText(node, 'id', 128);
      final kind = _requiredText(node, 'kind', 32);
      if (!ids.add(id) || !allowedKinds.contains(kind)) {
        throw const FormatException('Invalid portal node identity or kind.');
      }
      final headers = _stringList(node['headers'], 64, 256);
      final rawRows = node['rows'] ?? const [];
      if (rawRows is! List || rawRows.length > 500) {
        throw const FormatException('Invalid portal table rows.');
      }
      final rows = <List<String>>[];
      for (final row in rawRows) {
        if (row is! List || row.length > 64) {
          throw const FormatException('Invalid portal table row.');
        }
        rows.add(
          row.map((value) => _text(value, 2048)).toList(growable: false),
        );
      }
      final rawValue = node['value'];
      nodes.add(
        PortalSnapshotNode(
          id: id,
          kind: kind,
          label: _requiredText(node, 'label', 512),
          headers: headers,
          rows: rows,
          value: rawValue == null ? null : _text(rawValue, 2048),
        ),
      );
    }
    return PortalSnapshot._(
      origin: _origin(uri),
      path: path,
      title: _text(json['title'], 512),
      language: _requiredText(json, 'language', 64),
      nodes: List.unmodifiable(nodes),
    );
  }

  final String origin;
  final String path;
  final String title;
  final String language;
  final List<PortalSnapshotNode> nodes;

  String get structuralFingerprint => sha256
      .convert(
        utf8.encode(
          jsonEncode({
            'path': _pathShape(path),
            'titleKeywords': _safeTitleKeywords(title),
            'language': language,
            'nodes': nodes
                .map(
                  (n) => {
                    'id': n.id,
                    'kind': n.kind,
                    'label': n.label,
                    'headers': n.headers,
                    'widths': n.rows.map((row) => row.length).toSet().toList()
                      ..sort(),
                  },
                )
                .toList(),
          }),
        ),
      )
      .toString();

  Map<String, Object?> toAnalysisJson() => {
    'origin': origin,
    'path': _pathShape(path),
    'titleKeywords': _safeTitleKeywords(title),
    'language': language,
    'nodes': nodes.map((node) => node.toAnalysisJson()).toList(),
  };

  static List<String> _safeTitleKeywords(String value) {
    const allowed = {
      'course',
      'courses',
      'class',
      'classes',
      'timetable',
      'schedule',
      'academic',
      'registered',
      'registration',
      'enrollment',
      'calendar',
      'portal',
      'student',
      'lecture',
      'lectures',
    };
    return value
        .toLowerCase()
        .split(RegExp(r'[^a-z]+'))
        .where(allowed.contains)
        .toSet()
        .toList()
      ..sort();
  }

  static String _pathShape(String path) =>
      path.split('/').map((part) => part.isEmpty ? '' : ':segment').join('/');

  static String _origin(Uri uri) =>
      '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';

  static String _requiredText(
    Map<String, dynamic> data,
    String key,
    int maxLength,
  ) {
    final value = data[key];
    if (value is! String || value.trim().isEmpty || value.length > maxLength) {
      throw FormatException('Invalid portal snapshot $key.');
    }
    return value.trim();
  }

  static String _text(Object? value, int maxLength) {
    if (value is! String || value.length > maxLength) {
      throw const FormatException('Invalid portal text value.');
    }
    return value;
  }

  static List<String> _stringList(Object? value, int maxItems, int maxLength) {
    if (value == null) return const [];
    if (value is! List || value.length > maxItems) {
      throw const FormatException('Invalid portal headers.');
    }
    return List.unmodifiable(value.map((item) => _text(item, maxLength)));
  }
}
