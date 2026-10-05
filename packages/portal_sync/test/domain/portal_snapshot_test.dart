import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_snapshot.dart';

void main() {
  test('accepts a blank title after browser privacy redaction', () {
    final snapshot = PortalSnapshot.fromJson({
      'origin': 'https://portal.example.edu',
      'path': '/courses',
      'title': '',
      'language': 'en',
      'nodes': [],
    });
    expect(snapshot.title, isEmpty);
    expect(snapshot.toAnalysisJson()['titleKeywords'], isEmpty);
  });

  test(
    'analysis payload contains structure and omits current student values',
    () {
      final snapshot = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/student/courses',
        'title': 'My courses',
        'language': 'en',
        'nodes': [
          {
            'id': 'n0',
            'kind': 'table',
            'label': 'Registered courses',
            'headers': ['Code', 'Course title'],
            'rows': [
              ['CS 101', 'Algorithms'],
              ['MATH 2', 'Student private value'],
            ],
          },
        ],
      });

      final prompt = snapshot.toAnalysisJson();
      final encoded = prompt.toString();
      expect(encoded, contains('Registered courses'));
      expect(encoded, contains('Code'));
      expect(encoded, isNot(contains('Algorithms')));
      expect(encoded, isNot(contains('Student private value')));
    },
  );

  test('rejects non HTTPS origins and oversized snapshots', () {
    expect(
      () => PortalSnapshot.fromJson({
        'origin': 'http://portal.example.edu',
        'path': '/',
        'title': 'Courses',
        'language': 'en',
        'nodes': [],
      }),
      throwsFormatException,
    );
  });
}
