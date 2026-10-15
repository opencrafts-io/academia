import 'package:academia/features/chirp/posts/domain/domain.dart';

/// Which part of the draft an error refers to. `optionIndex` is set only for
/// [PollField.option].
enum PollField { question, options, option, endsAt }

class PollValidationError {
  final PollField field;
  final String message;
  final int? optionIndex;

  const PollValidationError(this.field, this.message, {this.optionIndex});

  @override
  String toString() =>
      '$field${optionIndex != null ? '[$optionIndex]' : ''}: $message';
}

/// Pure validation for a [PollDraft]. Mirrors the server-side rules in
/// docs/api/chirp-polls-contract.md so the modal can block bad input before
/// a request is made.
class PollValidator {
  static const int minQuestionLength = 3;
  static const int maxQuestionLength = 200;
  static const int minOptions = 2;
  static const int maxOptions = 10;
  static const int maxOptionLength = 100;
  static const Duration minDuration = Duration(minutes: 5);

  const PollValidator._();

  /// Returns every problem with [draft]; empty means valid.
  static List<PollValidationError> validate(PollDraft draft, {DateTime? now}) {
    final errors = <PollValidationError>[];
    final clock = now ?? DateTime.now();

    final question = draft.question.trim();
    if (question.isEmpty) {
      errors.add(
        const PollValidationError(PollField.question, 'Ask a question'),
      );
    } else if (question.length < minQuestionLength) {
      errors.add(
        const PollValidationError(
          PollField.question,
          'Question must be at least $minQuestionLength characters',
        ),
      );
    } else if (question.length > maxQuestionLength) {
      errors.add(
        const PollValidationError(
          PollField.question,
          'Question must be $maxQuestionLength characters or fewer',
        ),
      );
    }

    final options = draft.options.map((o) => o.trim()).toList();
    if (options.length < minOptions) {
      errors.add(
        const PollValidationError(
          PollField.options,
          'Add at least $minOptions options',
        ),
      );
    } else if (options.length > maxOptions) {
      errors.add(
        const PollValidationError(
          PollField.options,
          'A poll can have at most $maxOptions options',
        ),
      );
    }

    final seen = <String, int>{};
    for (var i = 0; i < options.length; i++) {
      final text = options[i];
      if (text.isEmpty) {
        errors.add(
          PollValidationError(
            PollField.option,
            'Option can\'t be empty',
            optionIndex: i,
          ),
        );
        continue;
      }
      if (text.length > maxOptionLength) {
        errors.add(
          PollValidationError(
            PollField.option,
            'Option must be $maxOptionLength characters or fewer',
            optionIndex: i,
          ),
        );
      }
      final key = text.toLowerCase();
      final firstIndex = seen[key];
      if (firstIndex != null) {
        errors.add(
          PollValidationError(
            PollField.option,
            'Duplicate of option ${firstIndex + 1}',
            optionIndex: i,
          ),
        );
      } else {
        seen[key] = i;
      }
    }

    final endsAt = draft.endsAt;
    if (endsAt != null && endsAt.isBefore(clock.add(minDuration))) {
      errors.add(
        const PollValidationError(
          PollField.endsAt,
          'End time must be at least 5 minutes from now',
        ),
      );
    }

    return errors;
  }

  static bool isValid(PollDraft draft, {DateTime? now}) =>
      validate(draft, now: now).isEmpty;

  /// First error for [field] (and [optionIndex] when given), or null.
  static String? messageFor(
    List<PollValidationError> errors,
    PollField field, {
    int? optionIndex,
  }) {
    for (final e in errors) {
      if (e.field == field &&
          (optionIndex == null || e.optionIndex == optionIndex)) {
        return e.message;
      }
    }
    return null;
  }

  /// A cleaned copy of [draft] ready for submission: trimmed question, trimmed
  /// options with empties dropped.
  static PollDraft normalize(PollDraft draft) => draft.copyWith(
    question: draft.question.trim(),
    options: draft.options
        .map((o) => o.trim())
        .where((o) => o.isNotEmpty)
        .toList(),
  );
}
