import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'package:database/app_database_v2.dart';
import 'package:database/tables/tables.dart';

part 'study_tools_dao.g.dart';

@injectable
@DriftAccessor(
  tables: [
    StudyMaterialRecords,
    StudyQuestionSetRecords,
    StudyGenerationJobRecords,
    StudyPodcastRecords,
    StudyPodcastDownloads,
    StudyPlaybackPositions,
    StudyOfflineEntitlementSnapshots,
    StudyLegacyImports,
  ],
)
class StudyToolsDao extends DatabaseAccessor<AppDatabaseV2>
    with _$StudyToolsDaoMixin {
  StudyToolsDao(super.db);

  Future<List<StudyMaterialRecord>> materials(
    String environment,
    String accountId,
  ) =>
      (select(studyMaterialRecords)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId),
          ))
          .get();

  Stream<List<StudyMaterialRecord>> watchMaterials(
    String environment,
    String accountId,
  ) =>
      (select(studyMaterialRecords)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId),
          ))
          .watch();

  Future<void> saveMaterial(StudyMaterialRecordsCompanion record) =>
      into(studyMaterialRecords).insertOnConflictUpdate(record);

  Future<void> deleteMaterial(
    String environment,
    String accountId,
    int noteId,
  ) => transaction(() async {
    await (delete(studyMaterialRecords)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
    await (delete(studyQuestionSetRecords)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
    await (delete(studyGenerationJobRecords)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
    await (delete(studyPodcastRecords)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
    await (delete(studyPodcastDownloads)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
    await (delete(studyPlaybackPositions)..where(
          (row) =>
              row.environment.equals(environment) &
              row.accountId.equals(accountId) &
              row.noteId.equals(noteId),
        ))
        .go();
  });

  Future<List<StudyQuestionSetRecord>> questionSets(
    String environment,
    String accountId,
    int noteId,
    String format,
  ) =>
      (select(studyQuestionSetRecords)
            ..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId) &
                  row.noteId.equals(noteId) &
                  row.format.equals(format),
            )
            ..orderBy([(row) => OrderingTerm.desc(row.setId)]))
          .get();

  Future<void> saveQuestionSets(
    Iterable<StudyQuestionSetRecordsCompanion> records,
  ) => batch(
    (batch) => batch.insertAllOnConflictUpdate(
      studyQuestionSetRecords,
      records.toList(),
    ),
  );

  Future<Map<int, int>> jobs(String environment, String accountId) async {
    final rows =
        await (select(studyGenerationJobRecords)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .get();
    return {for (final row in rows) row.noteId: row.jobId};
  }

  Future<void> saveJob(StudyGenerationJobRecordsCompanion record) =>
      into(studyGenerationJobRecords).insertOnConflictUpdate(record);

  Future<void> removeJob(String environment, String accountId, int noteId) =>
      (delete(studyGenerationJobRecords)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId) &
                row.noteId.equals(noteId),
          ))
          .go();

  Future<List<StudyPodcastRecord>> podcasts(
    String environment,
    String accountId,
    int noteId,
  ) =>
      (select(studyPodcastRecords)
            ..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId) &
                  row.noteId.equals(noteId),
            )
            ..orderBy([(row) => OrderingTerm.desc(row.generatedAt)]))
          .get();

  Future<void> savePodcast(StudyPodcastRecordsCompanion record) =>
      into(studyPodcastRecords).insertOnConflictUpdate(record);

  Future<List<StudyPodcastDownload>> downloads(
    String environment,
    String accountId,
  ) =>
      (select(studyPodcastDownloads)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId) &
                row.status.equals('ready'),
          ))
          .get();

  Future<List<StudyPodcastDownload>> downloadManifests(
    String environment,
    String accountId,
  ) =>
      (select(studyPodcastDownloads)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId),
          ))
          .get();

  Future<StudyPodcastDownload?> downloadManifest(
    String environment,
    String accountId,
    int noteId,
    String episodeKey,
  ) =>
      (select(studyPodcastDownloads)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId) &
                row.noteId.equals(noteId) &
                row.episodeKey.equals(episodeKey),
          ))
          .getSingleOrNull();

  Future<void> saveDownload(StudyPodcastDownloadsCompanion record) =>
      into(studyPodcastDownloads).insertOnConflictUpdate(record);

  Future<void> removeDownload(
    String environment,
    String accountId,
    int noteId,
    String episodeKey,
  ) =>
      (delete(studyPodcastDownloads)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId) &
                row.noteId.equals(noteId) &
                row.episodeKey.equals(episodeKey),
          ))
          .go();

  Future<StudyPlaybackPosition?> playbackPosition(
    String environment,
    String accountId,
    int noteId,
    String episodeKey,
  ) =>
      (select(studyPlaybackPositions)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId) &
                row.noteId.equals(noteId) &
                row.episodeKey.equals(episodeKey),
          ))
          .getSingleOrNull();

  Future<void> savePlaybackPosition(StudyPlaybackPositionsCompanion record) =>
      into(studyPlaybackPositions).insertOnConflictUpdate(record);

  Future<void> saveEntitlementSnapshot(
    StudyOfflineEntitlementSnapshotsCompanion record,
  ) => into(studyOfflineEntitlementSnapshots).insertOnConflictUpdate(record);

  Future<StudyOfflineEntitlementSnapshot?> entitlementSnapshot(
    String environment,
    String accountId,
  ) =>
      (select(studyOfflineEntitlementSnapshots)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId),
          ))
          .getSingleOrNull();

  Future<bool> hasLegacyImport(String environment, String accountId) async =>
      (select(studyLegacyImports)..where(
            (row) =>
                row.environment.equals(environment) &
                row.accountId.equals(accountId),
          ))
          .getSingleOrNull()
          .then((row) => row != null);

  Future<void> commitLegacyImport({
    required String environment,
    required String accountId,
    required List<StudyMaterialRecordsCompanion> materials,
    required List<StudyQuestionSetRecordsCompanion> questionSets,
    required List<StudyGenerationJobRecordsCompanion> jobs,
    required List<String> cleanupKeys,
  }) => transaction(() async {
    final exists =
        await (select(studyLegacyImports)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .getSingleOrNull();
    if (exists != null) return;
    await batch(
      (b) => b.insertAllOnConflictUpdate(studyMaterialRecords, materials),
    );
    await batch(
      (b) => b.insertAllOnConflictUpdate(studyQuestionSetRecords, questionSets),
    );
    await batch(
      (b) => b.insertAllOnConflictUpdate(studyGenerationJobRecords, jobs),
    );
    await into(studyLegacyImports).insert(
      StudyLegacyImportsCompanion.insert(
        environment: environment,
        accountId: accountId,
        legacyKeysJson: jsonEncode(cleanupKeys),
        importedAt: DateTime.now(),
      ),
    );
  });

  Future<void> clearPodcastScope(String environment, String accountId) =>
      transaction(() async {
        await (delete(studyPodcastDownloads)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .go();
        await (delete(studyPodcastRecords)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .go();
        await (delete(studyPlaybackPositions)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .go();
        await (delete(studyOfflineEntitlementSnapshots)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .go();
      });

  Future<List<String>?> legacyCleanupKeys(
    String environment,
    String accountId,
  ) async {
    final row =
        await (select(studyLegacyImports)..where(
              (row) =>
                  row.environment.equals(environment) &
                  row.accountId.equals(accountId),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    return (jsonDecode(row.legacyKeysJson) as List).cast<String>();
  }
}
