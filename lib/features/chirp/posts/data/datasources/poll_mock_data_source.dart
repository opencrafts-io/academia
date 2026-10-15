import 'dart:math';

import 'package:academia/core/core.dart';
import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value;

/// In-memory stand-in for the chirp polls backend.
///
/// Registered in DI until the real endpoints ship. Behaves like the contract
/// in docs/api/chirp-polls-contract.md: votes replace the caller's selection,
/// the whole poll is returned after every mutation, and voters are paginated.
///
/// Also decorates feed posts with a few seeded polls (see [decorateAll]) so
/// the feed has something to vote on without backend support.
class MockPollRemoteDataSource implements PollRemoteDataSource {
  /// Simulated network latency range.
  final Duration minLatency;
  final Duration maxLatency;

  /// When > 0, every Nth mutation fails with a [ServerFailure] so optimistic
  /// rollback paths can be exercised. 0 disables failures.
  final int failEveryNth;

  final Random _random = Random();
  int _mutationCount = 0;

  /// The voter id seen on the most recent mutation. Used to compute
  /// `my_votes` when decorating posts, since feed loads carry no user id.
  String? _lastKnownVoterId;

  /// pollId -> poll (without vote-derived fields; those are computed).
  final Map<int, PollData> _polls = {};

  /// pollId -> voterId -> selected option ids.
  final Map<int, Map<String, List<int>>> _votes = {};

  /// pollId -> voterId -> when they voted.
  final Map<int, Map<String, DateTime>> _votedAt = {};

  MockPollRemoteDataSource({
    this.minLatency = const Duration(milliseconds: 300),
    this.maxLatency = const Duration(milliseconds: 600),
    this.failEveryNth = 0,
  });

  // ---------------------------------------------------------------------------
  // Contract
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, PollData>> vote({
    required int pollId,
    required String voterId,
    required List<int> optionIds,
  }) async {
    await _sleep();
    _lastKnownVoterId = voterId;

    final poll = _polls[pollId];
    if (poll == null) {
      return left(NetworkFailure(message: 'Poll not found', error: 'poll'));
    }
    if (_shouldFail()) {
      return left(
        ServerFailure(message: 'Simulated vote failure', error: 'poll'),
      );
    }
    if (optionIds.isEmpty) {
      return left(
        NetworkFailure(message: 'option_ids must not be empty', error: 'poll'),
      );
    }
    if (!poll.allowsMultiple && optionIds.length > 1) {
      return left(
        NetworkFailure(
          message: 'This poll only allows a single choice',
          error: 'poll',
        ),
      );
    }
    final validIds = poll.options.map((o) => o.id).toSet();
    if (!optionIds.every(validIds.contains)) {
      return left(
        NetworkFailure(message: 'Unknown option for this poll', error: 'poll'),
      );
    }
    if (poll.endsAt != null && poll.endsAt!.isBefore(DateTime.now())) {
      return left(
        NetworkFailure(message: 'This poll has closed', error: 'poll'),
      );
    }

    _votes.putIfAbsent(pollId, () => {})[voterId] = List.of(optionIds);
    _votedAt.putIfAbsent(pollId, () => {})[voterId] = DateTime.now();
    return right(_materialize(pollId, voterId));
  }

  @override
  Future<Either<Failure, PollData>> retractVote({
    required int pollId,
    required String voterId,
  }) async {
    await _sleep();
    _lastKnownVoterId = voterId;

    final poll = _polls[pollId];
    if (poll == null) {
      return left(NetworkFailure(message: 'Poll not found', error: 'poll'));
    }
    if (_shouldFail()) {
      return left(
        ServerFailure(message: 'Simulated retract failure', error: 'poll'),
      );
    }
    // Final results stay final — matches the backend's 400 on closed polls.
    if (poll.endsAt != null && poll.endsAt!.isBefore(DateTime.now())) {
      return left(
        NetworkFailure(message: 'This poll has closed', error: 'poll'),
      );
    }

    _votes[pollId]?.remove(voterId);
    _votedAt[pollId]?.remove(voterId);
    return right(_materialize(pollId, voterId));
  }

  @override
  Future<Either<Failure, PaginatedData<PollVoterData>>> getVoters({
    required int pollId,
    int? optionId,
    required int page,
    required int pageSize,
  }) async {
    await _sleep();

    if (!_polls.containsKey(pollId)) {
      return left(NetworkFailure(message: 'Poll not found', error: 'poll'));
    }

    final votes = _votes[pollId] ?? {};
    final stamps = _votedAt[pollId] ?? {};
    final all =
        votes.entries
            .where((e) => optionId == null || e.value.contains(optionId))
            .map(
              (e) => PollVoterData(
                userId: e.key,
                optionIds: List.of(e.value),
                votedAt: stamps[e.key] ?? DateTime.now(),
              ),
            )
            .toList()
          ..sort((a, b) => b.votedAt.compareTo(a.votedAt));

    final start = (page - 1) * pageSize;
    final slice = start >= all.length
        ? <PollVoterData>[]
        : all.sublist(start, min(start + pageSize, all.length));
    final hasNext = start + pageSize < all.length;

    return right(
      PaginatedData(
        results: slice,
        count: all.length,
        next: hasNext ? 'mock://polls/$pollId/voters?page=${page + 1}' : null,
        previous: page > 1
            ? 'mock://polls/$pollId/voters?page=${page - 1}'
            : null,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Feed decoration
  // ---------------------------------------------------------------------------

  /// Registers any poll already present on [post] (e.g. from a create call)
  /// and, for a deterministic subset of posts, attaches a seeded demo poll.
  /// Returns the post with an up-to-date `poll` blob.
  db.Post decorate(db.Post post) {
    final existing = post.poll;
    if (existing != null && existing.isNotEmpty) {
      final data = PollData.fromJson(existing);
      _register(data, seedVoters: false);
      return post.copyWith(
        poll: Value(_materialize(data.id, _lastKnownVoterId).toJson()),
      );
    }

    // Seed a poll on every third post so the feed always has a few to try.
    if (post.id % 3 != 0) return post;

    final pollId = _seedPollId(post.id);
    if (!_polls.containsKey(pollId)) {
      _register(_seedFor(post.id), seedVoters: true);
    }
    return post.copyWith(
      poll: Value(_materialize(pollId, _lastKnownVoterId).toJson()),
    );
  }

  List<db.Post> decorateAll(List<db.Post> posts) =>
      posts.map(decorate).toList();

  /// Builds the poll a freshly created post should carry. The real backend
  /// would do this server-side; here we mint ids and register it.
  db.Post attachDraft(db.Post post, PollDraft draft) {
    final pollId = _seedPollId(post.id);
    final data = PollData(
      id: pollId,
      postId: post.id,
      question: draft.question,
      allowsMultiple: draft.allowsMultiple,
      isAnonymous: draft.isAnonymous,
      endsAt: draft.endsAt,
      options: [
        for (var i = 0; i < draft.options.length; i++)
          PollOptionData(
            id: pollId * 10 + i,
            text: draft.options[i],
            position: i,
          ),
      ],
    );
    _register(data, seedVoters: false);
    return post.copyWith(
      poll: Value(_materialize(pollId, _lastKnownVoterId).toJson()),
    );
  }

  // ---------------------------------------------------------------------------
  // Internals
  // ---------------------------------------------------------------------------

  int _seedPollId(int postId) => 100000 + postId;

  void _register(PollData poll, {required bool seedVoters}) {
    if (_polls.containsKey(poll.id)) return;
    _polls[poll.id] = poll;
    _votes[poll.id] = {};
    _votedAt[poll.id] = {};

    if (!seedVoters) return;
    // Spread some fake voters across the options so bars aren't all zero.
    final optionIds = poll.options.map((o) => o.id).toList();
    if (optionIds.isEmpty) return;
    final voterCount = 6 + _random.nextInt(14);
    for (var v = 0; v < voterCount; v++) {
      final voterId = 'mock-voter-${poll.id}-$v';
      final picks = <int>{};
      picks.add(optionIds[_weightedIndex(optionIds.length)]);
      if (poll.allowsMultiple && _random.nextBool()) {
        picks.add(optionIds[_random.nextInt(optionIds.length)]);
      }
      _votes[poll.id]![voterId] = picks.toList();
      _votedAt[poll.id]![voterId] = DateTime.now().subtract(
        Duration(minutes: _random.nextInt(60 * 24)),
      );
    }
  }

  /// Skews votes toward earlier options so results look plausible.
  int _weightedIndex(int n) {
    final r = _random.nextDouble();
    return min(n - 1, (r * r * n).floor());
  }

  PollData _seedFor(int postId) {
    final pollId = _seedPollId(postId);
    final variant = (postId ~/ 3) % 4;
    late final String question;
    late final List<String> options;
    var allowsMultiple = false;
    var isAnonymous = false;
    DateTime? endsAt;

    switch (variant) {
      case 0:
        question = 'Which unit should we revise first this week?';
        options = ['Calculus II', 'Databases', 'Operating Systems', 'Networks'];
        endsAt = DateTime.now().add(const Duration(days: 2, hours: 5));
      case 1:
        question = 'What days work for the study group? (pick all that apply)';
        options = ['Monday', 'Wednesday', 'Friday', 'Saturday'];
        allowsMultiple = true;
      case 2:
        question = 'Did the mock exam feel fair?';
        options = ['Yes', 'No', 'Somewhat'];
        isAnonymous = true;
      default:
        question = 'Best spot on campus for late-night study?';
        options = ['Main library', 'Engineering block', 'Hostel common room'];
        endsAt = DateTime.now().subtract(const Duration(hours: 3));
    }

    return PollData(
      id: pollId,
      postId: postId,
      question: question,
      allowsMultiple: allowsMultiple,
      isAnonymous: isAnonymous,
      endsAt: endsAt,
      options: [
        for (var i = 0; i < options.length; i++)
          PollOptionData(id: pollId * 10 + i, text: options[i], position: i),
      ],
    );
  }

  /// Computes vote-derived fields for [pollId] from the vote map.
  PollData _materialize(int pollId, String? voterId) {
    final base = _polls[pollId]!;
    final votes = _votes[pollId] ?? {};
    final counts = <int, int>{for (final o in base.options) o.id: 0};
    for (final selection in votes.values) {
      for (final id in selection) {
        if (counts.containsKey(id)) counts[id] = counts[id]! + 1;
      }
    }
    return PollData(
      id: base.id,
      postId: base.postId,
      question: base.question,
      allowsMultiple: base.allowsMultiple,
      isAnonymous: base.isAnonymous,
      endsAt: base.endsAt,
      totalVotes: votes.length,
      myVotes: voterId == null ? const [] : List.of(votes[voterId] ?? const []),
      options: base.options
          .map(
            (o) => PollOptionData(
              id: o.id,
              text: o.text,
              position: o.position,
              voteCount: counts[o.id] ?? 0,
            ),
          )
          .toList(),
    );
  }

  bool _shouldFail() {
    _mutationCount++;
    return failEveryNth > 0 && _mutationCount % failEveryNth == 0;
  }

  Future<void> _sleep() {
    final span = maxLatency.inMilliseconds - minLatency.inMilliseconds;
    final ms =
        minLatency.inMilliseconds + (span > 0 ? _random.nextInt(span) : 0);
    return Future.delayed(Duration(milliseconds: ms));
  }
}
