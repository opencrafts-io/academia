import 'package:drift/drift.dart';

class StudyMaterialRecords extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  TextColumn get metadataJson => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {environment, accountId, noteId};
}

class StudyQuestionSetRecords extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  IntColumn get setId => integer()();
  TextColumn get format => text()();
  TextColumn get setJson => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {
    environment,
    accountId,
    noteId,
    setId,
    format,
  };
}

class StudyGenerationJobRecords extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  IntColumn get jobId => integer()();
  TextColumn get requestedOutputsJson => text().nullable()();
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {environment, accountId, noteId};
}

class StudyPodcastRecords extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  IntColumn get episodeId => integer().nullable()();
  DateTimeColumn get generatedAt => dateTime()();
  TextColumn get metadataJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {
    environment,
    accountId,
    noteId,
    generatedAt,
  };
}

class StudyPodcastDownloads extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  TextColumn get episodeKey => text()();
  TextColumn get localPath => text()();
  IntColumn get sizeBytes => integer()();
  RealColumn get durationSeconds => real()();
  TextColumn get courseLabel => text()();
  TextColumn get title => text()();
  DateTimeColumn get downloadedAt => dateTime().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column<Object>> get primaryKey => {
    environment,
    accountId,
    noteId,
    episodeKey,
  };
}

class StudyPlaybackPositions extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  IntColumn get noteId => integer()();
  TextColumn get episodeKey => text()();
  IntColumn get positionMilliseconds => integer()();
  RealColumn get speed => real().withDefault(const Constant(1.0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {
    environment,
    accountId,
    noteId,
    episodeKey,
  };
}

class StudyOfflineEntitlementSnapshots extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  TextColumn get state => text()();
  DateTimeColumn get currentPeriodStart => dateTime().nullable()();
  DateTimeColumn get currentPeriodEnd => dateTime().nullable()();
  DateTimeColumn get verifiedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {environment, accountId};
}

class StudyLegacyImports extends Table {
  TextColumn get environment => text()();
  TextColumn get accountId => text()();
  TextColumn get legacyKeysJson => text()();
  DateTimeColumn get importedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {environment, accountId};
}
