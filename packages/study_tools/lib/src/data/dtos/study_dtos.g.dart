// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyArtifactsDto _$StudyArtifactsDtoFromJson(Map<String, dynamic> json) =>
    _StudyArtifactsDto(
      summary: json['summary'] as bool? ?? false,
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$QuestionFormatEnumMap, e))
              .toSet() ??
          const <QuestionFormat>{},
      podcast: json['podcast'] as bool? ?? false,
      studyPlans:
          (json['study_plans'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
    );

Map<String, dynamic> _$StudyArtifactsDtoToJson(_StudyArtifactsDto instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'questions': instance.questions
          .map((e) => _$QuestionFormatEnumMap[e]!)
          .toList(),
      'podcast': instance.podcast,
      'study_plans': instance.studyPlans,
    };

const _$QuestionFormatEnumMap = {
  QuestionFormat.flashcard: 'flashcard',
  QuestionFormat.mcq: 'mcq',
  QuestionFormat.openEnded: 'open_ended',
};

_StudyMaterialDto _$StudyMaterialDtoFromJson(Map<String, dynamic> json) =>
    _StudyMaterialDto(
      id: (json['id'] as num).toInt(),
      courseId: json['course_id'] as String?,
      courseLabel: json['course_label'] as String? ?? '',
      filename: json['original_filename'] as String,
      sizeBytes: (json['size_bytes'] as num).toInt(),
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
      artifacts: json['artifacts'] == null
          ? null
          : StudyArtifactsDto.fromJson(
              json['artifacts'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$StudyMaterialDtoToJson(_StudyMaterialDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'course_label': instance.courseLabel,
      'original_filename': instance.filename,
      'size_bytes': instance.sizeBytes,
      'uploaded_at': instance.uploadedAt.toIso8601String(),
      'artifacts': instance.artifacts,
    };

_FlashcardQuestionDto _$FlashcardQuestionDtoFromJson(
  Map<String, dynamic> json,
) => _FlashcardQuestionDto(
  front: json['front'] as String,
  back: json['back'] as String,
);

Map<String, dynamic> _$FlashcardQuestionDtoToJson(
  _FlashcardQuestionDto instance,
) => <String, dynamic>{'front': instance.front, 'back': instance.back};

_MultipleChoiceQuestionDto _$MultipleChoiceQuestionDtoFromJson(
  Map<String, dynamic> json,
) => _MultipleChoiceQuestionDto(
  question: json['question'] as String,
  choices: (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
  answerIndex: (json['answer_index'] as num).toInt(),
  explanation: json['explanation'] as String? ?? '',
);

Map<String, dynamic> _$MultipleChoiceQuestionDtoToJson(
  _MultipleChoiceQuestionDto instance,
) => <String, dynamic>{
  'question': instance.question,
  'choices': instance.choices,
  'answer_index': instance.answerIndex,
  'explanation': instance.explanation,
};

_OpenEndedQuestionDto _$OpenEndedQuestionDtoFromJson(
  Map<String, dynamic> json,
) => _OpenEndedQuestionDto(
  question: json['question'] as String,
  modelAnswer: json['model_answer'] as String,
);

Map<String, dynamic> _$OpenEndedQuestionDtoToJson(
  _OpenEndedQuestionDto instance,
) => <String, dynamic>{
  'question': instance.question,
  'model_answer': instance.modelAnswer,
};

_GenerationJobDto _$GenerationJobDtoFromJson(Map<String, dynamic> json) =>
    _GenerationJobDto(
      id: (json['id'] as num).toInt(),
      noteId: (json['note_id'] as num?)?.toInt(),
      outputs: (json['outputs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      failureCode: json['failure_code'] as String?,
      failureMessage: json['failure_message'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
    );

Map<String, dynamic> _$GenerationJobDtoToJson(_GenerationJobDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note_id': instance.noteId,
      'outputs': instance.outputs,
      'status': instance.status,
      'failure_code': instance.failureCode,
      'failure_message': instance.failureMessage,
      'created_at': instance.createdAt.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
    };
