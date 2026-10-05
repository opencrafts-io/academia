import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Poll poll({
    required List<int> counts,
    required int totalVotes,
    bool allowsMultiple = false,
    List<int> myVotes = const [],
  }) => Poll(
    id: 1,
    postId: 1,
    question: 'Q',
    allowsMultiple: allowsMultiple,
    totalVotes: totalVotes,
    myVotes: myVotes,
    options: [
      for (var i = 0; i < counts.length; i++)
        PollOption(id: i + 1, text: 'O$i', position: i, voteCount: counts[i]),
    ],
  );

  List<int> counts(Poll p) => p.options.map((o) => o.voteCount).toList();

  group('PostCubit.optimisticPoll', () {
    test('first vote increments option and total', () {
      final next = PostCubit.optimisticPoll(
        poll(counts: [3, 2], totalVotes: 5),
        [1],
      );
      expect(counts(next), [4, 2]);
      expect(next.totalVotes, 6);
      expect(next.myVotes, [1]);
    });

    test('single-select switch moves the vote without changing total', () {
      final next = PostCubit.optimisticPoll(
        poll(counts: [3, 2], totalVotes: 5, myVotes: [1]),
        [2],
      );
      expect(counts(next), [2, 3]);
      expect(next.totalVotes, 5);
      expect(next.myVotes, [2]);
    });

    test('retraction (empty selection) decrements option and total', () {
      final next = PostCubit.optimisticPoll(
        poll(counts: [3, 2], totalVotes: 5, myVotes: [1]),
        [],
      );
      expect(counts(next), [2, 2]);
      expect(next.totalVotes, 4);
      expect(next.myVotes, isEmpty);
    });

    test('multi-select add keeps total (already a voter)', () {
      final next = PostCubit.optimisticPoll(
        poll(
          counts: [3, 2, 1],
          totalVotes: 4,
          allowsMultiple: true,
          myVotes: [1],
        ),
        [1, 3],
      );
      expect(counts(next), [3, 2, 2]);
      expect(next.totalVotes, 4);
      expect(next.myVotes, unorderedEquals([1, 3]));
    });

    test('multi-select removing last selection decrements total', () {
      final next = PostCubit.optimisticPoll(
        poll(
          counts: [3, 2, 1],
          totalVotes: 4,
          allowsMultiple: true,
          myVotes: [1, 3],
        ),
        [3],
      );
      expect(counts(next), [2, 2, 1]);
      expect(next.totalVotes, 4);

      final gone = PostCubit.optimisticPoll(next, []);
      expect(counts(gone), [2, 2, 0]);
      expect(gone.totalVotes, 3);
    });

    test('never goes negative on inconsistent server data', () {
      final next = PostCubit.optimisticPoll(
        poll(counts: [0, 0], totalVotes: 0, myVotes: [1]),
        [],
      );
      expect(counts(next), [0, 0]);
      expect(next.totalVotes, 0);
    });

    test('re-selecting the same option is a no-op', () {
      final before = poll(counts: [3, 2], totalVotes: 5, myVotes: [1]);
      final next = PostCubit.optimisticPoll(before, [1]);
      expect(counts(next), counts(before));
      expect(next.totalVotes, before.totalVotes);
    });
  });
}
