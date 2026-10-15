import 'dart:convert';

import 'package:database/app_database_v2.dart';
import 'package:database/daos/study_tools_dao.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dtos/study_dtos.dart';
import '../../domain/entities/study_entities.dart';

typedef StudyToolsScope = ({
  String environment,
  String accountId,
  String legacyScope,
});

abstract interface class StudyToolsLocalDatasource {
  Future<List<StudyMaterial>> materials();
  Future<void> saveMaterial(StudyMaterial material);
  Future<void> removeMaterial(int id);
  Future<List<QuestionSet>> questionSets(int noteId, QuestionFormat format);
  Future<void> saveQuestionSets(
    int noteId,
    QuestionFormat format,
    List<QuestionSet> sets,
  );
  Future<Map<int, int>> jobs();
  Future<void> saveJob(
    int noteId,
    int jobId, {
    required List<String> outputs,
    QuestionFormat? questionFormat,
  });
  Future<void> removeJob(int noteId);
  Future<StudyPodcast?> podcast(int noteId);
  Future<void> savePodcast(StudyPodcast podcast);
  Future<StudyPodcast?> podcastVersion(int noteId, String episodeKey);
}

/// Drift is the source of truth. SharedPreferences is read only for the
/// idempotent import of data written by releases before the Drift migration.
class DriftStudyToolsLocalDatasource implements StudyToolsLocalDatasource {
  DriftStudyToolsLocalDatasource({
    required this.dao,
    required this.scope,
    this._preferences,
  });

  final StudyToolsDao dao;
  final StudyToolsScope? Function() scope;
  final SharedPreferences Function()? _preferences;
  final Map<String, Future<void>> _imports = {};

  Future<StudyToolsScope?> get _readyScope async {
    final current = scope();
    if (current == null ||
        current.accountId.trim().isEmpty ||
        current.accountId == 'unresolved' ||
        current.environment.trim().isEmpty) {
      return null;
    }
    await _ensureImported(current);
    return current;
  }

  Future<SharedPreferences> get _prefs async =>
      _preferences?.call() ?? SharedPreferences.getInstance();

  Future<void> _ensureImported(StudyToolsScope current) async {
    final key = '${current.environment}:${current.accountId}';
    final import = _imports.putIfAbsent(key, () => _importLegacy(current));
    try {
      await import;
    } finally {
      if (identical(_imports[key], import)) _imports.remove(key);
    }
  }

  Future<void> _importLegacy(StudyToolsScope current) async {
    final prefs = await _prefs;
    final cleanup = await dao.legacyCleanupKeys(
      current.environment,
      current.accountId,
    );
    if (cleanup != null) {
      for (final key in cleanup) {
        await prefs.remove(key);
      }
      return;
    }

    final prefix = 'study_tools_${Uri.encodeComponent(current.legacyScope)}';
    final materialsKey = '${prefix}_materials';
    final jobsKey = '${prefix}_jobs';
    final cleanupKeys = <String>[];
    final materials = <StudyMaterialRecordsCompanion>[];
    final questionSets = <StudyQuestionSetRecordsCompanion>[];
    final jobs = <StudyGenerationJobRecordsCompanion>[];

    final materialJson = prefs.getString(materialsKey);
    if (materialJson != null) {
      try {
        final rows = jsonDecode(materialJson) as List;
        for (final row in rows) {
          final dto = StudyMaterialDto.fromJson(
            Map<String, dynamic>.from(row as Map),
          );
          final material = dto.toEntity();
          materials.add(
            StudyMaterialRecordsCompanion.insert(
              environment: current.environment,
              accountId: current.accountId,
              noteId: material.id,
              metadataJson: jsonEncode(_materialJson(material)),
              cachedAt: DateTime.now(),
            ),
          );
        }
        cleanupKeys.add(materialsKey);
      } on Object {
        // Preserve malformed legacy values for support/recovery. Valid rows
        // from independent keys still migrate safely.
      }
    }

    for (final key in prefs.getKeys().where(
      (key) => key.startsWith('${prefix}_sets_'),
    )) {
      final match = RegExp(r'_sets_(\d+)_(flashcard|mcq|open_ended)$')
          .firstMatch(key);
      final raw = prefs.getString(key);
      if (match == null || raw == null) continue;
      try {
        final noteId = int.parse(match.group(1)!);
        final format = QuestionFormatApi.parse(match.group(2)!);
        final sets = (jsonDecode(raw) as List)
            .map(
              (item) => QuestionSetDto.fromJson(
                Map<String, dynamic>.from(item as Map),
              ).toEntity(),
            )
            .toList(growable: false);
        questionSets.addAll(
          sets.map(
            (set) => StudyQuestionSetRecordsCompanion.insert(
              environment: current.environment,
              accountId: current.accountId,
              noteId: noteId,
              setId: set.id,
              format: format.apiValue,
              setJson: jsonEncode(_setJson(set)),
              cachedAt: DateTime.now(),
            ),
          ),
        );
        cleanupKeys.add(key);
      } on Object {
        // Keep an unparseable key intact; it may be recovered by a later app
        // version with a more specific decoder.
      }
    }

    final jobsJson = prefs.getString(jobsKey);
    if (jobsJson != null) {
      try {
        final values = jsonDecode(jobsJson) as Map;
        for (final entry in values.entries) {
          jobs.add(
            StudyGenerationJobRecordsCompanion.insert(
              environment: current.environment,
              accountId: current.accountId,
              noteId: int.parse(entry.key as String),
              jobId: entry.value as int,
              requestedOutputsJson: const Value(null),
              savedAt: DateTime.now(),
            ),
          );
        }
        cleanupKeys.add(jobsKey);
      } on Object {
        // Keep malformed legacy job references untouched.
      }
    }

    await dao.commitLegacyImport(
      environment: current.environment,
      accountId: current.accountId,
      materials: materials,
      questionSets: questionSets,
      jobs: jobs,
      cleanupKeys: cleanupKeys,
    );
    for (final key in cleanupKeys) {
      await prefs.remove(key);
    }
  }

  @override
  Future<List<StudyMaterial>> materials() async {
    final current = await _readyScope;
    if (current == null) return const [];
    final records = await dao.materials(current.environment, current.accountId);
    return records
        .map(
          (row) => StudyMaterialDto.fromJson(
            Map<String, dynamic>.from(jsonDecode(row.metadataJson) as Map),
          ).toEntity(),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveMaterial(StudyMaterial material) async {
    final current = await _readyScope;
    if (current == null) return;
    await dao.saveMaterial(
      StudyMaterialRecordsCompanion.insert(
        environment: current.environment,
        accountId: current.accountId,
        noteId: material.id,
        metadataJson: jsonEncode(_materialJson(material)),
        cachedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> removeMaterial(int id) async {
    final current = await _readyScope;
    if (current == null) return;
    await dao.deleteMaterial(current.environment, current.accountId, id);
  }

  @override
  Future<List<QuestionSet>> questionSets(
    int noteId,
    QuestionFormat format,
  ) async {
    final current = await _readyScope;
    if (current == null) return const [];
    final rows = await dao.questionSets(
      current.environment,
      current.accountId,
      noteId,
      format.apiValue,
    );
    return rows
        .map(
          (row) => QuestionSetDto.fromJson(
            Map<String, dynamic>.from(jsonDecode(row.setJson) as Map),
          ).toEntity(),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveQuestionSets(
    int noteId,
    QuestionFormat format,
    List<QuestionSet> sets,
  ) async {
    final current = await _readyScope;
    if (current == null) return;
    await dao.saveQuestionSets(
      sets.map(
        (set) => StudyQuestionSetRecordsCompanion.insert(
          environment: current.environment,
          accountId: current.accountId,
          noteId: noteId,
          setId: set.id,
          format: format.apiValue,
          setJson: jsonEncode(_setJson(set)),
          cachedAt: DateTime.now(),
        ),
      ),
    );
  }

  @override
  Future<Map<int, int>> jobs() async {
    final current = await _readyScope;
    if (current == null) return const {};
    return dao.jobs(current.environment, current.accountId);
  }

  @override
  Future<void> saveJob(
    int noteId,
    int jobId, {
    required List<String> outputs,
    QuestionFormat? questionFormat,
  }) async {
    final current = await _readyScope;
    if (current == null) return;
    await dao.saveJob(
      StudyGenerationJobRecordsCompanion.insert(
        environment: current.environment,
        accountId: current.accountId,
        noteId: noteId,
        jobId: jobId,
        requestedOutputsJson: Value(
          jsonEncode({
            'outputs': outputs,
            if (questionFormat != null)
              'question_format': questionFormat.apiValue,
          }),
        ),
        savedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> removeJob(int noteId) async {
    final current = await _readyScope;
    if (current == null) return;
    await dao.removeJob(current.environment, current.accountId, noteId);
  }

  @override
  Future<StudyPodcast?> podcast(int noteId) async {
    final current = await _readyScope;
    if (current == null) return null;
    final records = await dao.podcasts(
      current.environment,
      current.accountId,
      noteId,
    );
    if (records.isEmpty) return null;
    return PodcastDto.fromJson(
      Map<String, dynamic>.from(jsonDecode(records.first.metadataJson) as Map),
    ).toEntity();
  }

  @override
  Future<void> savePodcast(StudyPodcast podcast) async {
    final current = await _readyScope;
    if (current == null) return;
    final episodeKey =
        podcast.id?.toString() ?? podcast.generatedAt.toUtc().toIso8601String();
    await dao.savePodcast(
      StudyPodcastRecordsCompanion.insert(
        environment: current.environment,
        accountId: current.accountId,
        noteId: podcast.noteId,
        episodeId: Value(podcast.id),
        generatedAt: podcast.generatedAt,
        metadataJson: jsonEncode({
          'id': podcast.id,
          'note_id': podcast.noteId,
          'title': podcast.title,
          'generated_at': podcast.generatedAt.toIso8601String(),
          'duration_seconds': podcast.duration.inMilliseconds / 1000,
          'audio_url': podcast.audioUrl,
          'script': podcast.script,
          'episode_key': episodeKey,
        }),
      ),
    );
  }

  @override
  Future<StudyPodcast?> podcastVersion(int noteId, String episodeKey) async {
    final current = await _readyScope;
    if (current == null) return null;
    final rows = await dao.podcasts(
      current.environment,
      current.accountId,
      noteId,
    );
    for (final row in rows) {
      final raw = Map<String, dynamic>.from(
        jsonDecode(row.metadataJson) as Map,
      );
      final podcast = PodcastDto.fromJson(raw).toEntity();
      final key =
          podcast.id?.toString() ??
          podcast.generatedAt.toUtc().microsecondsSinceEpoch.toString();
      if (key == episodeKey) return podcast;
    }
    return null;
  }
}

Map<String, dynamic> _materialJson(StudyMaterial material) => {
  'id': material.id,
  'course_id': material.courseId,
  'course_label': material.courseLabel,
  'original_filename': material.filename,
  'size_bytes': material.sizeBytes,
  'uploaded_at': material.uploadedAt.toIso8601String(),
  'artifacts': material.artifacts == null
      ? null
      : {
          'summary': material.artifacts!.summary,
          'questions': material.artifacts!.questions
              .map((f) => f.apiValue)
              .toList(),
          'podcast': material.artifacts!.podcast,
          'study_plans': material.artifacts!.studyPlans,
        },
};

Map<String, dynamic> _setJson(QuestionSet set) => {
  'id': set.id,
  'format': set.format.apiValue,
  'generated_at': set.generatedAt.toIso8601String(),
  'questions': set.questions
      .map(
        (question) => switch (question) {
          FlashcardQuestion(:final front, :final back) => {
            'front': front,
            'back': back,
          },
          MultipleChoiceQuestion(
            :final question,
            :final choices,
            :final answerIndex,
            :final explanation,
          ) =>
            {
              'question': question,
              'choices': choices,
              'answer_index': answerIndex,
              'explanation': explanation,
            },
          OpenEndedQuestion(:final question, :final modelAnswer) => {
            'question': question,
            'model_answer': modelAnswer,
          },
        },
      )
      .toList(growable: false),
};
