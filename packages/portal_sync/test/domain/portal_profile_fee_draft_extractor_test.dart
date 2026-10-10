import 'package:flutter_test/flutter_test.dart';
import 'package:portal_sync/src/domain/entities/portal_analysis_plan.dart';
import 'package:portal_sync/src/domain/entities/portal_connection.dart';
import 'package:portal_sync/src/domain/entities/portal_profile_fee_draft_extractor.dart';
import 'package:portal_sync/src/domain/entities/portal_snapshot.dart';

void main() {
  final connection = PortalConnection(
    accountId: 'account-a',
    institutionId: 9,
    schoolName: 'Example University',
    portalUri: Uri.parse('https://portal.example.edu'),
  );
  const extractor = PortalProfileFeeDraftExtractor();

  group('profile fields', () {
    test('extracts labelled field values validated by the plan', () {
      final snapshot = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/student/profile',
        'title': 'Student profile',
        'language': 'en',
        'nodes': [
          {
            'id': 'field-reg',
            'kind': 'field',
            'label': 'Registration number',
            'headers': [],
            'rows': [],
            'value': 'REG-12345',
          },
          {
            'id': 'field-name',
            'kind': 'field',
            'label': 'Full name',
            'headers': [],
            'rows': [],
            'value': 'Jane Doe',
          },
        ],
      });
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'profile',
        'tables': [],
        'fields': [
          {'nodeId': 'field-reg', 'fieldKey': 'registrationNumber'},
          {'nodeId': 'field-name', 'fieldKey': 'fullName'},
        ],
      });
      final draft = extractor.extract(connection, [(snapshot, plan)]);
      expect(draft, isNotNull);
      expect(draft!.profileFields, hasLength(2));
      expect(
        draft.profileFields
            .firstWhere((f) => f.fieldKey == 'fullName')
            .rawValue,
        'Jane Doe',
      );
    });

    test('an invalid plan produces no draft', () {
      final snapshot = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/student/profile',
        'title': 'Student profile',
        'language': 'en',
        'nodes': [
          {
            'id': 'field-reg',
            'kind': 'table',
            'label': 'Registration number',
            'headers': ['a'],
            'rows': [],
          },
        ],
      });
      // Field mapping points at a table node, which is invalid.
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'profile',
        'tables': [],
        'fields': [
          {'nodeId': 'field-reg', 'fieldKey': 'fullName'},
        ],
      });
      expect(extractor.extract(connection, [(snapshot, plan)]), isNull);
    });

    test('identity is stable across repeated captures of the same field', () {
      final snapshot = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/student/profile',
        'title': 'Student profile',
        'language': 'en',
        'nodes': [
          {
            'id': 'field-name',
            'kind': 'field',
            'label': 'Full name',
            'headers': [],
            'rows': [],
            'value': 'Jane Doe',
          },
        ],
      });
      final plan = PortalAnalysisPlan.fromJson({
        'pageType': 'profile',
        'tables': [],
        'fields': [
          {'nodeId': 'field-name', 'fieldKey': 'fullName'},
        ],
      });
      final first = extractor.extract(connection, [(snapshot, plan)])!;
      final second = extractor.extract(connection, [(snapshot, plan)])!;
      expect(
        first.profileFields.single.sourceId,
        second.profileFields.single.sourceId,
      );
    });
  });

  group('fee statement line items', () {
    PortalSnapshot feeSnapshot(List<List<String>> rows) =>
        PortalSnapshot.fromJson({
          'origin': 'https://portal.example.edu',
          'path': '/fees',
          'title': 'Fee statement',
          'language': 'en',
          'nodes': [
            {
              'id': 'fee-table',
              'kind': 'table',
              'label': 'Fee statement',
              'headers': [
                'Date',
                'Description',
                'Debit',
                'Credit',
                'Balance',
                'Currency',
              ],
              'rows': rows,
            },
          ],
        });

    final plan = PortalAnalysisPlan.fromJson({
      'pageType': 'feeStatement',
      'tables': [
        {
          'nodeId': 'fee-table',
          'kind': 'feeLineItems',
          'columns': {
            'date': 0,
            'description': 1,
            'debit': 2,
            'credit': 3,
            'balance': 4,
            'currency': 5,
          },
        },
      ],
    });

    test(
      'distinguishes debit, credit and balance rows in a non-KES currency',
      () {
        final snapshot = feeSnapshot([
          ['2026-09-01', 'Tuition fee', '1,500,000', '', '', 'UGX'],
          ['2026-09-15', 'Bank payment', '', '500,000', '', 'UGX'],
          ['2026-09-15', 'Balance due', '', '', '1,000,000', 'UGX'],
        ]);
        final draft = extractor.extract(connection, [(snapshot, plan)]);
        expect(draft, isNotNull);
        expect(draft!.feeLineItems, hasLength(3));
        final tuition = draft.feeLineItems.firstWhere(
          (l) => l.description == 'Tuition fee',
        );
        expect(tuition.kind, 'debit');
        expect(tuition.rawAmount, '1,500,000');
        expect(tuition.currencyText, 'UGX');

        final payment = draft.feeLineItems.firstWhere(
          (l) => l.description == 'Bank payment',
        );
        expect(payment.kind, 'credit');

        final balanceDue = draft.feeLineItems.firstWhere(
          (l) => l.description == 'Balance due',
        );
        expect(balanceDue.kind, 'balanceDue');
      },
    );

    test('a plain running balance row is not labelled balance due', () {
      final snapshot = feeSnapshot([
        ['2026-09-01', 'Opening balance', '', '', '2,000,000', 'UGX'],
      ]);
      final draft = extractor.extract(connection, [(snapshot, plan)]);
      expect(draft!.feeLineItems.single.kind, 'runningBalance');
    });

    test('never fabricates a currency when the column is absent', () {
      final noCurrencyPlan = PortalAnalysisPlan.fromJson({
        'pageType': 'feeStatement',
        'tables': [
          {
            'nodeId': 'fee-table',
            'kind': 'feeLineItems',
            'columns': {'description': 1, 'debit': 2},
          },
        ],
      });
      final snapshot = feeSnapshot([
        ['2026-09-01', 'Tuition fee', '1,500,000', '', '', ''],
      ]);
      final draft = extractor.extract(connection, [
        (snapshot, noCurrencyPlan),
      ]);
      expect(draft!.feeLineItems.single.currencyText, isNull);
    });

    test('rows missing both a description and every amount column are skipped', () {
      final snapshot = feeSnapshot([
        ['2026-09-01', '', '', '', '', ''],
      ]);
      expect(extractor.extract(connection, [(snapshot, plan)]), isNull);
    });

    test('an invalid (generic) fee mapping yields no draft', () {
      final generic = PortalSnapshot.fromJson({
        'origin': 'https://portal.example.edu',
        'path': '/fees',
        'title': 'Fees',
        'language': 'en',
        'nodes': [
          {
            'id': 'fee-table',
            'kind': 'table',
            'label': 'Details',
            'headers': ['Code', 'Title'],
            'rows': [
              ['CS101', 'Algorithms'],
            ],
          },
        ],
      });
      final badPlan = PortalAnalysisPlan.fromJson({
        'pageType': 'feeStatement',
        'tables': [
          {
            'nodeId': 'fee-table',
            'kind': 'feeLineItems',
            'columns': {'description': 1},
          },
        ],
      });
      expect(extractor.extract(connection, [(generic, badPlan)]), isNull);
    });
  });
}
