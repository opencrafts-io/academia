import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/study_entities.dart';

part 'study_dtos.freezed.dart';
part 'study_dtos.g.dart';

@freezed
abstract class StudyArtifactsDto with _$StudyArtifactsDto {
  const factory StudyArtifactsDto({
    @Default(false) bool summary,
    @Default(<QuestionFormat>{}) Set<QuestionFormat> questions,
    @Default(false) bool podcast,
    @JsonKey(name: 'study_plans') @Default(<int>[]) List<int> studyPlans,
  }) = _StudyArtifactsDto;

  factory StudyArtifactsDto.fromJson(Map<String, dynamic> json) =>
      _$StudyArtifactsDtoFromJson(json);
}

extension StudyArtifactsDtoMapper on StudyArtifactsDto {
  StudyArtifacts toEntity() => StudyArtifacts(
    summary: summary,
    questions: questions,
    podcast: podcast,
    studyPlans: studyPlans,
  );
}

@freezed
abstract class StudyMaterialDto with _$StudyMaterialDto {
  const factory StudyMaterialDto({
    required int id,
    @JsonKey(name: 'course_id') required String? courseId,
    @JsonKey(name: 'course_label') @Default('') String courseLabel,
    @JsonKey(name: 'original_filename') required String filename,
    @JsonKey(name: 'size_bytes') required int sizeBytes,
    @JsonKey(name: 'uploaded_at') required DateTime uploadedAt,
    StudyArtifactsDto? artifacts,
  }) = _StudyMaterialDto;

  factory StudyMaterialDto.fromJson(Map<String, dynamic> json) =>
      _$StudyMaterialDtoFromJson(json);
}

extension StudyMaterialDtoMapper on StudyMaterialDto {
  StudyMaterial toEntity() => StudyMaterial(
    id: id,
    courseId: courseId,
    courseLabel: courseLabel,
    filename: filename,
    sizeBytes: sizeBytes,
    uploadedAt: uploadedAt,
    artifacts: artifacts?.toEntity(),
  );
}

@freezed
abstract class FlashcardQuestionDto with _$FlashcardQuestionDto {
  const factory FlashcardQuestionDto({
    required String front,
    required String back,
  }) = _FlashcardQuestionDto;

  factory FlashcardQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$FlashcardQuestionDtoFromJson(json);
}

extension FlashcardQuestionDtoMapper on FlashcardQuestionDto {
  StudyQuestion toEntity() => StudyQuestion.flashcard(front: front, back: back);
}

@freezed
abstract class MultipleChoiceQuestionDto with _$MultipleChoiceQuestionDto {
  const factory MultipleChoiceQuestionDto({
    required String question,
    required List<String> choices,
    @JsonKey(name: 'answer_index') required int answerIndex,
    @Default('') String explanation,
  }) = _MultipleChoiceQuestionDto;

  factory MultipleChoiceQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceQuestionDtoFromJson(json);
}

extension MultipleChoiceQuestionDtoMapper on MultipleChoiceQuestionDto {
  StudyQuestion toEntity() => StudyQuestion.mcq(
    question: question,
    choices: choices,
    answerIndex: answerIndex,
    explanation: explanation,
  );
}

@freezed
abstract class OpenEndedQuestionDto with _$OpenEndedQuestionDto {
  const factory OpenEndedQuestionDto({
    required String question,
    @JsonKey(name: 'model_answer') required String modelAnswer,
  }) = _OpenEndedQuestionDto;

  factory OpenEndedQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$OpenEndedQuestionDtoFromJson(json);
}

extension OpenEndedQuestionDtoMapper on OpenEndedQuestionDto {
  StudyQuestion toEntity() =>
      StudyQuestion.openEnded(question: question, modelAnswer: modelAnswer);
}

@freezed
abstract class QuestionSetDto with _$QuestionSetDto {
  const factory QuestionSetDto({
    required int id,
    required QuestionFormat format,
    @JsonKey(name: 'generated_at') required DateTime generatedAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(<StudyQuestion>[])
    List<StudyQuestion> questions,
  }) = _QuestionSetDto;

  factory QuestionSetDto.fromJson(Map<String, dynamic> json) {
    final format = QuestionFormatApi.parse(json['format'] as String);
    final rawQuestions = json['questions'] as List<dynamic>;
    final questions = rawQuestions
        .map((raw) {
          final item = Map<String, dynamic>.from(raw as Map);
          return switch (format) {
            QuestionFormat.flashcard => FlashcardQuestionDto.fromJson(
              item,
            ).toEntity(),
            QuestionFormat.mcq => MultipleChoiceQuestionDto.fromJson(
              item,
            ).toEntity(),
            QuestionFormat.openEnded => OpenEndedQuestionDto.fromJson(
              item,
            ).toEntity(),
          };
        })
        .toList(growable: false);
    return QuestionSetDto(
      id: json['id'] as int,
      format: format,
      generatedAt: DateTime.parse(json['generated_at'] as String),
      questions: questions,
    );
  }
}

extension QuestionSetDtoMapper on QuestionSetDto {
  QuestionSet toEntity() => QuestionSet(
    id: id,
    format: format,
    generatedAt: generatedAt,
    questions: questions,
  );
}

@freezed
abstract class GenerationJobDto with _$GenerationJobDto {
  const factory GenerationJobDto({
    required int id,
    @JsonKey(name: 'note_id') required int? noteId,
    required List<String> outputs,
    required String status,
    @JsonKey(name: 'failure_code') required String? failureCode,
    @JsonKey(name: 'failure_message') required String? failureMessage,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'finished_at') required DateTime? finishedAt,
  }) = _GenerationJobDto;

  factory GenerationJobDto.fromJson(Map<String, dynamic> json) =>
      _$GenerationJobDtoFromJson(json);
}

extension GenerationJobDtoMapper on GenerationJobDto {
  GenerationJob toEntity() => GenerationJob(
    id: id,
    noteId: noteId,
    outputs: outputs,
    status: status,
    failureCode: failureCode,
    failureMessage: failureMessage,
    createdAt: createdAt,
    finishedAt: finishedAt,
  );
}
