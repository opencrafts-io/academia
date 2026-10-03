import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dtos/study_dtos.dart';
import '../../domain/entities/study_entities.dart';

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
  Future<void> saveJob(int noteId, int jobId);
  Future<void> removeJob(int noteId);
}

class SharedPreferencesStudyToolsDatasource
    implements StudyToolsLocalDatasource {
  SharedPreferencesStudyToolsDatasource({required this.scope});

  /// The host supplies an account and flavor scoped value.
  final String Function() scope;
  String get _prefix => 'study_tools_${Uri.encodeComponent(scope())}';
  String get _materialsKey => '${_prefix}_materials';
  String get _jobsKey => '${_prefix}_jobs';

  @override
  Future<List<StudyMaterial>> materials() async {
    final prefs = await SharedPreferences.getInstance();
    final rows = jsonDecode(prefs.getString(_materialsKey) ?? '[]') as List;
    return rows
        .map((row) => _materialFromJson(Map<String, dynamic>.from(row as Map)))
        .toList();
  }

  @override
  Future<void> saveMaterial(StudyMaterial material) async {
    final items = await materials();
    final next = [
      for (final item in items)
        if (item.id != material.id) item,
      material,
    ];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _materialsKey,
      jsonEncode(next.map(_materialJson).toList()),
    );
  }

  @override
  Future<void> removeMaterial(int id) async {
    final items = await materials();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _materialsKey,
      jsonEncode(items.where((m) => m.id != id).map(_materialJson).toList()),
    );
    final setKeys = prefs
        .getKeys()
        .where((key) => key.startsWith('${_prefix}_sets_${id}_'))
        .toList();
    for (final key in setKeys) {
      await prefs.remove(key);
    }
    await removeJob(id);
  }

  @override
  Future<List<QuestionSet>> questionSets(
    int noteId,
    QuestionFormat format,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_setsKey(noteId, format));
    if (raw == null) return const [];
    return (jsonDecode(raw) as List)
        .map((item) => _setFromJson(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);
  }

  @override
  Future<void> saveQuestionSets(
    int noteId,
    QuestionFormat format,
    List<QuestionSet> sets,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _setsKey(noteId, format),
      jsonEncode(sets.map(_setJson).toList()),
    );
  }

  String _setsKey(int noteId, QuestionFormat format) =>
      '${_prefix}_sets_${noteId}_${format.apiValue}';

  @override
  Future<Map<int, int>> jobs() async {
    final prefs = await SharedPreferences.getInstance();
    final map = jsonDecode(prefs.getString(_jobsKey) ?? '{}') as Map;
    return map.map(
      (key, value) => MapEntry(int.parse(key as String), value as int),
    );
  }

  @override
  Future<void> saveJob(int noteId, int jobId) async {
    final jobs = await this.jobs();
    jobs[noteId] = jobId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _jobsKey,
      jsonEncode(jobs.map((key, value) => MapEntry('$key', value))),
    );
  }

  @override
  Future<void> removeJob(int noteId) async {
    final jobs = await this.jobs();
    jobs.remove(noteId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _jobsKey,
      jsonEncode(jobs.map((key, value) => MapEntry('$key', value))),
    );
  }

  Map<String, dynamic> _materialJson(StudyMaterial m) => {
    'id': m.id,
    'course_id': m.courseId,
    'course_label': m.courseLabel,
    'original_filename': m.filename,
    'size_bytes': m.sizeBytes,
    'uploaded_at': m.uploadedAt.toIso8601String(),
    'artifacts': m.artifacts == null
        ? null
        : {'questions': m.artifacts!.questions.map((e) => e.apiValue).toList()},
  };

  StudyMaterial _materialFromJson(Map<String, dynamic> json) =>
      StudyMaterialDto.fromJson(json).toEntity();
  Map<String, dynamic> _setJson(QuestionSet s) => {
    'id': s.id,
    'format': s.format.apiValue,
    'generated_at': s.generatedAt.toIso8601String(),
    'questions': s.questions
        .map(
          (q) => switch (q) {
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
        .toList(),
  };
  QuestionSet _setFromJson(Map<String, dynamic> json) =>
      QuestionSetDto.fromJson(json).toEntity();
}
