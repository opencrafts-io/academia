import 'package:equatable/equatable.dart';

/// A single selectable option in a [Poll].
class PollOption extends Equatable {
  final int id;
  final String text;
  final int voteCount;

  /// Zero-based display order.
  final int position;

  const PollOption({
    required this.id,
    required this.text,
    this.voteCount = 0,
    required this.position,
  });

  PollOption copyWith({int? id, String? text, int? voteCount, int? position}) {
    return PollOption(
      id: id ?? this.id,
      text: text ?? this.text,
      voteCount: voteCount ?? this.voteCount,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [id, text, voteCount, position];
}

/// A poll attached to a [Post].
class Poll extends Equatable {
  final int id;
  final int postId;
  final String question;
  final List<PollOption> options;
  final bool allowsMultiple;
  final bool isAnonymous;
  final DateTime? endsAt;

  /// Number of distinct voters (not the sum of option counts — a voter in a
  /// multi-select poll contributes to several options but counts once here).
  final int totalVotes;

  /// Option ids the current user has selected.
  final List<int> myVotes;

  const Poll({
    required this.id,
    required this.postId,
    required this.question,
    required this.options,
    this.allowsMultiple = false,
    this.isAnonymous = false,
    this.endsAt,
    this.totalVotes = 0,
    this.myVotes = const [],
  });

  bool get isClosed => endsAt != null && endsAt!.isBefore(DateTime.now());

  bool get hasVoted => myVotes.isNotEmpty;

  /// Results are visible once the user has voted or the poll has closed.
  bool get showsResults => hasVoted || isClosed;

  /// Options sorted by [PollOption.position].
  List<PollOption> get sortedOptions {
    final list = List<PollOption>.from(options);
    list.sort((a, b) => a.position.compareTo(b.position));
    return list;
  }

  /// Share of voters (0.0 – 1.0) that picked [option]. Safe when no votes.
  double fractionFor(PollOption option) {
    if (totalVotes <= 0) return 0;
    return (option.voteCount / totalVotes).clamp(0.0, 1.0);
  }

  /// Integer percentage for display. Uses largest-remainder rounding so the
  /// percentages sum to 100 for single-select polls (for multi-select polls the
  /// sum is naturally > 100, so plain rounding is used).
  Map<int, int> get percentages {
    if (totalVotes <= 0) return {for (final o in options) o.id: 0};
    if (allowsMultiple) {
      return {for (final o in options) o.id: (fractionFor(o) * 100).round()};
    }
    final raw = {for (final o in options) o.id: fractionFor(o) * 100};
    final floored = {for (final e in raw.entries) e.key: e.value.floor()};
    var remainder = 100 - floored.values.fold<int>(0, (a, b) => a + b);
    final byRemainder = raw.keys.toList()
      ..sort(
        (a, b) => (raw[b]! - floored[b]!).compareTo(raw[a]! - floored[a]!),
      );
    for (final id in byRemainder) {
      if (remainder <= 0) break;
      floored[id] = floored[id]! + 1;
      remainder--;
    }
    return floored;
  }

  Poll copyWith({
    int? id,
    int? postId,
    String? question,
    List<PollOption>? options,
    bool? allowsMultiple,
    bool? isAnonymous,
    DateTime? endsAt,
    bool clearEndsAt = false,
    int? totalVotes,
    List<int>? myVotes,
  }) {
    return Poll(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      question: question ?? this.question,
      options: options ?? this.options,
      allowsMultiple: allowsMultiple ?? this.allowsMultiple,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      endsAt: clearEndsAt ? null : (endsAt ?? this.endsAt),
      totalVotes: totalVotes ?? this.totalVotes,
      myVotes: myVotes ?? this.myVotes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    postId,
    question,
    options,
    allowsMultiple,
    isAnonymous,
    endsAt,
    totalVotes,
    myVotes,
  ];
}

/// A voter row returned by the "view votes" endpoint.
class PollVoter extends Equatable {
  final String userId;
  final List<int> optionIds;
  final DateTime votedAt;

  const PollVoter({
    required this.userId,
    required this.optionIds,
    required this.votedAt,
  });

  @override
  List<Object?> get props => [userId, optionIds, votedAt];
}

/// What the creation modal produces and what gets sent with a new post.
/// Options are plain strings — ids are assigned by the server.
class PollDraft extends Equatable {
  final String question;
  final List<String> options;
  final bool allowsMultiple;
  final bool isAnonymous;
  final DateTime? endsAt;

  const PollDraft({
    required this.question,
    required this.options,
    this.allowsMultiple = false,
    this.isAnonymous = false,
    this.endsAt,
  });

  PollDraft copyWith({
    String? question,
    List<String>? options,
    bool? allowsMultiple,
    bool? isAnonymous,
    DateTime? endsAt,
    bool clearEndsAt = false,
  }) {
    return PollDraft(
      question: question ?? this.question,
      options: options ?? this.options,
      allowsMultiple: allowsMultiple ?? this.allowsMultiple,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      endsAt: clearEndsAt ? null : (endsAt ?? this.endsAt),
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'allows_multiple': allowsMultiple,
    'is_anonymous': isAnonymous,
    'ends_at': endsAt?.toUtc().toIso8601String(),
    'options': [
      for (var i = 0; i < options.length; i++)
        {'text': options[i], 'position': i},
    ],
  };

  @override
  List<Object?> get props => [
    question,
    options,
    allowsMultiple,
    isAnonymous,
    endsAt,
  ];
}
