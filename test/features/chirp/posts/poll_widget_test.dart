import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/chirp.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal repository double: only the poll methods are real, everything else
/// falls through to [noSuchMethod] and is never called by [PollWidget].
class _FakeChirpRepository implements ChirpRepository {
  bool failNext = false;

  /// Simulated latency so tests can observe the optimistic state before the
  /// bloc reconciles. Never elapses under a bare `tester.pump()`.
  Duration delay = Duration.zero;
  final List<List<int>> votes = [];
  int retracts = 0;

  @override
  Future<Either<Failure, Post>> voteOnPoll({
    required Post post,
    required List<int> optionIds,
    required String voterId,
  }) async {
    votes.add(optionIds);
    if (delay > Duration.zero) await Future.delayed(delay);
    if (failNext) {
      failNext = false;
      return left(const ServerFailure(message: 'boom', error: 'boom'));
    }
    return right(
      post.copyWith(poll: PostCubit.optimisticPoll(post.poll!, optionIds)),
    );
  }

  @override
  Future<Either<Failure, Post>> retractPollVote({
    required Post post,
    required String voterId,
  }) async {
    retracts++;
    return right(post.copyWith(poll: PostCubit.optimisticPoll(post.poll!, [])));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

class _FakeProfileBloc extends Cubit<ProfileState> implements ProfileBloc {
  _FakeProfileBloc(super.state);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

FeedBloc _feedBloc(ChirpRepository repo) => FeedBloc(
  getFeedPosts: GetFeedPostsUsecase(repo),
  createPost: CreatePostUsecase(chirpRepository: repo),
  getPostDetail: GetPostDetailUseCase(repository: repo),
  markPostAsViewed: MarkPostAsViewedUsecase(repository: repo),
  createPostAttachment: CreatePostAttachmentUsecase(repository: repo),
  deletePost: DeletePostUsecase(repository: repo),
  getPostsFromCommunityUsecase: GetPostsFromCommunityUsecase(repository: repo),
  likePost: LikePostUsecase(chirpRepository: repo),
  voteOnPoll: VoteOnPollUsecase(chirpRepository: repo),
  retractPollVote: RetractPollVoteUsecase(chirpRepository: repo),
  checkPostLiked: CheckPostLikedUsecase(chirpRepository: repo),
);

UserProfile _profile(String id) => UserProfile(
  id: id,
  name: 'Test',
  email: 't@example.com',
  termsAccepted: true,
  onboarded: true,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  bio: null,
  phone: null,
  username: 'test',
  nationalID: null,
  vibePoints: 0,
);

Post _post({
  bool allowsMultiple = false,
  DateTime? endsAt,
  List<int> myVotes = const [],
  String authorId = 'author',
}) => Post(
  id: 7,
  community: Community(
    id: 1,
    name: 'c',
    visibility: 'public',
    guidelines: const [],
    creatorId: 'x',
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  ),
  authorId: authorId,
  title: 't',
  content: 'c',
  upvotes: 0,
  downvotes: 0,
  viewsCount: 0,
  commentCount: 0,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
  poll: Poll(
    id: 1,
    postId: 7,
    question: 'Which?',
    allowsMultiple: allowsMultiple,
    endsAt: endsAt,
    totalVotes: 4,
    myVotes: myVotes,
    options: const [
      PollOption(id: 1, text: 'Alpha', position: 0, voteCount: 3),
      PollOption(id: 2, text: 'Beta', position: 1, voteCount: 1),
    ],
  ),
);

Future<PostCubit> _pump(
  WidgetTester tester, {
  required Post post,
  required _FakeChirpRepository repo,
  ProfileState? profileState,
}) async {
  final cubit = PostCubit(post);
  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(create: (_) => _feedBloc(repo)),
        BlocProvider<ProfileBloc>(
          create: (_) => _FakeProfileBloc(
            profileState ?? ProfileLoadedState(profile: _profile('me')),
          ),
        ),
        BlocProvider<PostCubit>.value(value: cubit),
      ],
      child: const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: PollWidget())),
      ),
    ),
  );
  return cubit;
}

void main() {
  _regressions();

  testWidgets('hides results until the user votes', (tester) async {
    await _pump(tester, post: _post(), repo: _FakeChirpRepository());
    expect(find.text('Which?'), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
    expect(find.textContaining('%'), findsNothing);
    expect(find.text('4 votes'), findsOneWidget);
    expect(find.text('Single choice'), findsOneWidget);
  });

  testWidgets(
    'tapping an option applies the vote optimistically and animates',
    (tester) async {
      final repo = _FakeChirpRepository();
      final cubit = await _pump(tester, post: _post(), repo: repo);

      await tester.tap(find.text('Beta'));
      await tester.pump(); // one frame: optimistic state, animation started

      // Cubit updated before any network round-trip.
      expect(cubit.state.poll!.myVotes, [2]);
      expect(cubit.state.poll!.totalVotes, 5);
      expect(find.text('5 votes'), findsOneWidget);

      // Bar is mid-animation, then settles at its target width.
      await tester.pump(const Duration(milliseconds: 100));
      final midway = tester
          .widgetList<FractionallySizedBox>(find.byType(FractionallySizedBox))
          .map((w) => w.widthFactor!)
          .toList();
      expect(midway.any((f) => f > 0 && f < 0.6), isTrue);

      await tester.pumpAndSettle();
      expect(find.text('60%'), findsOneWidget); // Alpha 3/5
      expect(find.text('40%'), findsOneWidget); // Beta 2/5
      expect(repo.votes, [
        [2],
      ]);
      expect(find.byIcon(Icons.radio_button_checked), findsWidgets);
    },
  );

  testWidgets('single-select: tapping the current choice retracts', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    final cubit = await _pump(
      tester,
      post: _post(myVotes: [1]),
      repo: repo,
    );
    expect(find.text('75%'), findsOneWidget);

    await tester.tap(find.text('Alpha'));
    await tester.pump();
    expect(cubit.state.poll!.myVotes, isEmpty);
    expect(cubit.state.poll!.totalVotes, 3);
    await tester.pumpAndSettle();
    expect(repo.retracts, 1);
    expect(find.textContaining('%'), findsNothing);
  });

  testWidgets('multi-select toggles membership and sends the full set', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    final cubit = await _pump(
      tester,
      post: _post(allowsMultiple: true, myVotes: [1]),
      repo: repo,
    );
    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();
    expect(cubit.state.poll!.myVotes, unorderedEquals([1, 2]));
    expect(repo.votes.single, unorderedEquals([1, 2]));
    // Same voter, so the distinct total is unchanged.
    expect(cubit.state.poll!.totalVotes, 4);
  });

  testWidgets('rolls back and shows a snackbar when the vote fails', (
    tester,
  ) async {
    final repo = _FakeChirpRepository()
      ..failNext = true
      ..delay = const Duration(milliseconds: 50);
    final original = _post();
    final cubit = await _pump(tester, post: original, repo: repo);

    await tester.tap(find.text('Beta'));
    await tester.pump();
    expect(cubit.state.poll!.myVotes, [2]);

    await tester.pumpAndSettle();
    expect(cubit.state, original);
    expect(find.textContaining('%'), findsNothing);
    expect(find.textContaining('Couldn\'t save your vote'), findsOneWidget);
  });

  testWidgets('closed poll shows final results and ignores taps', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    final cubit = await _pump(
      tester,
      post: _post(endsAt: DateTime.now().subtract(const Duration(hours: 1))),
      repo: repo,
    );
    await tester.pumpAndSettle();
    expect(find.text('Final results'), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);
    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();
    expect(repo.votes, isEmpty);
    expect(cubit.state.poll!.myVotes, isEmpty);
  });

  testWidgets('prompts to sign in when no profile is loaded', (tester) async {
    final repo = _FakeChirpRepository();
    await _pump(
      tester,
      post: _post(),
      repo: repo,
      profileState: ProfileInitialState(),
    );
    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to vote'), findsOneWidget);
    expect(repo.votes, isEmpty);
  });

  testWidgets('hides "View votes" for non-authors on anonymous polls', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    final anon = _post().copyWith(
      poll: _post().poll!.copyWith(isAnonymous: true),
    );
    await _pump(tester, post: anon, repo: repo);
    expect(find.text('View votes'), findsNothing);
    expect(find.text('Anonymous'), findsOneWidget);

    // Tear the tree down so the providers are re-created with a new profile.
    await tester.pumpWidget(const SizedBox());
    await _pump(
      tester,
      post: anon,
      repo: repo,
      profileState: ProfileLoadedState(profile: _profile('author')),
    );
    expect(find.text('View votes'), findsOneWidget);
  });
}

// ---------------------------------------------------------------------------
// Regression tests for the review findings
// ---------------------------------------------------------------------------

void _regressions() {
  testWidgets('vote sends the cubit\'s latest post, not a stale closure', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    final cubit = await _pump(tester, post: _post(), repo: repo);

    // A like lands after the poll widget was built (poll unchanged, so
    // PollWidget's builder does not rerun).
    cubit.updatePost(cubit.state.copyWith(myVote: 1, upvotes: 1));
    await tester.pump();

    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();

    // The like survived the vote round-trip.
    expect(cubit.state.myVote, 1);
    expect(cubit.state.upvotes, 1);
    expect(cubit.state.poll!.myVotes, [2]);
  });

  testWidgets('failed vote does not rewind the feed to an older state', (
    tester,
  ) async {
    final repo = _FakeChirpRepository()
      ..failNext = true
      ..delay = const Duration(milliseconds: 50);
    await _pump(tester, post: _post(), repo: repo);
    final feedBloc = tester.element(find.byType(PollWidget)).read<FeedBloc>();

    // Feed has 1 page when the vote fires...
    final pageOne = FeedLoaded(posts: [_post()], count: 1, hasMore: true);
    feedBloc.emit(pageOne);
    await tester.tap(find.text('Beta'));
    await tester.pump();

    // ...and a second page arrives while the vote is in flight.
    final pageTwo = FeedLoaded(
      posts: [_post(), _post().copyWith(id: 8)],
      count: 2,
      hasMore: false,
    );
    feedBloc.emit(pageTwo);

    await tester.pumpAndSettle();
    expect(feedBloc.state, pageTwo);
    expect(find.textContaining('Couldn\'t save your vote'), findsOneWidget);
  });

  testWidgets('out-of-order responses: the latest vote wins', (tester) async {
    final repo = _FakeChirpRepository();
    final cubit = await _pump(
      tester,
      post: _post(allowsMultiple: true),
      repo: repo,
    );
    final feedBloc = tester.element(find.byType(PollWidget)).read<FeedBloc>();
    feedBloc.emit(FeedLoaded(posts: [_post(allowsMultiple: true)], count: 1));

    // First request is slow, second is fast.
    repo.delay = const Duration(milliseconds: 300);
    await tester.tap(find.text('Alpha'));
    await tester.pump();
    repo.delay = const Duration(milliseconds: 10);
    await tester.tap(find.text('Beta'));
    await tester.pump();

    await tester.pumpAndSettle();
    expect(repo.votes.length, 2);
    // The stale response for [Alpha] must not have clobbered [Alpha, Beta].
    final feedPost = (feedBloc.state as FeedLoaded).posts.single;
    expect(feedPost.poll!.myVotes, unorderedEquals([1, 2]));
    expect(cubit.state.poll!.myVotes, unorderedEquals([1, 2]));
  });

  testWidgets('poll flips to closed on screen when ends_at passes', (
    tester,
  ) async {
    final repo = _FakeChirpRepository();
    await _pump(
      tester,
      post: _post(endsAt: DateTime.now().add(const Duration(seconds: 1))),
      repo: repo,
    );
    expect(find.text('Final results'), findsNothing);
    expect(find.textContaining('%'), findsNothing);

    // Let real wall-clock time pass (isClosed uses DateTime.now()), then
    // advance the fake clock so the close timer fires and rebuilds.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 1500)),
    );
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Final results'), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);

    // Once rebuilt as closed the rows are inert.
    await tester.tap(find.text('Beta'));
    await tester.pumpAndSettle();
    expect(repo.votes, isEmpty);
  });

  testWidgets('tap during the close/rebuild window explains why', (
    tester,
  ) async {
    // Build while open, then let the deadline pass WITHOUT letting the close
    // timer fire, so the rows are still enabled but the poll is closed.
    final repo = _FakeChirpRepository();
    await _pump(
      tester,
      post: _post(
        endsAt: DateTime.now().add(const Duration(milliseconds: 300)),
      ),
      repo: repo,
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 600)),
    );
    await tester.tap(find.text('Beta'));
    await tester.pump();
    expect(find.text('This poll has closed'), findsOneWidget);
    expect(repo.votes, isEmpty);
  });
}
