import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter_test/flutter_test.dart';

Post _post({String title = 't', String content = 'c', Poll? poll}) => Post(
  id: 1,
  community: Community(
    id: 1,
    name: 'c',
    visibility: 'public',
    guidelines: const [],
    creatorId: 'x',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  ),
  authorId: 'a',
  title: title,
  content: content,
  upvotes: 0,
  downvotes: 0,
  viewsCount: 0,
  commentCount: 0,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  poll: poll,
);

const _poll = Poll(
  id: 1,
  postId: 1,
  question: 'Which unit first?',
  options: [
    PollOption(id: 1, text: 'A', position: 0),
    PollOption(id: 2, text: 'B', position: 1),
  ],
);

void main() {
  test('regular posts show their title and content', () {
    final post = _post(title: 'Hello', content: 'World');
    expect(post.showsTitle, isTrue);
    expect(post.showsContent, isTrue);
  });

  test('poll-only posts hide a title that repeats the question', () {
    final post = _post(title: 'Which unit first? ', content: '', poll: _poll);
    expect(post.showsTitle, isFalse);
    expect(post.showsContent, isFalse);
  });

  test('a distinct title is shown above a poll', () {
    final post = _post(title: 'Exam prep', poll: _poll);
    expect(post.showsTitle, isTrue);
  });

  test('blank title and content are hidden', () {
    final post = _post(title: '  ', content: '\n');
    expect(post.showsTitle, isFalse);
    expect(post.showsContent, isFalse);
  });
}
