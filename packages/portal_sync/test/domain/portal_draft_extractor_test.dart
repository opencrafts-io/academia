import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_connection.dart';
import 'package:portal_sync/src/domain/entities/portal_draft_extractor.dart';
import 'package:portal_sync/src/domain/entities/portal_snapshot.dart';

void main() {
  final connection = PortalConnection(
    accountId: 'account-a',
    institutionId: 9,
    schoolName: 'Example University',
    portalUri: Uri.parse('https://portal.example.edu'),
  );

  PortalSnapshot snapshot({
    required String title,
    required String time,
    String day = 'Monday',
    String venue = 'Room 4',
  }) => PortalSnapshot.fromJson({
    'origin': 'https://portal.example.edu',
    'path': '/student/course-list',
    'title': 'Courses',
    'language': 'en',
    'nodes': [
      {
        'id': 'table-courses',
        'kind': 'table',
        'label': 'Class timetable',
        'headers': [
          'Course code',
          'Course title',
          'Day',
          'Start',
          'End',
          'Room',
        ],
        'rows': [
          ['CS101', title, day, time, '10:00 AM', venue],
        ],
      },
    ],
  });

  final plan = PortalAnalysisPlan.fromJson({
    'pageType': 'timetable',
    'tables': [
      {
        'nodeId': 'table-courses',
        'kind': 'meetings',
        'columns': {
          'code': 0,
          'title': 1,
          'day': 2,
          'start': 3,
          'end': 4,
          'venue': 5,
        },
      },
    ],
  });

  test('imports valid rows while skipping summary and misaligned rows', () {
    final original = snapshot(title: 'Algorithms', time: '09:00');
    final mixed = PortalSnapshot.fromJson({
      ...original.toAnalysisJson(),
      'path': '/courses',
      'title': 'Courses',
      'nodes': [
        {
          ...original.nodes.single.toJson(),
          'rows': [
            original.nodes.single.rows.single,
            ['Total credits', '3'],
            ['CS202', 'Shifted cells', 'Monday', '09:00', '10:00'],
          ],
        },
      ],
    });
    final draft = const PortalDraftExtractor().extract(connection, [
      (mixed, plan),
    ]);
    expect(draft, isNotNull);
    expect(draft!.courses, hasLength(1));
    expect(draft.courses.single.code, 'CS101');
    expect(draft.meetings, hasLength(1));
  });

  test(
    'extracts locally and keeps identity stable across title and time changes',
    () {
      final extractor = const PortalDraftExtractor();
      final first = extractor.extract(connection, [
        (snapshot(title: 'Algorithms', time: '9:00 AM'), plan),
      ])!;
      final changed = extractor.extract(connection, [
        (
          snapshot(title: 'Algorithms II', time: '09:15 AM', venue: 'Room 8'),
          plan,
        ),
      ])!;

      expect(first.courses.single.sourceId, changed.courses.single.sourceId);
      expect(first.meetings.single.sourceId, changed.meetings.single.sourceId);
      expect(
        first.meetings.single.courseSourceId,
        first.courses.single.sourceId,
      );
      expect(changed.meetings.single.startTime, '09:15');
    },
  );

  test(
    'omits ambiguous days and invalid time ranges instead of inventing values',
    () {
      final invalid = const PortalDraftExtractor().extract(connection, [
        (
          snapshot(
            title: 'Algorithms',
            time: '9-ish',
            day: 'Monday / Wednesday',
          ),
          plan,
        ),
      ]);
      expect(invalid, isNotNull);
      expect(invalid!.courses, hasLength(1));
      expect(invalid.meetings, isEmpty);
    },
  );

  test(
    'links a termless timetable only when the captured course term is unique',
    () {
      final courses = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'title': 'Courses',
        'language': 'en',
        'nodes': [
          {
            'id': 'course-table',
            'kind': 'table',
            'label': 'Courses',
            'headers': ['Code', 'Title', 'Term'],
            'rows': [
              ['CS101', 'Algorithms', 'Term 1'],
            ],
          },
        ],
      });
      final timetable = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/timetable',
        'title': 'Timetable',
        'language': 'en',
        'nodes': [
          {
            'id': 'meeting-table',
            'kind': 'table',
            'label': 'Weekly classes',
            'headers': ['Code', 'Day', 'Start', 'End'],
            'rows': [
              ['CS101', 'Monday', '09:00', '10:00'],
            ],
          },
        ],
      });
      final coursePlan = PortalAnalysisPlan.fromJson({
        'pageType': 'courses',
        'tables': [
          {
            'nodeId': 'course-table',
            'kind': 'courses',
            'columns': {'code': 0, 'title': 1, 'term': 2},
          },
        ],
      });
      final meetingPlan = PortalAnalysisPlan.fromJson({
        'pageType': 'timetable',
        'tables': [
          {
            'nodeId': 'meeting-table',
            'kind': 'meetings',
            'columns': {'code': 0, 'day': 1, 'start': 2, 'end': 3},
          },
        ],
      });

      final draft = const PortalDraftExtractor().extract(connection, [
        (courses, coursePlan),
        (timetable, meetingPlan),
      ])!;
      expect(
        draft.meetings.single.courseSourceId,
        draft.courses.single.sourceId,
      );

      final multipleTerms = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/courses',
        'title': 'Courses',
        'language': 'en',
        'nodes': [
          {
            'id': 'course-table',
            'kind': 'table',
            'label': 'Courses',
            'headers': ['Code', 'Title', 'Term'],
            'rows': [
              ['CS101', 'Algorithms', 'Term 1'],
              ['CS101', 'Algorithms', 'Term 2'],
            ],
          },
        ],
      });
      final ambiguous = const PortalDraftExtractor().extract(connection, [
        (multipleTerms, coursePlan),
        (timetable, meetingPlan),
      ])!;
      expect(ambiguous.courses, hasLength(2));
      expect(ambiguous.meetings, isEmpty);
    },
  );
}
