import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MockPollRemoteDataSource ds({int failEveryNth = 0}) =>
      MockPollRemoteDataSource(
        minLatency: Duration.zero,
        maxLatency: Duration.zero,
        failEveryNth: failEveryNth,
      );

  db.Post post(int id) => db.Post(
    id: id,
    community: const {},
    authorId: 'a',
    title: 't',
    content: 'c',
    upvotes: 0,
    downvotes: 0,
    attachments: const [],
    viewsCount: 0,
    commentCount: 0,
    comments: const [],
    poll: null,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  group('MockPollRemoteDataSource', () {
    test(
      'decorates every third post with a seeded poll, deterministically',
      () {
        final mock = ds();
        final decorated = mock.decorateAll([
          for (var i = 1; i <= 6; i++) post(i),
        ]);
        expect(decorated.map((p) => p.poll != null), [
          false,
          false,
          true,
          false,
          false,
          true,
        ]);
        final poll = PollData.fromJson(decorated[2].poll!);
        expect(poll.postId, 3);
        expect(poll.options.length, greaterThanOrEqualTo(2));
        expect(poll.totalVotes, greaterThan(0));
        // Same post again → same poll id and options.
        final again = PollData.fromJson(mock.decorate(post(3)).poll!);
        expect(again.id, poll.id);
        expect(again.options.map((o) => o.id), poll.options.map((o) => o.id));
      },
    );

    test(
      'vote replaces selection, retract clears it, totals track distinct voters',
      () async {
        final mock = ds();
        final poll = PollData.fromJson(mock.decorate(post(3)).poll!);
        final before = poll.totalVotes;
        final a = poll.options[0].id;
        final b = poll.options[1].id;

        var res = await mock.vote(
          pollId: poll.id,
          voterId: 'me',
          optionIds: [a],
        );
        var updated = res.getOrElse(() => throw StateError('failed'));
        expect(updated.myVotes, [a]);
        expect(updated.totalVotes, before + 1);
        final countA = updated.options.firstWhere((o) => o.id == a).voteCount;

        res = await mock.vote(pollId: poll.id, voterId: 'me', optionIds: [b]);
        updated = res.getOrElse(() => throw StateError('failed'));
        expect(updated.myVotes, [b]);
        expect(updated.totalVotes, before + 1);
        expect(
          updated.options.firstWhere((o) => o.id == a).voteCount,
          countA - 1,
        );

        res = await mock.retractVote(pollId: poll.id, voterId: 'me');
        updated = res.getOrElse(() => throw StateError('failed'));
        expect(updated.myVotes, isEmpty);
        expect(updated.totalVotes, before);

        // Decorating again reflects the last known voter's state.
        final redecorated = PollData.fromJson(mock.decorate(post(3)).poll!);
        expect(redecorated.myVotes, isEmpty);
        expect(redecorated.totalVotes, before);
      },
    );

    test(
      'rejects multiple ids on a single-choice poll and unknown ids',
      () async {
        final mock = ds();
        // Post 12 → variant 0 → seeded single-choice poll.
        final poll = PollData.fromJson(mock.decorate(post(12)).poll!);
        expect(poll.allowsMultiple, isFalse);
        final ids = poll.options.map((o) => o.id).toList();

        final multi = await mock.vote(
          pollId: poll.id,
          voterId: 'me',
          optionIds: [ids[0], ids[1]],
        );
        expect(multi.isLeft(), isTrue);

        final unknown = await mock.vote(
          pollId: poll.id,
          voterId: 'me',
          optionIds: [999999],
        );
        expect(unknown.isLeft(), isTrue);

        final missing = await mock.vote(
          pollId: 42,
          voterId: 'me',
          optionIds: [1],
        );
        expect(missing.isLeft(), isTrue);
      },
    );

    test('rejects votes on a closed poll', () async {
      final mock = ds();
      // Post 9 → variant 3 → seeded closed poll.
      final poll = PollData.fromJson(mock.decorate(post(9)).poll!);
      expect(poll.endsAt!.isBefore(DateTime.now()), isTrue);
      final res = await mock.vote(
        pollId: poll.id,
        voterId: 'me',
        optionIds: [poll.options.first.id],
      );
      expect(res.isLeft(), isTrue);
      final retract = await mock.retractVote(pollId: poll.id, voterId: 'me');
      expect(retract.isLeft(), isTrue);
    });

    test('fails every Nth mutation when configured', () async {
      final mock = ds(failEveryNth: 2);
      final poll = PollData.fromJson(mock.decorate(post(3)).poll!);
      final id = poll.options.first.id;
      final first = await mock.vote(
        pollId: poll.id,
        voterId: 'me',
        optionIds: [id],
      );
      final second = await mock.vote(
        pollId: poll.id,
        voterId: 'me',
        optionIds: [id],
      );
      final third = await mock.vote(
        pollId: poll.id,
        voterId: 'me',
        optionIds: [id],
      );
      expect(first.isRight(), isTrue);
      expect(second.isLeft(), isTrue);
      expect(third.isRight(), isTrue);
    });

    test('paginates voters and filters by option', () async {
      final mock = ds();
      final poll = PollData.fromJson(mock.decorate(post(3)).poll!);
      final id = poll.options.first.id;
      await mock.vote(pollId: poll.id, voterId: 'me', optionIds: [id]);

      final page1 = (await mock.getVoters(
        pollId: poll.id,
        page: 1,
        pageSize: 5,
      )).getOrElse(() => throw StateError('failed'));
      expect(page1.results.length, lessThanOrEqualTo(5));
      expect(page1.count, poll.totalVotes + 1);
      expect(page1.hasMore, page1.count > 5);

      final filtered = (await mock.getVoters(
        pollId: poll.id,
        optionId: id,
        page: 1,
        pageSize: 100,
      )).getOrElse(() => throw StateError('failed'));
      expect(filtered.results.every((v) => v.optionIds.contains(id)), isTrue);
      expect(filtered.results.any((v) => v.userId == 'me'), isTrue);
    });

    test('attachDraft mints a poll for a freshly created post', () {
      final mock = ds();
      final created = mock.attachDraft(
        post(50),
        const PollDraft(
          question: 'New?',
          options: ['Yes', 'No'],
          allowsMultiple: true,
        ),
      );
      final poll = PollData.fromJson(created.poll!);
      expect(poll.postId, 50);
      expect(poll.question, 'New?');
      expect(poll.allowsMultiple, isTrue);
      expect(poll.options.map((o) => o.text), ['Yes', 'No']);
      expect(poll.options.map((o) => o.position), [0, 1]);
      expect(poll.totalVotes, 0);
    });
  });
}
