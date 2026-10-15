import 'dart:io';

import 'package:billing/src/domain/entities/entitlement.dart';
import 'package:billing/src/domain/entities/subscription.dart';
import 'package:billing/src/domain/entities/subscription_status.dart';
import 'package:billing/src/domain/repository/repository.dart';
import 'package:billing/src/domain/services/billing_service.dart';
import 'package:billing/src/domain/usecases/get_current_subscription_status.dart';
import 'package:billing/src/domain/usecases/get_entitlements_by_plan_code.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:database/app_database_v2.dart';
import 'package:database/daos/study_tools_dao.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_tools/src/data/services/podcast_local_store.dart';
import 'package:study_tools/src/domain/entities/study_entities.dart';

void main() {
  late AppDatabaseV2 database;
  late StudyToolsDao dao;
  late Directory directory;
  late _MutableClock clock;

  setUp(() async {
    database = AppDatabaseV2(NativeDatabase.memory());
    dao = StudyToolsDao(database);
    directory = await Directory.systemTemp.createTemp('podcast-access-test');
    clock = _MutableClock(DateTime.utc(2026, 10, 1));
  });

  tearDown(() async {
    await database.close();
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test(
    'cancellation at period end keeps saved offline access through expiry',
    () async {
      final store = _store(
        dao,
        directory,
        clock,
        active: false,
        cancelAtPeriodEnd: true,
      );
      final podcast = _podcast();
      final file = File('${directory.path}/episode.mp3')
        ..writeAsBytesSync([0x49, 0x44, 0x33]);
      await dao.saveDownload(
        StudyPodcastDownloadsCompanion.insert(
          environment: 'staging',
          accountId: 'student-a',
          noteId: podcast.noteId,
          episodeKey: PodcastLocalStore.episodeKey(podcast),
          localPath: file.path,
          sizeBytes: 3,
          durationSeconds: 120,
          courseLabel: 'Biology',
          title: 'Cell chemistry',
          downloadedAt: drift.Value(clock.now()),
          status: 'ready',
        ),
      );

      await store.verifySubscriptionForDownload();
      expect(await store.eligibleDownloadPath(podcast), file.path);

      clock.value = DateTime.utc(2026, 11, 1);
      expect(await store.eligibleDownloadPath(podcast), isNull);
    },
  );

  test(
    'inactive access past its period never creates an eligible snapshot',
    () async {
      clock.value = DateTime.utc(2026, 11, 1);
      final store = _store(
        dao,
        directory,
        clock,
        active: false,
        cancelAtPeriodEnd: true,
      );

      await expectLater(
        store.verifySubscriptionForDownload(),
        throwsA(isA<PodcastSubscriptionException>()),
      );
      final snapshot = await dao.entitlementSnapshot('staging', 'student-a');
      expect(snapshot?.state, 'inactive');
    },
  );
}

PodcastLocalStore _store(
  StudyToolsDao dao,
  Directory directory,
  _MutableClock clock, {
  required bool active,
  required bool cancelAtPeriodEnd,
}) {
  final status = SubscriptionStatus(
    active: active,
    subscription: Subscription(
      id: 3,
      planCode: 'existing-plan',
      planId: 1,
      planName: 'Existing plan',
      status: 'cancelled',
      cancelAtPeriodEnd: cancelAtPeriodEnd,
      cancelledAt: DateTime.utc(2026, 9, 20),
      currentPeriodStart: DateTime.utc(2026, 9, 1),
      currentPeriodEnd: DateTime.utc(2026, 11, 1),
      startedAt: DateTime.utc(2026, 9, 1),
    ),
  );
  final repository = _SubscriptionRepository(status);
  final billing = BillingService(
    getCurrentSubscriptionStatus: GetCurrentSubscriptionStatus(repository),
    getEntitlementsByPlanCode: GetEntitlementsByPlanCode(
      _EntitlementRepository(),
    ),
    accessPolicy: const DefaultSubscriptionAccessPolicy(),
    clock: clock,
  );
  return PodcastLocalStore(
    dao: dao,
    scope: () => (
      environment: 'staging',
      accountId: 'student-a',
      legacyScope: 'staging_student-a',
    ),
    billing: billing,
    accessPolicy: const DefaultSubscriptionAccessPolicy(),
    clock: clock,
    supportDirectory: () async => directory,
  );
}

StudyPodcast _podcast() => StudyPodcast(
  id: 8,
  noteId: 12,
  generatedAt: DateTime.utc(2026, 10, 1),
  duration: const Duration(minutes: 2),
  audioUrl: 'https://cdn.example.test/episode.mp3',
  script: 'Host: Welcome.',
);

class _MutableClock implements BillingClock {
  _MutableClock(this.value);
  DateTime value;
  @override
  DateTime now() => value;
}

class _SubscriptionRepository implements SubscriptionRepository {
  _SubscriptionRepository(this.status);
  final SubscriptionStatus status;

  @override
  Future<Either<Failure, SubscriptionStatus>> getCurrentStatus() async =>
      right(status);

  @override
  Future<Either<Failure, SubscriptionStatus>> refreshCurrentStatus() async =>
      right(status);
}

class _EntitlementRepository implements EntitlementRepository {
  @override
  Future<Either<Failure, List<Entitlement>>> getByPlanCode(
    String planCode,
  ) async => right(const []);
}
