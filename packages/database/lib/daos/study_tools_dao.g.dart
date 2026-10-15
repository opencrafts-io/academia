// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tools_dao.dart';

// ignore_for_file: type=lint
mixin _$StudyToolsDaoMixin on DatabaseAccessor<AppDatabaseV2> {
  $StudyMaterialRecordsTable get studyMaterialRecords =>
      attachedDatabase.studyMaterialRecords;
  $StudyQuestionSetRecordsTable get studyQuestionSetRecords =>
      attachedDatabase.studyQuestionSetRecords;
  $StudyGenerationJobRecordsTable get studyGenerationJobRecords =>
      attachedDatabase.studyGenerationJobRecords;
  $StudyPodcastRecordsTable get studyPodcastRecords =>
      attachedDatabase.studyPodcastRecords;
  $StudyPodcastDownloadsTable get studyPodcastDownloads =>
      attachedDatabase.studyPodcastDownloads;
  $StudyPlaybackPositionsTable get studyPlaybackPositions =>
      attachedDatabase.studyPlaybackPositions;
  $StudyOfflineEntitlementSnapshotsTable get studyOfflineEntitlementSnapshots =>
      attachedDatabase.studyOfflineEntitlementSnapshots;
  $StudyLegacyImportsTable get studyLegacyImports =>
      attachedDatabase.studyLegacyImports;
  StudyToolsDaoManager get managers => StudyToolsDaoManager(this);
}

class StudyToolsDaoManager {
  final _$StudyToolsDaoMixin _db;
  StudyToolsDaoManager(this._db);
  $$StudyMaterialRecordsTableTableManager get studyMaterialRecords =>
      $$StudyMaterialRecordsTableTableManager(
        _db.attachedDatabase,
        _db.studyMaterialRecords,
      );
  $$StudyQuestionSetRecordsTableTableManager get studyQuestionSetRecords =>
      $$StudyQuestionSetRecordsTableTableManager(
        _db.attachedDatabase,
        _db.studyQuestionSetRecords,
      );
  $$StudyGenerationJobRecordsTableTableManager get studyGenerationJobRecords =>
      $$StudyGenerationJobRecordsTableTableManager(
        _db.attachedDatabase,
        _db.studyGenerationJobRecords,
      );
  $$StudyPodcastRecordsTableTableManager get studyPodcastRecords =>
      $$StudyPodcastRecordsTableTableManager(
        _db.attachedDatabase,
        _db.studyPodcastRecords,
      );
  $$StudyPodcastDownloadsTableTableManager get studyPodcastDownloads =>
      $$StudyPodcastDownloadsTableTableManager(
        _db.attachedDatabase,
        _db.studyPodcastDownloads,
      );
  $$StudyPlaybackPositionsTableTableManager get studyPlaybackPositions =>
      $$StudyPlaybackPositionsTableTableManager(
        _db.attachedDatabase,
        _db.studyPlaybackPositions,
      );
  $$StudyOfflineEntitlementSnapshotsTableTableManager
  get studyOfflineEntitlementSnapshots =>
      $$StudyOfflineEntitlementSnapshotsTableTableManager(
        _db.attachedDatabase,
        _db.studyOfflineEntitlementSnapshots,
      );
  $$StudyLegacyImportsTableTableManager get studyLegacyImports =>
      $$StudyLegacyImportsTableTableManager(
        _db.attachedDatabase,
        _db.studyLegacyImports,
      );
}
