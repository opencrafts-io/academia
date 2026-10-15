import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Poll poll({
    required List<int> counts,
    int? totalVotes,
    bool allowsMultiple = false,
    List<int> myVotes = const [],
    DateTime? endsAt,
  }) => Poll(
    id: 1,
    postId: 1,
    question: 'Q',
    allowsMultiple: allowsMultiple,
    totalVotes: totalVotes ?? counts.fold(0, (a, b) => a + b),
    myVotes: myVotes,
    endsAt: endsAt,
    options: [
      for (var i = 0; i < counts.length; i++)
        PollOption(id: i + 1, text: 'O$i', position: i, voteCount: counts[i]),
    ],
  );

  group('Poll', () {
    test('fractionFor is 0 with no votes (no divide-by-zero)', () {
      final p = poll(counts: [0, 0]);
      expect(p.fractionFor(p.options.first), 0);
      expect(p.percentages.values, everyElement(0));
    });

    test('single-select percentages sum to exactly 100', () {
      final p = poll(counts: [1, 1, 1]); // 33.33 each
      final pct = p.percentages;
      expect(pct.values.fold<int>(0, (a, b) => a + b), 100);
      expect(pct.values.where((v) => v == 34).length, 1);
    });

    test('largest-remainder rounding favours the biggest remainder', () {
      final p = poll(counts: [2, 1, 1, 1]); // 40, 20, 20, 20
      expect(p.percentages, {1: 40, 2: 20, 3: 20, 4: 20});
    });

    test('multi-select percentages use plain rounding per option', () {
      final p = poll(counts: [3, 2], totalVotes: 3, allowsMultiple: true);
      expect(p.percentages, {1: 100, 2: 67});
    });

    test('isClosed / showsResults', () {
      final open = poll(counts: [1]);
      expect(open.isClosed, isFalse);
      expect(open.showsResults, isFalse);

      final closed = poll(
        counts: [1],
        endsAt: DateTime.now().subtract(const Duration(minutes: 1)),
      );
      expect(closed.isClosed, isTrue);
      expect(closed.showsResults, isTrue);

      final voted = poll(counts: [1], myVotes: [1]);
      expect(voted.showsResults, isTrue);
    });

    test('sortedOptions orders by position', () {
      final p = Poll(
        id: 1,
        postId: 1,
        question: 'Q',
        options: const [
          PollOption(id: 1, text: 'b', position: 1),
          PollOption(id: 2, text: 'a', position: 0),
        ],
      );
      expect(p.sortedOptions.map((o) => o.text), ['a', 'b']);
    });

    test('PollDraft.toJson serialises positions and UTC end time', () {
      final json = PollDraft(
        question: 'Q',
        options: const ['A', 'B'],
        endsAt: DateTime.utc(2026, 9, 14, 18),
      ).toJson();
      expect(json['options'], [
        {'text': 'A', 'position': 0},
        {'text': 'B', 'position': 1},
      ]);
      expect(json['ends_at'], '2026-09-14T18:00:00.000Z');
    });
  });

  group('PollData round-trip', () {
    test('fromJson/toJson/toEntity preserve fields', () {
      final json = {
        'id': 41,
        'post': 1203,
        'question': 'Which?',
        'allows_multiple': true,
        'is_anonymous': false,
        'ends_at': '2026-09-14T18:00:00Z',
        'total_votes': 27,
        'my_votes': [88],
        'options': [
          {'id': 87, 'text': 'Calculus', 'position': 0, 'vote_count': 12},
          {'id': 88, 'text': 'Databases', 'position': 1, 'vote_count': 15},
        ],
      };
      final data = PollData.fromJson(json);
      final entity = data.toEntity();
      expect(entity.id, 41);
      expect(entity.postId, 1203);
      expect(entity.allowsMultiple, isTrue);
      expect(entity.myVotes, [88]);
      expect(entity.options.length, 2);
      expect(entity.options[1].voteCount, 15);
      expect(entity.endsAt, DateTime.utc(2026, 9, 14, 18).toLocal());

      final back = entity.toData().toJson();
      expect(back['my_votes'], [88]);
      expect(back['options'], json['options']);
      expect(back['ends_at'], '2026-09-14T18:00:00.000Z');
    });

    test('tolerates missing optional fields', () {
      final data = PollData.fromJson({'id': 1, 'question': 'Q'});
      expect(data.options, isEmpty);
      expect(data.myVotes, isEmpty);
      expect(data.endsAt, isNull);
      expect(data.totalVotes, 0);
    });
  });
}
