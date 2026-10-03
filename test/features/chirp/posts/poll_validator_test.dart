import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 9, 11, 12);

  PollDraft draft({
    String question = 'Which unit first?',
    List<String> options = const ['Calculus', 'Databases'],
    DateTime? endsAt,
  }) => PollDraft(question: question, options: options, endsAt: endsAt);

  group('PollValidator', () {
    test('accepts a minimal valid draft', () {
      expect(PollValidator.validate(draft(), now: now), isEmpty);
    });

    test('rejects an empty or whitespace question', () {
      final errors = PollValidator.validate(draft(question: '   '), now: now);
      expect(
        PollValidator.messageFor(errors, PollField.question),
        'Ask a question',
      );
    });

    test('rejects a question shorter than 3 characters', () {
      final errors = PollValidator.validate(draft(question: 'Hi'), now: now);
      expect(PollValidator.messageFor(errors, PollField.question), isNotNull);
    });

    test('rejects a question longer than 200 characters', () {
      final errors = PollValidator.validate(
        draft(question: 'x' * 201),
        now: now,
      );
      expect(PollValidator.messageFor(errors, PollField.question), isNotNull);
    });

    test('requires at least two options', () {
      final errors = PollValidator.validate(
        draft(options: ['Only one']),
        now: now,
      );
      expect(
        PollValidator.messageFor(errors, PollField.options),
        'Add at least 2 options',
      );
    });

    test('caps options at ten', () {
      final errors = PollValidator.validate(
        draft(options: List.generate(11, (i) => 'Option $i')),
        now: now,
      );
      expect(PollValidator.messageFor(errors, PollField.options), isNotNull);
    });

    test('flags empty options by index', () {
      final errors = PollValidator.validate(
        draft(options: ['A', '  ', 'C']),
        now: now,
      );
      expect(
        PollValidator.messageFor(errors, PollField.option, optionIndex: 1),
        'Option can\'t be empty',
      );
      expect(
        PollValidator.messageFor(errors, PollField.option, optionIndex: 0),
        isNull,
      );
    });

    test('flags case-insensitive duplicates after trimming', () {
      final errors = PollValidator.validate(
        draft(options: ['Calculus', ' calculus ', 'Databases']),
        now: now,
      );
      expect(
        PollValidator.messageFor(errors, PollField.option, optionIndex: 1),
        'Duplicate of option 1',
      );
      expect(
        PollValidator.messageFor(errors, PollField.option, optionIndex: 0),
        isNull,
      );
    });

    test('rejects an end time less than 5 minutes away', () {
      final errors = PollValidator.validate(
        draft(endsAt: now.add(const Duration(minutes: 4))),
        now: now,
      );
      expect(PollValidator.messageFor(errors, PollField.endsAt), isNotNull);
    });

    test('accepts an end time 5 minutes or more away', () {
      final errors = PollValidator.validate(
        draft(endsAt: now.add(const Duration(minutes: 5))),
        now: now,
      );
      expect(errors, isEmpty);
    });

    test('normalize trims and drops empty options', () {
      final normalized = PollValidator.normalize(
        draft(question: '  Q?  ', options: [' A ', '', 'B', '   ']),
      );
      expect(normalized.question, 'Q?');
      expect(normalized.options, ['A', 'B']);
    });

    test('reports multiple problems at once', () {
      final errors = PollValidator.validate(
        draft(question: '', options: ['A', 'a']),
        now: now,
      );
      expect(errors.length, 2);
    });
  });
}
