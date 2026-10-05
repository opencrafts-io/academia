import 'dart:convert';

import 'package:academia/core/integration/portal_sync/academia_portal_importer.dart';
import 'package:core/core.dart';
import 'package:courses/courses.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ai/firebase_ai.dart';
// The SDK provides this factory specifically for exercising its real serializer.
// ignore: implementation_imports
import 'package:firebase_ai/src/base_model.dart' as sdk;
// ignore: implementation_imports
import 'package:firebase_ai/src/client.dart' as sdk_client;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magnet/magnet.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  late _Courses repository;
  late _Ledger ledger;
  late AcademiaPortalImporter importer;
  var currentAccount = 'student';

  setUp(() {
    repository = _Courses();
    ledger = _Ledger();
    currentAccount = 'student';
    importer = AcademiaPortalImporter(
      repository: repository,
      ledger: ledger,
      accountId: 'student',
      institutionId: 10,
      isCurrentAccount: () => currentAccount == 'student',
    );
  });

  test(
    'retry updates stable records without duplicating courses or meetings',
    () async {
      await importer.importDraft(_draft());
      await importer.importDraft(
        _draft(title: 'Algorithms II', start: '10:00', end: '11:00'),
      );
      expect(repository.courses, hasLength(1));
      expect(repository.meetings, hasLength(1));
      expect(repository.courses.single.title, 'Algorithms II');
      expect(repository.meetings.single.startTime, '10:00');
    },
  );

  test('manual edits and unrelated meetings are preserved', () async {
    await importer.importDraft(_draft());
    repository.courses[0] = repository.courses.single.copyWith(
      title: 'My custom course',
    );
    repository.meetings[0] = repository.meetings.single.copyWith(
      venue: 'My room',
    );
    final result = await importer.importDraft(
      _draft(title: 'New portal title', start: '10:00', end: '11:00'),
    );
    expect(repository.courses.single.title, 'My custom course');
    expect(repository.meetings.single.venue, 'My room');
    expect(result.message, contains('kept'));
  });

  test(
    'partial failure can retry without duplicating previously saved courses',
    () async {
      repository.failMeetingOnce = true;
      await expectLater(importer.importDraft(_draft()), throwsStateError);
      await importer.importDraft(_draft());
      expect(repository.courses, hasLength(1));
      expect(repository.meetings, hasLength(1));
    },
  );

  test(
    'a partially imported course can retain several weekly meetings on retry',
    () async {
      final initial = _draft();
      final draft = PortalDraft(
        courses: initial.courses,
        meetings: [
          ...initial.meetings,
          const PortalMeetingDraft(
            sourceId: 'second-stable',
            courseSourceId: 'course-stable',
            day: 'Wednesday',
            startTime: '12:00',
            endTime: '13:00',
          ),
        ],
        sourceOrigin: initial.sourceOrigin,
        observedAt: initial.observedAt,
      );
      await importer.importDraft(initial);
      await importer.importDraft(draft);
      await importer.importDraft(draft);
      expect(repository.meetings, hasLength(2));
    },
  );

  test('a meeting with changed ambiguous source identity never creates a duplicate', () async {
    final initial = _draft();
    await importer.importDraft(initial);
    final changed = PortalDraft(
      courses: initial.courses,
      meetings: [
        const PortalMeetingDraft(
          sourceId: 'changed-day-id',
          courseSourceId: 'course-stable',
          day: 'Friday',
          startTime: '09:00',
          endTime: '10:00',
        ),
      ],
      sourceOrigin: initial.sourceOrigin,
      observedAt: initial.observedAt,
    );
    await importer.importDraft(changed);
    expect(repository.meetings, hasLength(1));
    expect(repository.meetings.single.dayOfWeek, 'monday');
  });

  test('unmapped existing course is never overwritten by an import', () async {
    await repository.createCourse(
      institutionId: 10,
      title: 'Personal title',
      code: 'CS101',
      termLabel: '2026',
    );
    await importer.importDraft(_draft());
    expect(repository.courses, hasLength(1));
    expect(repository.courses.single.title, 'Personal title');
  });

  test('account change stops writes', () async {
    currentAccount = 'someone-else';
    await expectLater(importer.importDraft(_draft()), throwsStateError);
    expect(repository.courses, isEmpty);
  });

  test('portal pages reach the existing timetable through review and cached refresh', () async {
    final client = _MappingClient();
    final usage = _Usage();
    final controller = PortalSyncController(
      connection: PortalConnection(
        accountId: 'student',
        institutionId: 10,
        schoolName: 'Example University',
        portalUri: Uri.parse('https://portal.school.edu'),
      ),
      analysisClient: client,
      cacheStore: _Cache(),
      usageStore: usage,
      accessPolicy: _Access(),
      importer: importer,
    );
    addTearDown(controller.dispose);
    await controller.capture(
      _page(
        'courses',
        ['Code', 'Title', 'Term'],
        ['CS101', 'Algorithms', '2026'],
      ),
    );
    await controller.capture(
      _page(
        'timetable',
        ['Code', 'Day', 'Start', 'End', 'Room'],
        ['CS101', 'Monday', '09:00', '10:00', 'A1'],
      ),
    );
    expect(
      repository.courses,
      isEmpty,
      reason: 'Capture cannot save without review.',
    );
    expect(controller.state.draft!.meetings, hasLength(1));
    await controller.saveDraft();
    expect(repository.meetings.single.dayOfWeek, 'monday');
    await controller.capture(
      _page(
        'timetable',
        ['Code', 'Day', 'Start', 'End', 'Room'],
        ['CS101', 'Monday', '11:00', '12:00', 'B2'],
      ),
    );
    expect(controller.state.fromCache, isTrue);
    await controller.saveDraft();
    expect(repository.meetings, hasLength(1));
    expect(repository.meetings.single.startTime, '11:00');
    expect(repository.meetings.single.venue, 'B2');
    expect(usage.attempts, 2);
    final transmitted = jsonEncode(
      client.requests.map((request) => request.structuralContent).toList(),
    );
    expect(transmitted, isNot(contains('Algorithms')));
    expect(transmitted, isNot(contains('CS101')));
    expect(transmitted, isNot(contains('09:00')));
  });

  test('browser bridge through real Firebase serializer reaches review, save and cached updates', () async {
    final transport = _FirebaseTransport();
    final usage = _Usage();
    final controller = PortalSyncController(
      connection: PortalConnection(
        accountId: 'student',
        institutionId: 10,
        schoolName: 'Example University',
        portalUri: Uri.parse('https://portal.school.edu'),
      ),
      analysisClient: FirebasePortalAnalysisClient(
        firebaseAI: _FirebaseWithTransport(transport),
      ),
      cacheStore: _Cache(),
      usageStore: usage,
      accessPolicy: _Access(),
      importer: importer,
    );
    addTearDown(controller.dispose);
    PortalSnapshot browserPage(String start, String end) {
      final safe = PortalSnapshotSanitizer.sanitize({
        'origin': 'https://portal.school.edu',
        'path': '/timetable',
        'title': 'Class timetable',
        'language': 'en',
        'nodes': [
          {
            'id': 'n0',
            'kind': 'table',
            'label': 'Class timetable',
            'headers': ['Code', 'Title', 'Day', 'Start', 'End', 'Room', 'Term'],
            'rows': [
              ['CS101', 'Algorithms', 'Monday', start, end, 'A1', '2026'],
            ],
          },
        ],
      }, expectedOrigin: 'https://portal.school.edu');
      return PortalSnapshot.fromJson(safe!);
    }

    await controller.capture(browserPage('09:00', '10:00'));
    expect(controller.state.phase, PortalSyncPhase.review);
    expect(controller.state.draft!.courses, hasLength(1));
    expect(controller.state.draft!.meetings, hasLength(1));
    expect(controller.state.hintNodeId, isNull);
    expect(repository.courses, isEmpty);
    await controller.saveDraft();
    expect(controller.state.phase, PortalSyncPhase.saved);
    expect(repository.courses, hasLength(1));
    expect(repository.meetings.single.startTime, '09:00');
    await controller.capture(browserPage('11:00', '12:00'));
    expect(controller.state.fromCache, isTrue);
    await controller.saveDraft();
    expect(repository.courses, hasLength(1));
    expect(repository.meetings, hasLength(1));
    expect(repository.meetings.single.startTime, '11:00');
    expect(transport.requests, hasLength(1));
    expect(usage.attempts, 1);
    final transmitted = jsonEncode(transport.requests);
    for (final cell in ['CS101', 'Algorithms', '09:00', '11:00', 'A1']) {
      expect(transmitted, isNot(contains(cell)));
    }
  });
}

class _FirebaseTransport implements sdk_client.ApiClient {
  final requests = <Map<String, Object?>>[];
  @override
  Future<Map<String, Object?>> makeRequest(
    Uri uri,
    Map<String, Object?> body,
  ) async {
    requests.add(body);
    final plan = {
      'pageType': 'timetable',
      'tables': [
        {
          'nodeId': 'n0',
          'kind': 'courses',
          'columns': {'code': 0, 'title': 1, 'term': 6},
        },
        {
          'nodeId': 'n0',
          'kind': 'meetings',
          'columns': {
            'code': 0,
            'day': 2,
            'start': 3,
            'end': 4,
            'venue': 5,
            'term': 6,
          },
        },
        {
          'nodeId': 'invented-table',
          'kind': 'courses',
          'columns': {'code': 0, 'title': 1},
        },
      ],
      'hint': {'nodeId': 'invented-link', 'label': 'Open courses'},
    };
    return {
      'candidates': [
        {
          'content': {
            'role': 'model',
            'parts': [
              {'text': jsonEncode(plan)},
            ],
          },
          'finishReason': 'STOP',
        },
      ],
    };
  }

  @override
  Stream<Map<String, Object?>> streamRequest(
    Uri uri,
    Map<String, Object?> body,
  ) => throw UnimplementedError();
}

class _FirebaseWithTransport implements FirebaseAI {
  _FirebaseWithTransport(this.transport);
  final _FirebaseTransport transport;
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #generativeModel) {
      return sdk.createModelWithClient(
        app: _TestFirebaseApp(),
        location: 'global',
        useAgentPlatform: false,
        model: invocation.namedArguments[#model] as String,
        client: transport,
        generationConfig:
            invocation.namedArguments[#generationConfig] as GenerationConfig?,
        systemInstruction:
            invocation.namedArguments[#systemInstruction] as Content?,
      );
    }
    return super.noSuchMethod(invocation);
  }
}

class _TestFirebaseApp implements FirebaseApp {
  @override
  String get name => 'portal-flow-test';
  @override
  FirebaseOptions get options => const FirebaseOptions(
    apiKey: 'test',
    appId: 'test',
    messagingSenderId: 'test',
    projectId: 'portal-flow-test',
  );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

PortalSnapshot _page(String page, List<String> headers, List<String> row) =>
    PortalSnapshot.fromJson({
      'origin': 'https://portal.school.edu',
      'path': '/$page',
      'title': page,
      'language': 'en',
      'nodes': [
        {
          'id': 'n0',
          'kind': 'table',
          'label': page,
          'headers': headers,
          'rows': [row],
        },
      ],
    });

class _MappingClient implements PortalAnalysisClient {
  final requests = <PortalAnalysisRequest>[];
  @override
  Future<PortalAnalysisPlan> analyze(PortalAnalysisRequest request) async {
    requests.add(request);
    final nodes = request.structuralContent['nodes'] as List;
    final headers = (nodes.single as Map)['headers'] as List;
    final courses = headers.contains('Title');
    return PortalAnalysisPlan(
      pageType: courses ? PortalPageType.courses : PortalPageType.timetable,
      tables: [
        PortalTablePlan(
          nodeId: 'n0',
          kind: courses ? PortalTableKind.courses : PortalTableKind.meetings,
          columns: courses
              ? const PortalColumnMap(code: 0, title: 1, term: 2)
              : const PortalColumnMap(
                  code: 0,
                  day: 1,
                  start: 2,
                  end: 3,
                  venue: 4,
                ),
        ),
      ],
    );
  }
}

class _Cache implements PortalCacheStore {
  final plans = <String, PortalAnalysisPlan>{};
  @override
  Future<PortalAnalysisPlan?> getPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
  }) async => plans[fingerprint];
  @override
  Future<void> putPlan({
    required String accountId,
    required String origin,
    required String language,
    required String fingerprint,
    required String modelVersion,
    required PortalAnalysisPlan plan,
  }) async {
    plans[fingerprint] = plan;
  }

  @override
  Future<void> clearAccount(String accountId) async {
    plans.clear();
  }
}

class _Usage implements PortalUsageStore {
  int attempts = 0;
  @override
  Future<bool> canAttempt(String accountId, {DateTime? now}) async => true;
  @override
  Future<void> recordAttempt(String accountId, {DateTime? now}) async {
    attempts++;
  }

  @override
  Future<void> markSetupComplete(String accountId) async {}
  @override
  Future<void> clearAccount(String accountId) async {}
}

class _Access implements PortalAccessPolicy {
  @override
  Future<bool> canAnalyze() async => true;
}

PortalDraft _draft({
  String title = 'Algorithms',
  String start = '09:00',
  String end = '10:00',
}) => PortalDraft(
  courses: [
    PortalCourseDraft(
      sourceId: 'course-stable',
      code: 'CS101',
      title: title,
      term: '2026',
    ),
  ],
  meetings: [
    PortalMeetingDraft(
      sourceId: 'meeting-stable',
      courseSourceId: 'course-stable',
      day: 'Monday',
      startTime: start,
      endTime: end,
      venue: 'A1',
    ),
  ],
  sourceOrigin: 'https://portal.school.edu',
  observedAt: DateTime.utc(2026, 10, 4),
);

class _Ledger implements PortalImportLedger {
  final values = <String, PortalImportLink>{};
  @override
  Future<PortalImportLink?> get(String key) async => values[key];
  @override
  Future<void> put(String key, PortalImportLink value) async {
    values[key] = value;
  }
}

class _Courses implements CourseRepository {
  final courses = <CourseEntity>[];
  final meetings = <ScheduleEntryEntity>[];
  bool failMeetingOnce = false;
  @override
  Future<Either<Failure, List<CourseEntity>>> listActiveCourses() async =>
      Right(List.of(courses));
  @override
  Future<Either<Failure, List<ScheduleEntryEntity>>>
  listCachedStudentSchedule() async => Right(List.of(meetings));
  @override
  Future<Either<Failure, CourseEntity>> createCourse({
    required int institutionId,
    required String title,
    String? code,
    String? color,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
  }) async {
    final course = CourseEntity(
      id: 'c${courses.length}',
      institutionId: institutionId,
      title: title,
      code: code,
      termLabel: termLabel,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    courses.add(course);
    return Right(course);
  }

  @override
  Future<Either<Failure, CourseEntity>> updateCourse(
    CourseEntity course,
  ) async {
    courses[courses.indexWhere((value) => value.id == course.id)] = course;
    return Right(course);
  }

  @override
  Future<Either<Failure, ScheduleEntryEntity>> createScheduleEntry(
    ScheduleEntryEntity entry,
  ) async {
    if (failMeetingOnce) {
      failMeetingOnce = false;
      throw StateError('Simulated write failure');
    }
    final saved = entry.copyWith(id: 'm${meetings.length}');
    meetings.add(saved);
    return Right(saved);
  }

  @override
  Future<Either<Failure, ScheduleEntryEntity>> updateScheduleEntry(
    ScheduleEntryEntity entry,
  ) async {
    meetings[meetings.indexWhere((value) => value.id == entry.id)] = entry;
    return Right(entry);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
