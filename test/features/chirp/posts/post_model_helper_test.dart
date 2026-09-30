import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final community = db.Community(
    id: 1,
    name: 'c',
    nsfw: false,
    private: false,
    verified: false,
    visibility: 'public',
    memberCount: 0,
    moderatorCount: 0,
    bannedUsersCount: 0,
    monthlyVisitorCount: 0,
    weeklyVisitorCount: 0,
    bannerHeight: 0,
    bannerWidth: 0,
    profilePictureHeight: 0,
    profilePictureWidth: 0,
    creatorId: 'x',
    guidelines: const [],
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  ).toJson();

  db.Post post(Map<String, dynamic>? poll) => db.Post(
    id: 1,
    community: community,
    authorId: 'a',
    title: 't',
    content: 'c',
    upvotes: 0,
    downvotes: 0,
    attachments: const [],
    viewsCount: 0,
    commentCount: 0,
    comments: const [],
    poll: poll,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );

  test('null / empty poll blobs map to no poll', () {
    expect(post(null).toEntity().poll, isNull);
    expect(post(const {}).toEntity().poll, isNull);
  });

  test('a malformed cached poll blob degrades to no poll', () {
    final entity = post(const {'question': 'missing id'}).toEntity();
    expect(entity.poll, isNull);
    expect(entity.id, 1);
  });

  test('a valid poll blob round-trips', () {
    final entity = post(const {
      'id': 5,
      'post': 1,
      'question': 'Q',
      'options': [
        {'id': 1, 'text': 'A', 'position': 0, 'vote_count': 2},
      ],
    }).toEntity();
    expect(entity.poll!.id, 5);
    expect(entity.poll!.options.single.voteCount, 2);
  });
}
