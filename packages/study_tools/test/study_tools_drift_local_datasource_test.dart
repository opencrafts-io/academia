import 'dart:convert';

import 'package:database/app_database_v2.dart';
import 'package:database/daos/study_tools_dao.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_tools/src/data/datasources/study_tools_local_datasource.dart';
import 'package:study_tools/src/domain/entities/study_entities.dart';

void main() {
  late AppDatabaseV2 database;
  late StudyToolsDao dao;
  const active = (
    environment: 'staging',
    accountId: 'student-a',
    legacyScope: 'staging_student-a',
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'study_tools_staging_student-a_materials': jsonEncode([
        {
          'id': 12,
          'course_id': 'c7c90f60-9e77-4270-ade9-01db660530bc',
          'course_label': 'Biology',
          'original_filename': 'cells.pdf',
          'size_bytes': 512,
          'uploaded_at': '2026-10-01T12:00:00Z',
          'artifacts': {
            'summary': true,
            'questions': ['flashcard'],
            'podcast': true,
            'study_plans': [2],
          },
        },
      ]),
      'study_tools_staging_student-a_sets_12_flashcard': jsonEncode([
        {
          'id': 71,
          'format': 'flashcard',
          'generated_at': '2026-10-02T12:00:00Z',
          'questions': [
            {'front': 'Mitochondria?', 'back': 'Cell energy.'},
          ],
        },
      ]),
      'study_tools_staging_student-a_jobs': jsonEncode({'12': 92}),
      'study_tools_staging_student-a_sets_99_unknown': 'keep-me',
    });
    database = AppDatabaseV2(NativeDatabase.memory());
    dao = StudyToolsDao(database);
  });

  tearDown(() => database.close());

  test('imports legacy materials, question sets, and jobs once', () async {
    final local = _local(dao, active);

    final materials = await local.materials();
    final sets = await local.questionSets(12, QuestionFormat.flashcard);
    final jobs = await local.jobs();

    expect(materials.single.filename, 'cells.pdf');
    expect(materials.single.artifacts?.podcast, isTrue);
    expect(materials.single.artifacts?.summary, isTrue);
    expect(materials.single.artifacts?.studyPlans, [2]);
    expect(sets.single.questions.single, isA<FlashcardQuestion>());
    expect(jobs, {12: 92});

    final prefs = await SharedPreferences.getInstance();
    expect(
      prefs.containsKey('study_tools_staging_student-a_materials'),
      isFalse,
    );
    expect(
      prefs.containsKey('study_tools_staging_student-a_sets_12_flashcard'),
      isFalse,
    );
    expect(prefs.containsKey('study_tools_staging_student-a_jobs'), isFalse);
    expect(
      prefs.getString('study_tools_staging_student-a_sets_99_unknown'),
      'keep-me',
    );

    expect((await _local(dao, active).materials()), hasLength(1));
    expect((await local.jobs()), {12: 92});
  });

  test(
    'cleans legacy preferences left behind after a committed import',
    () async {
      const materialsKey = 'study_tools_staging_student-a_materials';
      await dao.commitLegacyImport(
        environment: active.environment,
        accountId: active.accountId,
        materials: const [],
        questionSets: const [],
        jobs: const [],
        cleanupKeys: const [materialsKey],
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(materialsKey, 'legacy payload');
      await _local(dao, active).materials();

      expect(prefs.containsKey(materialsKey), isFalse);
    },
  );

  test('isolates cached data by account and environment', () async {
    final first = _local(dao, active);
    await first.materials();
    await first.saveMaterial(
      StudyMaterial(
        id: 55,
        courseId: null,
        courseLabel: '',
        filename: 'private.pdf',
        sizeBytes: 10,
        uploadedAt: DateTime.utc(2026),
      ),
    );

    final anotherAccount = _local(dao, (
      environment: 'staging',
      accountId: 'student-b',
      legacyScope: 'staging_student-b',
    ));
    final production = _local(dao, (
      environment: 'production',
      accountId: 'student-a',
      legacyScope: 'production_student-a',
    ));

    expect(await anotherAccount.materials(), isEmpty);
    expect(await production.materials(), isEmpty);
  });

  test(
    'unresolved accounts do not read or write persistent study data',
    () async {
      final local = _local(dao, null);

      expect(await local.materials(), isEmpty);
      await local.saveMaterial(
        StudyMaterial(
          id: 1,
          courseId: null,
          courseLabel: '',
          filename: 'private.pdf',
          sizeBytes: 1,
          uploadedAt: DateTime.utc(2026),
        ),
      );
      expect(
        await database.select(database.studyMaterialRecords).get(),
        isEmpty,
      );
    },
  );
}

DriftStudyToolsLocalDatasource _local(
  StudyToolsDao dao,
  StudyToolsScope? scope,
) => DriftStudyToolsLocalDatasource(dao: dao, scope: () => scope);
