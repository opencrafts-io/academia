import 'package:flutter_test/flutter_test.dart';
import 'package:magnet/src/observer/portal_snapshot_sanitizer.dart';

void main() {
  group('PortalSnapshotSanitizer', () {
    test('removes query, fragments, and identifier-like path segments', () {
      final result = PortalSnapshotSanitizer.sanitize({
        'origin': 'https://portal.example.edu',
        'path': '/students/12345678/courses?token=secret#top',
        'title': '  My Courses  ',
        'language': 'en-GB',
        'nodes': <Object?>[],
      }, expectedOrigin: 'https://portal.example.edu');

      expect(result, isNotNull);
      expect(result!['path'], '/students/:id/courses');
      expect(result.containsKey('query'), isFalse);
      expect(result['title'], 'My Courses');
    });

    test('rejects origins outside the selected exact HTTPS allowlist', () {
      expect(
        PortalSnapshotSanitizer.sanitize({
          'origin': 'https://portal.example.edu.evil',
          'path': '/',
          'nodes': [],
        }, expectedOrigin: 'https://portal.example.edu'),
        isNull,
      );
    });

    test('rejects authentication pages and duplicate node identifiers', () {
      expect(
        PortalSnapshotSanitizer.sanitize({
          'origin': 'https://portal.example.edu',
          'path': '/account/sign-in',
          'title': 'Sign in',
          'nodes': <Object?>[],
        }, expectedOrigin: 'https://portal.example.edu'),
        isNull,
      );
      final snapshot = PortalSnapshotSanitizer.sanitize({
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'nodes': [
          {'id': 'n0', 'kind': 'heading', 'label': 'Courses'},
          {'id': 'n0', 'kind': 'heading', 'label': 'Forged duplicate'},
        ],
      }, expectedOrigin: 'https://portal.example.edu');
      expect(snapshot!['nodes'], [
        {'id': 'n0', 'kind': 'heading', 'label': 'Courses'},
      ]);
    });

    test('redacts identifiers from titles and rejects personal labels', () {
      final snapshot = PortalSnapshotSanitizer.sanitize({
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'title': 'Welcome ada@example.edu',
        'nodes': [
          {'id': 'n0', 'kind': 'link', 'label': 'Student ID 12345678'},
          {
            'id': 'n1',
            'kind': 'table',
            'label': 'Roster',
            'headers': ['Student Name'],
            'rows': [
              ['Ada Lovelace'],
            ],
          },
          {'id': 'n2', 'kind': 'heading', 'label': 'Courses'},
        ],
      }, expectedOrigin: 'https://portal.example.edu');

      expect(snapshot!['title'], '');
      final nodes = snapshot['nodes'] as List<Map<String, dynamic>>;
      expect(nodes, hasLength(1));
      expect(nodes.single['label'], 'Courses');
    });

    test(
      'keeps a table and trims its trailing rows to the payload ceiling',
      () {
        final headers = List<String>.generate(16, (index) => 'Column $index');
        final rows = List<List<String>>.generate(
          30,
          (row) => List<String>.generate(
            16,
            (column) => 'R$row-C$column ${'x' * 170}',
          ),
        );
        final snapshot = PortalSnapshotSanitizer.sanitize({
          'origin': 'https://portal.example.edu',
          'path': '/courses',
          'nodes': [
            {
              'id': 'n0',
              'kind': 'table',
              'label': 'Courses',
              'headers': headers,
              'rows': rows,
            },
          ],
        }, expectedOrigin: 'https://portal.example.edu');

        final nodes = snapshot!['nodes'] as List<Map<String, dynamic>>;
        expect(nodes, hasLength(1));
        final retainedRows = nodes.single['rows'] as List<List<String>>;
        expect(retainedRows, isNotEmpty);
        expect(retainedRows.length, lessThan(rows.length));
      },
    );

    test('drops fields and caps bounded node data', () {
      final result = PortalSnapshotSanitizer.sanitize({
        'origin': 'https://portal.example.edu',
        'path': '/',
        'title': 'T',
        'language': 'en',
        'nodes': [
          {
            'id': 'n0',
            'kind': 'field',
            'label': 'Password',
            'value': 'hunter2',
          },
          {
            'id': 'n1',
            'kind': 'field',
            'label': 'Course name',
            'value': 'Introduction to Computing',
          },
          {'id': 'n2', 'kind': 'script', 'value': 'ignored'},
        ],
      }, expectedOrigin: 'https://portal.example.edu');

      expect(result, isNotNull);
      final nodes = result!['nodes'] as List<Map<String, dynamic>>;
      expect(nodes, hasLength(1));
      expect(nodes.single['id'], 'n1');
      expect(nodes.single['value'], 'Introduction to Computing');
    });
  });
}
