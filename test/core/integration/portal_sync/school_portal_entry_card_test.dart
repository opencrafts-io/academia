import 'package:academia/core/integration/portal_sync/school_portal_entry_card.dart';
import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _firstSchool = Institution(
  institutionId: 12,
  name: 'Example University',
  webPages: [],
  domains: [],
  alphaTwoCode: null,
  country: null,
);
const _secondSchool = Institution(
  institutionId: 34,
  name: 'Another University',
  webPages: [],
  domains: [],
  alphaTwoCode: null,
  country: null,
);

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('opens portal setup directly for the only linked school', (
    tester,
  ) async {
    int? selected;
    await tester.pumpWidget(
      _host(
        SchoolPortalEntryCard(
          schools: const [_firstSchool],
          onSelectSchool: (id) => selected = id,
          onLinkSchool: () {},
        ),
      ),
    );
    await tester.tap(find.text('School portal sync'));
    expect(selected, 12);
  });

  testWidgets(
    'asks which linked school to sync instead of choosing one silently',
    (tester) async {
      int? selected;
      await tester.pumpWidget(
        _host(
          SchoolPortalEntryCard(
            schools: const [_firstSchool, _secondSchool],
            onSelectSchool: (id) => selected = id,
            onLinkSchool: () {},
          ),
        ),
      );
      await tester.tap(find.text('School portal sync'));
      await tester.pumpAndSettle();
      expect(selected, isNull);
      expect(find.text('Choose your school'), findsOneWidget);
      await tester.tap(find.text('Another University'));
      await tester.pumpAndSettle();
      expect(selected, 34);
      expect(find.text('Choose your school'), findsNothing);
    },
  );

  testWidgets('offers school linking when there are no linked schools', (
    tester,
  ) async {
    var linking = false;
    await tester.pumpWidget(
      _host(
        SchoolPortalEntryCard(
          schools: const [],
          onSelectSchool: (_) => fail('No school to select'),
          onLinkSchool: () => linking = true,
        ),
      ),
    );
    await tester.tap(find.text('School portal sync'));
    expect(linking, isTrue);
  });

  testWidgets('does not navigate while schools are loading', (tester) async {
    await tester.pumpWidget(
      _host(
        SchoolPortalEntryCard(
          schools: const [],
          isLoading: true,
          onSelectSchool: (_) => fail('Schools are not ready'),
          onLinkSchool: () => fail('Schools are not ready'),
        ),
      ),
    );
    await tester.tap(find.text('School portal sync'));
    expect(find.text('Loading your schools…'), findsOneWidget);
  });
}
