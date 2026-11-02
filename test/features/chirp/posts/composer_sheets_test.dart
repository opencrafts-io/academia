import 'package:academia/features/chirp/chirp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Records [CreatePostEvent]s and answers with [succeed] ? created : error.
class _RecordingFeedBloc extends Bloc<FeedEvent, FeedState>
    implements FeedBloc {
  final List<CreatePostEvent> created = [];
  bool succeed = false;

  _RecordingFeedBloc() : super(const FeedState.initial()) {
    on<CreatePostEvent>((event, emit) {
      created.add(event);
      emit(
        succeed
            ? const FeedState.postCreated(posts: [])
            : const FeedState.postCreateError('boom'),
      );
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

class _FakeProfileBloc extends Cubit<ProfileState> implements ProfileBloc {
  _FakeProfileBloc() : super(const ProfileInitialState());

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

class _FakeListingCubit extends Cubit<CommunityListingState>
    implements CommunityListingCubit {
  final List<Community> communities;

  _FakeListingCubit(this.communities)
    : super(const CommunityListingState.initial());

  @override
  Future<void> getPostableCommunities({int page = 1}) async => emit(
    CommunityListingState.loaded(communities: communities, hasReachedMax: true),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName}');
}

Community _community(int id, String name) => Community(
  id: id,
  name: name,
  visibility: 'public',
  guidelines: const [],
  creatorId: 'x',
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

final _general = _community(1, 'General');
final _maths = _community(2, 'Maths');

/// Opens [sheet] the way the app does: a content-sized modal sheet route.
Future<_RecordingFeedBloc> _pump(
  WidgetTester tester,
  Widget sheet, {
  List<Community>? communities,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  tester.view.physicalSize = const Size(900, 2000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final feedBloc = _RecordingFeedBloc();
  addTearDown(feedBloc.close);

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => context.push('/compose'),
              child: const Text('open'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/compose',
        pageBuilder: (_, state) => ModalSheetPage(
          key: state.pageKey,
          swipeDismissible: true,
          child: Sheet(
            decoration: const MaterialSheetDecoration(size: SheetSize.fit),
            child: sheet,
          ),
        ),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>.value(value: feedBloc),
        BlocProvider<ProfileBloc>(create: (_) => _FakeProfileBloc()),
        BlocProvider<CommunityListingCubit>(
          create: (_) => _FakeListingCubit(communities ?? [_general, _maths]),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return feedBloc;
}

Finder get _pollFields => find.descendant(
  of: find.byType(CreatePollSheet),
  matching: find.byType(TextField),
);

Future<void> _fillPoll(WidgetTester tester) async {
  await tester.enterText(_pollFields.at(0), 'Which unit first?');
  await tester.enterText(_pollFields.at(1), 'Calculus');
  await tester.enterText(_pollFields.at(2), 'Databases');
  await tester.pump();
}

Finder get _title => find.byType(TextFormField).first;

Future<void> _tapPost(WidgetTester tester) async {
  // Let the button pick up the latest text before tapping it.
  await tester.pump();
  await tester.tap(find.widgetWithText(FilledButton, 'Post'));
  await tester.pumpAndSettle();
}

Future<void> _tapPostPoll(WidgetTester tester) async {
  await tester.pump();
  await tester.tap(find.text('Post poll'));
  await tester.pumpAndSettle();
}

bool _postEnabled(WidgetTester tester) =>
    tester
        .widget<FilledButton>(find.widgetWithText(FilledButton, 'Post'))
        .onPressed !=
    null;

void main() {
  group('post sheet', () {
    testWidgets('Post stays disabled until there is a title', (tester) async {
      await _pump(tester, AddPostSheet(preselectedCommunity: _general));

      expect(_postEnabled(tester), isFalse);
      await tester.enterText(find.byType(TextFormField).at(1), 'Body only');
      await tester.pump();
      expect(_postEnabled(tester), isFalse);

      await tester.enterText(_title, 'Exam prep');
      await tester.pump();
      expect(_postEnabled(tester), isTrue);
    });

    testWidgets('a short title is flagged and nothing is posted', (
      tester,
    ) async {
      final feedBloc = await _pump(
        tester,
        AddPostSheet(preselectedCommunity: _general),
      );

      await tester.enterText(_title, 'Hi');
      await _tapPost(tester);

      expect(feedBloc.created, isEmpty);
      expect(find.text('Titles need at least 3 characters'), findsOneWidget);
    });

    testWidgets('the body is optional', (tester) async {
      final feedBloc = await _pump(
        tester,
        AddPostSheet(preselectedCommunity: _general),
      );

      await tester.enterText(_title, 'Exam prep');
      await _tapPost(tester);

      expect(feedBloc.created.single.title, 'Exam prep');
      expect(feedBloc.created.single.content, isEmpty);
      expect(feedBloc.created.single.poll, isNull);
    });

    testWidgets('a poll attached from the toolbar needs no title', (
      tester,
    ) async {
      final feedBloc = await _pump(
        tester,
        AddPostSheet(preselectedCommunity: _general),
      );

      await tester.tap(find.byTooltip('Add poll'));
      await tester.pumpAndSettle();
      await _fillPoll(tester);
      await tester.tap(find.text('Add poll to post'));
      await tester.pumpAndSettle();

      expect(find.byType(PollDraftPreview), findsOneWidget);
      await _tapPost(tester);

      final event = feedBloc.created.single;
      expect(event.title, 'Which unit first?');
      expect(event.poll?.options, ['Calculus', 'Databases']);
    });

    testWidgets('the attached poll sheet cannot be swiped away', (
      tester,
    ) async {
      await _pump(tester, AddPostSheet(preselectedCommunity: _general));

      await tester.tap(find.byTooltip('Add poll'));
      await tester.pumpAndSettle();
      final top = tester.getTopLeft(find.byType(CreatePollSheet)).dy;

      await tester.drag(find.text('Create poll'), const Offset(0, 800));
      await tester.pumpAndSettle();

      expect(find.byType(CreatePollSheet), findsOneWidget);
      expect(tester.getTopLeft(find.byType(CreatePollSheet)).dy, top);
    });

    testWidgets('a failed post explains itself inside the sheet', (
      tester,
    ) async {
      await _pump(tester, AddPostSheet(preselectedCommunity: _general));

      await tester.enterText(_title, 'Exam prep');
      await _tapPost(tester);

      expect(
        find.text("Couldn't create your post. Please try again."),
        findsOneWidget,
      );
      expect(find.byType(AddPostSheet), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('leaving with unsaved work asks first', (tester) async {
      await _pump(tester, AddPostSheet(preselectedCommunity: _general));

      await tester.enterText(_title, 'Exam prep');
      await tester.pump();
      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();
      expect(find.text('Discard post?'), findsOneWidget);

      await tester.tap(find.text('Keep editing'));
      await tester.pumpAndSettle();
      expect(find.byType(AddPostSheet), findsOneWidget);

      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();
      expect(find.byType(AddPostSheet), findsNothing);
    });

    testWidgets('an empty sheet closes without asking', (tester) async {
      await _pump(tester, AddPostSheet(preselectedCommunity: _general));

      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();

      expect(find.text('Discard post?'), findsNothing);
      expect(find.byType(AddPostSheet), findsNothing);
    });
  });

  group('community', () {
    testWidgets('posting without one asks where, then posts there', (
      tester,
    ) async {
      final feedBloc = await _pump(tester, const AddPostSheet());

      expect(find.text('Choose a community'), findsOneWidget);
      await tester.enterText(_title, 'Exam prep');
      await _tapPost(tester);

      expect(find.text('Post to'), findsOneWidget);
      expect(feedBloc.created, isEmpty);
      await tester.tap(find.text('Maths'));
      await tester.pumpAndSettle();

      expect(feedBloc.created.single.communityId, _maths.id);
      expect(find.text('a/Maths'), findsOneWidget);
    });

    testWidgets('dismissing the picker flags the missing community', (
      tester,
    ) async {
      final feedBloc = await _pump(tester, const AddPostSheet());

      await tester.enterText(_title, 'Exam prep');
      await _tapPost(tester);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(feedBloc.created, isEmpty);
      expect(find.text('Choose a community to post in'), findsOneWidget);
    });

    testWidgets('the last community posted to is preselected', (tester) async {
      await _pump(
        tester,
        const AddPostSheet(),
        prefs: {'chirp_last_post_community_id': 2},
      );
      await tester.pumpAndSettle();

      expect(find.text('a/Maths'), findsOneWidget);
    });

    testWidgets('a single postable community is preselected', (tester) async {
      await _pump(tester, const AddPostSheet(), communities: [_general]);
      await tester.pumpAndSettle();

      expect(find.text('a/General'), findsOneWidget);
    });

    testWidgets('a successful post closes the sheet and remembers where', (
      tester,
    ) async {
      final feedBloc = await _pump(
        tester,
        AddPostSheet(preselectedCommunity: _maths),
      );
      feedBloc.succeed = true;

      await tester.enterText(_title, 'Exam prep');
      await _tapPost(tester);

      expect(find.byType(AddPostSheet), findsNothing);
      expect(find.text('Posted to a/Maths'), findsOneWidget);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('chirp_last_post_community_id'), _maths.id);
    });
  });

  group('standalone poll sheet', () {
    testWidgets('shows the community pill and posts in one step', (
      tester,
    ) async {
      final feedBloc = await _pump(
        tester,
        CreatePollSheet.standalone(community: _general),
      );

      expect(find.text('Create poll'), findsOneWidget);
      expect(find.text('a/General'), findsOneWidget);
      await _fillPoll(tester);
      await _tapPostPoll(tester);

      final event = feedBloc.created.single;
      expect(event.title, 'Which unit first?');
      expect(event.content, isEmpty);
      expect(event.communityId, _general.id);
      expect(event.poll?.options, ['Calculus', 'Databases']);
    });

    testWidgets('asks for a community when none is chosen', (tester) async {
      final feedBloc = await _pump(tester, const CreatePollSheet.standalone());

      await _fillPoll(tester);
      await _tapPostPoll(tester);
      expect(find.text('Post to'), findsOneWidget);

      await tester.tap(find.text('Maths'));
      await tester.pumpAndSettle();
      expect(feedBloc.created.single.communityId, _maths.id);
    });

    testWidgets('an incomplete poll is not posted', (tester) async {
      final feedBloc = await _pump(
        tester,
        CreatePollSheet.standalone(community: _general),
      );

      await tester.enterText(_pollFields.at(0), 'Which unit first?');
      await _tapPostPoll(tester);

      expect(feedBloc.created, isEmpty);
    });

    testWidgets('a failed post keeps the sheet open with an error', (
      tester,
    ) async {
      await _pump(tester, CreatePollSheet.standalone(community: _general));

      await _fillPoll(tester);
      await _tapPostPoll(tester);

      expect(
        find.text("Couldn't post your poll. Please try again."),
        findsOneWidget,
      );
      expect(find.byType(CreatePollSheet), findsOneWidget);
    });

    testWidgets('a successful poll closes the sheet', (tester) async {
      final feedBloc = await _pump(
        tester,
        CreatePollSheet.standalone(community: _maths),
      );
      feedBloc.succeed = true;

      await _fillPoll(tester);
      await _tapPostPoll(tester);

      expect(find.byType(CreatePollSheet), findsNothing);
      expect(find.text('Poll posted to a/Maths'), findsOneWidget);
    });

    testWidgets('leaving a started poll asks first', (tester) async {
      await _pump(tester, CreatePollSheet.standalone(community: _general));

      await tester.enterText(_pollFields.at(0), 'Which unit first?');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Discard poll?'), findsOneWidget);
    });
  });
}
