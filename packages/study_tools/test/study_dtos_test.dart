import 'package:flutter_test/flutter_test.dart';
import 'package:study_tools/src/data/dtos/study_dtos.dart';
import 'package:study_tools/src/domain/entities/study_entities.dart';

void main() {
  test('accepts supported extensions and the 20 MB size limit', () {
    expect(validateStudyUpload('course.PDF', studyUploadMaxBytes), isNull);
    expect(validateStudyUpload('slides.pptx', 10), isNull);
    expect(validateStudyUpload('archive.zip', 10), contains('PDF'));
    expect(
      validateStudyUpload('large.xlsx', studyUploadMaxBytes + 1),
      contains('20 MB'),
    );
  });

  test('maps flashcards from the format-scoped question payload', () {
    final set = QuestionSetDto.fromJson({
      'id': 8,
      'format': 'flashcard',
      'generated_at': '2026-10-01T12:00:00Z',
      'questions': [
        {'front': 'Define a stack', 'back': 'A LIFO data structure'},
      ],
    }).toEntity();

    expect(set.format, QuestionFormat.flashcard);
    expect(set.questions.single, isA<FlashcardQuestion>());
    expect(
      (set.questions.single as FlashcardQuestion).back,
      'A LIFO data structure',
    );
  });

  test('maps MCQ answer indexes and arbitrary choice counts', () {
    final set = QuestionSetDto.fromJson({
      'id': 9,
      'format': 'mcq',
      'generated_at': '2026-10-02T12:00:00Z',
      'questions': [
        {
          'question': 'Which is correct?',
          'choices': ['A', 'B', 'C'],
          'answer_index': 2,
          'explanation': 'C is correct.',
        },
      ],
    }).toEntity();
    final question = set.questions.single as MultipleChoiceQuestion;

    expect(question.choices, hasLength(3));
    expect(question.answerIndex, 2);
    expect(question.explanation, 'C is correct.');
  });

  test('keeps nullable job fields and open-ended answers typed', () {
    final job = GenerationJobDto.fromJson({
      'id': 18,
      'note_id': null,
      'outputs': ['questions'],
      'status': 'pending',
      'failure_code': null,
      'failure_message': null,
      'created_at': '2026-10-03T12:00:00Z',
      'finished_at': null,
    }).toEntity();
    final set = QuestionSetDto.fromJson({
      'id': 10,
      'format': 'open_ended',
      'generated_at': '2026-10-03T12:00:00Z',
      'questions': [
        {
          'question': 'Explain recursion',
          'model_answer': 'A function calls itself.',
        },
      ],
    }).toEntity();

    expect(job.noteId, isNull);
    expect(job.finishedAt, isNull);
    expect(set.questions.single, isA<OpenEndedQuestion>());
  });

  test('decodes metadata and nullable course association', () {
    final material = StudyMaterialDto.fromJson({
      'id': 2,
      'course_id': null,
      'course_label': '',
      'original_filename': 'notes.pdf',
      'size_bytes': 1024,
      'uploaded_at': '2026-10-03T12:00:00Z',
    }).toEntity();

    expect(material.courseId, isNull);
    expect(material.filename, 'notes.pdf');
    expect(material.sizeBytes, 1024);
  });

  test('decodes podcast metadata with additive identity and title', () {
    final podcast = PodcastDto.fromJson({
      'id': 94,
      'note_id': 2,
      'title': 'A gentle introduction to Algorithms',
      'generated_at': '2026-10-03T12:00:00Z',
      'duration_seconds': 403.5,
      'audio_url': 'https://media.example.test/audio.mp3?sig=private',
      'script': 'Host: Let us begin.',
    }).toEntity();

    expect(podcast.id, 94);
    expect(podcast.noteId, 2);
    expect(podcast.title, 'A gentle introduction to Algorithms');
    expect(podcast.duration.inSeconds, 403);
    expect(podcast.audioUrl, startsWith('https://media.example.test/'));
    expect(podcast.script, 'Host: Let us begin.');
  });

  test('decodes legacy podcast responses without title or id', () {
    final podcast = PodcastDto.fromJson({
      'note_id': 2,
      'generated_at': '2026-10-03T12:00:00Z',
      'duration_seconds': 0,
      'audio_url': '/media/podcast.mp3',
      'script': 'Host: Hello.',
    }).toEntity();

    expect(podcast.id, isNull);
    expect(podcast.title, isEmpty);
    expect(podcast.duration, Duration.zero);
  });
}
