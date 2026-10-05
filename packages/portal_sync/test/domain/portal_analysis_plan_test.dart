import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_snapshot.dart';

void main() {
  final snapshot = PortalSnapshot.fromJson({
    'origin': 'https://portal.example.edu',
    'path': '/courses',
    'title': 'Courses',
    'language': 'en',
    'nodes': [
      {
        'id': 'n0',
        'kind': 'table',
        'label': 'Courses',
        'headers': ['Code', 'Title', 'Day', 'Start', 'End'],
        'rows': [
          ['CS 101', 'Algorithms', 'Monday', '09:00', '10:00'],
        ],
      },
    ],
  });

  test('parses a schema constrained analysis plan', () {
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'courses',
      'tables': [
        {
          'nodeId': 'n0',
          'kind': 'meetings',
          'columns': {'code': 0, 'title': 1, 'day': 2, 'start': 3, 'end': 4},
        },
      ],
      'hint': {'nodeId': 'n0', 'label': 'Courses'},
    });
    expect(plan.validateFor(snapshot), isTrue);
  });

  test('rejects unknown node references and out of bounds columns', () {
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'courses',
      'tables': [
        {
          'nodeId': 'other',
          'kind': 'meetings',
          'columns': {'code': 0, 'day': 8, 'start': 3, 'end': 4},
        },
      ],
    });
    expect(plan.validateFor(snapshot), isFalse);
  });

  test('an unsupported page with no mappings is a valid observation', () {
    final fees = PortalSnapshot.fromJson({
      ...snapshot.toAnalysisJson(),
      'path': '/fees',
      'title': 'Fees',
      'nodes': snapshot.nodes.map((node) => node.toJson()).toList(),
    });
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'other',
      'tables': [],
    });
    expect(plan.validateFor(fees), isTrue);
  });

  test('summary rows do not invalidate a table with valid course rows', () {
    final mixed = PortalSnapshot.fromJson({
      ...snapshot.toAnalysisJson(),
      'path': '/courses',
      'title': 'Courses',
      'nodes': [
        {
          ...snapshot.nodes.single.toJson(),
          'rows': [
            ['CS101', 'Algorithms', 'Monday', '09:00', '10:00'],
            ['Total credits: 3'],
          ],
        },
      ],
    });
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'courses',
      'tables': [
        {
          'nodeId': 'n0',
          'kind': 'courses',
          'columns': {'code': 0, 'title': 1},
        },
      ],
    });
    expect(plan.validateFor(mixed), isTrue);
  });

  test('the same table may map both courses and their weekly meetings', () {
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'timetable',
      'tables': [
        {
          'nodeId': 'n0',
          'kind': 'courses',
          'columns': {'code': 0, 'title': 1},
        },
        {
          'nodeId': 'n0',
          'kind': 'meetings',
          'columns': {'code': 0, 'day': 2, 'start': 3, 'end': 4},
        },
      ],
    });
    expect(plan.validateFor(snapshot), isTrue);
  });

  test('duplicate mappings of the same kind are still rejected', () {
    final table = {
      'nodeId': 'n0',
      'kind': 'courses',
      'columns': {'code': 0, 'title': 1},
    };
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'courses',
      'tables': [table, table],
    });
    expect(plan.validateFor(snapshot), isFalse);
    expect(plan.supportedSubsetFor(snapshot).tables, hasLength(1));
  });

  test(
    'a profile dashboard title does not block its explicit course table',
    () {
      final dashboard = PortalSnapshot.fromJson({
        ...snapshot.toAnalysisJson(),
        'path': '/student/profile',
        'title': 'Student profile',
        'nodes': snapshot.nodes.map((node) => node.toJson()).toList(),
      });
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'courses',
        'tables': [
          {
            'nodeId': 'n0',
            'kind': 'courses',
            'columns': {'code': 0, 'title': 1},
          },
        ],
      });
      expect(plan.validateFor(dashboard), isTrue);
    },
  );

  test('generic payment table on a fee page is never treated as courses', () {
    final fees = PortalSnapshot.fromJson({
      ...snapshot.toAnalysisJson(),
      'path': '/fees',
      'title': 'Fees',
      'nodes': [
        {
          ...snapshot.nodes.single.toJson(),
          'label': 'Details',
          'headers': ['Code', 'Title'],
        },
      ],
    });
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'courses',
      'tables': [
        {
          'nodeId': 'n0',
          'kind': 'courses',
          'columns': {'code': 0, 'title': 1},
        },
      ],
    });
    expect(plan.validateFor(fees), isFalse);
    expect(plan.supportedSubsetFor(fees).tables, isEmpty);
  });

  test('rejects dated or alternating meeting patterns', () {
    final dated = PortalSnapshot.fromJson({
      'origin': 'https://portal.example.edu',
      'path': '/timetable',
      'title': 'Timetable',
      'language': 'en',
      'nodes': [
        {
          'id': 'dated',
          'kind': 'table',
          'label': 'Weekly timetable',
          'headers': ['Code', 'Day', 'Start', 'End', 'Week'],
          'rows': [
            ['CS101', 'Monday', '09:00', '10:00', 'Odd'],
          ],
        },
      ],
    });
    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'timetable',
      'tables': [
        {
          'nodeId': 'dated',
          'kind': 'meetings',
          'columns': {'code': 0, 'day': 1, 'start': 2, 'end': 3},
        },
      ],
    });
    expect(plan.validateFor(dated), isFalse);
  });

  test(
    'rejects exam schedule pages even if their table resembles a timetable',
    () {
      final exam = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/exam-schedule',
        'title': 'Exam timetable',
        'language': 'en',
        'nodes': [
          {
            'id': 'exam',
            'kind': 'table',
            'label': 'Exam schedule',
            'headers': ['Code', 'Day', 'Start', 'End'],
            'rows': [
              ['CS101', 'Monday', '09:00', '10:00'],
            ],
          },
        ],
      });
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'timetable',
        'tables': [
          {
            'nodeId': 'exam',
            'kind': 'meetings',
            'columns': {'code': 0, 'day': 1, 'start': 2, 'end': 3},
          },
        ],
      });
      expect(plan.validateFor(exam), isFalse);
    },
  );
}
