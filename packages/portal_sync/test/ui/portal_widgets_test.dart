import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_draft.dart';
import 'package:portal_sync/src/presentation/widgets/portal_connection_card.dart';
import 'package:portal_sync/src/presentation/widgets/portal_import_review.dart';
import 'package:portal_sync/src/presentation/widgets/portal_progress_overview.dart';
import 'package:portal_sync/src/presentation/widgets/portal_state_message.dart';

void main() {
  Widget host(Widget child, {double textScale = 1}) => MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    ),
    home: MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
      child: Scaffold(body: SingleChildScrollView(child: child)),
    ),
  );

  group('PortalConnectionCard', () {
    testWidgets('connection card layout at phone width with enlarged text', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        host(
          PortalConnectionCard(
            initialUri: Uri.parse('https://portal.example.edu'),
            schoolName: 'Example University',
            onConnect: (_) {},
          ),
          textScale: 1.7,
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('accepts a secure URL and explains the data review', (
      tester,
    ) async {
      Uri? connected;
      await tester.pumpWidget(
        host(
          PortalConnectionCard(
            initialUri: Uri.parse('https://portal.example.edu'),
            schoolName: 'Example University',
            onConnect: (uri) => connected = uri,
          ),
        ),
      );

      expect(find.text('Connect your school portal'), findsOneWidget);
      expect(
        find.text(
          'You stay in control. Nothing is imported until you review it.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Start sync and open portal'));
      expect(connected, Uri.parse('https://portal.example.edu'));
    });

    testWidgets('rejects non HTTPS URLs and embedded credentials', (
      tester,
    ) async {
      var connected = false;
      await tester.pumpWidget(
        host(
          PortalConnectionCard(
            initialUri: Uri.parse('https://portal.example.edu'),
            schoolName: 'Example University',
            onConnect: (_) => connected = true,
          ),
        ),
      );

      final field = tester.widget<TextFormField>(find.byType(TextFormField));
      field.controller!.text = 'http://portal.example.edu';
      await tester.tap(find.text('Start sync and open portal'));
      await tester.pump();
      expect(find.text('Enter a valid HTTPS website address.'), findsOneWidget);
      expect(connected, isFalse);

      field.controller!.text = 'https://student:secret@portal.example.edu';
      await tester.tap(find.text('Start sync and open portal'));
      await tester.pump();
      expect(connected, isFalse);
    });

    testWidgets('supports enlarged text and expands privacy details', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        host(
          PortalConnectionCard(
            initialUri: Uri.parse('https://portal.example.edu'),
            schoolName: 'Example University',
            onConnect: (_) {},
          ),
          textScale: 1.7,
        ),
      );

      await tester.ensureVisible(find.byTooltip('Privacy details'));
      await tester.tap(find.byTooltip('Privacy details'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Cloud AI reads page labels'),
        findsNWidgets(2),
      );
      expect(
        find.textContaining('password and cookies are not captured'),
        findsOneWidget,
      );
    });
  });

  testWidgets(
    'progress uses real counts and shows only supported information',
    (tester) async {
      await tester.pumpWidget(
        host(
          const PortalProgressOverview(
            coursesCount: 3,
            meetingsCount: 0,
            fromCache: true,
          ),
        ),
      );

      expect(find.text('3 courses found'), findsOneWidget);
      expect(
        find.text('Open your timetable to find meeting times'),
        findsOneWidget,
      );
      expect(find.text('Fees'), findsNothing);
      expect(find.text('Profile'), findsNothing);
      expect(find.text('Known page'), findsOneWidget);
      expect(find.text('Saved on device'), findsNothing);
    },
  );

  testWidgets('state message exposes recovery action accessibly', (
    tester,
  ) async {
    var resumed = false;
    await tester.pumpWidget(
      host(
        PortalStateMessage(
          title: 'Portal session ended',
          message: 'Sign in again to keep checking for course updates.',
          icon: Icons.lock_clock_rounded,
          actionLabel: 'Resume',
          onAction: () => resumed = true,
        ),
      ),
    );

    expect(
      find.bySemanticsLabel(RegExp('Portal session ended')),
      findsOneWidget,
    );
    await tester.tap(find.text('Resume'));
    expect(resumed, isTrue);
  });

  testWidgets(
    'review presents course and timetable details with save and discard',
    (tester) async {
      var saved = false;
      var discarded = false;
      final draft = PortalDraft(
        sourceOrigin: 'https://portal.example.edu',
        observedAt: DateTime(2026, 10, 4),
        courses: const [
          PortalCourseDraft(
            sourceId: 'c1',
            code: 'BIO 210',
            title: 'Cell Biology',
            term: 'Autumn',
          ),
        ],
        meetings: const [
          PortalMeetingDraft(
            sourceId: 'm1',
            courseSourceId: 'c1',
            day: 'Monday',
            startTime: '09:00',
            endTime: '10:30',
            venue: 'Science Hall 2',
          ),
        ],
      );
      await tester.pumpWidget(
        host(
          PortalImportReview(
            draft: draft,
            onSave: () => saved = true,
            onDiscard: () => discarded = true,
          ),
        ),
      );

      expect(find.text('Cell Biology'), findsNWidgets(2));
      expect(find.text('BIO 210 · Autumn'), findsOneWidget);
      expect(
        find.text('Monday · 09:00–10:30 · Science Hall 2'),
        findsOneWidget,
      );
      expect(find.textContaining('{'), findsNothing);
      await tester.tap(find.text('Save reviewed information'));
      await tester.tap(find.text('Discard'));
      expect(saved, isTrue);
      expect(discarded, isTrue);
    },
  );
}
