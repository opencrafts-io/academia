import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_entities.freezed.dart';

enum StudyGenerationOutput { questions, podcast }

enum GenerationJobStatus { pending, processing, done, failed, unknown }

extension GenerationJobStatusApi on GenerationJobStatus {
  static GenerationJobStatus parse(String? value) => switch (value
      ?.toLowerCase()) {
    'queued' || 'pending' => GenerationJobStatus.pending,
    'processing' || 'running' => GenerationJobStatus.processing,
    'done' || 'completed' => GenerationJobStatus.done,
    'failed' || 'error' => GenerationJobStatus.failed,
    _ => GenerationJobStatus.unknown,
  };
}

const studyUploadMaxBytes = 20 * 1024 * 1024;
const studyUploadExtensions = {'pdf', 'docx', 'pptx', 'xlsx', 'xls'};

String? validateStudyUpload(String filename, int sizeBytes) {
  final extension = filename.contains('.')
      ? filename.split('.').last.toLowerCase()
      : '';
  if (!studyUploadExtensions.contains(extension)) {
    return 'Choose a PDF, DOCX, PPTX, XLSX, or XLS file.';
  }
  if (sizeBytes > studyUploadMaxBytes) {
    return 'The file must be 20 MB or smaller.';
  }
  return null;
}

enum QuestionFormat {
  flashcard,
  mcq,
  @JsonValue('open_ended')
  openEnded,
}

extension QuestionFormatApi on QuestionFormat {
  String get apiValue => switch (this) {
    QuestionFormat.flashcard => 'flashcard',
    QuestionFormat.mcq => 'mcq',
    QuestionFormat.openEnded => 'open_ended',
  };

  String get label => switch (this) {
    QuestionFormat.flashcard => 'Flashcards',
    QuestionFormat.mcq => 'Multiple choice',
    QuestionFormat.openEnded => 'Open-ended',
  };

  static QuestionFormat parse(String value) => switch (value) {
    'flashcard' => QuestionFormat.flashcard,
    'mcq' => QuestionFormat.mcq,
    'open_ended' => QuestionFormat.openEnded,
    _ => throw FormatException('Unsupported question format: $value'),
  };
}

@freezed
abstract class StudyCourseOption with _$StudyCourseOption {
  const factory StudyCourseOption({
    required String id,
    required String title,
    String? professorId,
  }) = _StudyCourseOption;
}

@freezed
abstract class StudyMaterial with _$StudyMaterial {
  const factory StudyMaterial({
    required int id,
    required String? courseId,
    required String courseLabel,
    required String filename,
    required int sizeBytes,
    required DateTime uploadedAt,
    StudyArtifacts? artifacts,
  }) = _StudyMaterial;
}

@freezed
abstract class StudyArtifacts with _$StudyArtifacts {
  const factory StudyArtifacts({
    @Default(false) bool summary,
    @Default(<QuestionFormat>{}) Set<QuestionFormat> questions,
    @Default(false) bool podcast,
    @Default(<int>[]) List<int> studyPlans,
  }) = _StudyArtifacts;
}

@freezed
sealed class StudyQuestion with _$StudyQuestion {
  const factory StudyQuestion.flashcard({
    required String front,
    required String back,
  }) = FlashcardQuestion;
  const factory StudyQuestion.mcq({
    required String question,
    required List<String> choices,
    required int answerIndex,
    required String explanation,
  }) = MultipleChoiceQuestion;
  const factory StudyQuestion.openEnded({
    required String question,
    required String modelAnswer,
  }) = OpenEndedQuestion;
}

@freezed
abstract class QuestionSet with _$QuestionSet {
  const factory QuestionSet({
    required int id,
    required QuestionFormat format,
    required DateTime generatedAt,
    required List<StudyQuestion> questions,
  }) = _QuestionSet;
}

@freezed
abstract class GenerationJob with _$GenerationJob {
  const factory GenerationJob({
    required int id,
    required int? noteId,
    required List<String> outputs,
    required GenerationJobStatus status,
    required String? failureCode,
    required String? failureMessage,
    required DateTime createdAt,
    required DateTime? finishedAt,
  }) = _GenerationJob;
}

@freezed
abstract class StudyPodcast with _$StudyPodcast {
  const factory StudyPodcast({
    required int? id,
    required int noteId,
    @Default('') String title,
    required DateTime generatedAt,
    required Duration duration,
    required String audioUrl,
    required String script,
  }) = _StudyPodcast;
}

enum PodcastDownloadStatus { downloading, ready, failed }

@freezed
abstract class PodcastDownloadedEpisode with _$PodcastDownloadedEpisode {
  const factory PodcastDownloadedEpisode({
    required String environment,
    required String accountId,
    required int noteId,
    required String episodeKey,
    required String title,
    required String courseLabel,
    required String localPath,
    required int sizeBytes,
    required Duration duration,
    required DateTime? downloadedAt,
    required PodcastDownloadStatus status,
  }) = _PodcastDownloadedEpisode;
}
