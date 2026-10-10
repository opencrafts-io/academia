import 'package:flutter_test/flutter_test.dart';
import 'package:institutions/institutions.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AcademicProfileFieldValue fieldValue(
    AcademicProfileFieldKey key,
    String value,
  ) => AcademicProfileFieldValue(
    key: key,
    evidence: FieldEvidence(
      sourcePage: '/student/profile',
      observedAt: DateTime.utc(2026, 10, 1),
      sourceAccount: 'student-1',
      originalValue: value,
      normalizedValue: value,
      validationOutcome: FieldValidationOutcome.valid,
    ),
  );

  group('SharedPreferencesInstitutionProfileRepository', () {
    test('upsert merges into the existing stored profile', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = SharedPreferencesInstitutionProfileRepository(prefs);

      await repository.upsertProfile(
        AcademicProfileEntity(
          sourceId: 'src-1',
          accountId: 'student-1',
          institutionId: 10,
          fields: {
            AcademicProfileFieldKey.fullName: fieldValue(
              AcademicProfileFieldKey.fullName,
              'Jane Doe',
            ),
          },
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      final result = await repository.upsertProfile(
        AcademicProfileEntity(
          sourceId: 'src-1',
          accountId: 'student-1',
          institutionId: 10,
          fields: {
            AcademicProfileFieldKey.registrationNumber: fieldValue(
              AcademicProfileFieldKey.registrationNumber,
              'REG-1',
            ),
          },
          observedAt: DateTime.utc(2026, 10, 2),
        ),
      );
      final merged = result.fold((_) => null, (value) => value);
      expect(merged, isNotNull);
      expect(
        merged!.fields[AcademicProfileFieldKey.fullName]?.displayValue,
        'Jane Doe',
      );
      expect(
        merged.fields[AcademicProfileFieldKey.registrationNumber]
            ?.displayValue,
        'REG-1',
      );

      final reread = await repository.getProfile(
        accountId: 'student-1',
        institutionId: 10,
      );
      expect(
        reread.fold((_) => null, (value) => value)?.fields.length,
        2,
      );
    });

    test('never creates a second profile for the same account/institution', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = SharedPreferencesInstitutionProfileRepository(prefs);
      for (var i = 0; i < 3; i++) {
        await repository.upsertProfile(
          AcademicProfileEntity(
            sourceId: 'src-1',
            accountId: 'student-1',
            institutionId: 10,
            fields: {
              AcademicProfileFieldKey.fullName: fieldValue(
                AcademicProfileFieldKey.fullName,
                'Jane Doe $i',
              ),
            },
            observedAt: DateTime.utc(2026, 10, 1),
          ),
        );
      }
      final keys = prefs
          .getKeys()
          .where((key) => key.startsWith('institutions_profile_v1_'));
      expect(keys, hasLength(1));
    });

    test('clearAccount removes only the matching account', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = SharedPreferencesInstitutionProfileRepository(prefs);
      await repository.upsertProfile(
        AcademicProfileEntity(
          sourceId: 'src-1',
          accountId: 'student-1',
          institutionId: 10,
          fields: {
            AcademicProfileFieldKey.fullName: fieldValue(
              AcademicProfileFieldKey.fullName,
              'Jane',
            ),
          },
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      await repository.upsertProfile(
        AcademicProfileEntity(
          sourceId: 'src-2',
          accountId: 'student-2',
          institutionId: 10,
          fields: {
            AcademicProfileFieldKey.fullName: fieldValue(
              AcademicProfileFieldKey.fullName,
              'John',
            ),
          },
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      await repository.clearAccount('student-1');
      final remainingOne = await repository.getProfile(
        accountId: 'student-1',
        institutionId: 10,
      );
      final remainingTwo = await repository.getProfile(
        accountId: 'student-2',
        institutionId: 10,
      );
      expect(remainingOne.fold((_) => null, (value) => value), isNull);
      expect(remainingTwo.fold((_) => null, (value) => value), isNotNull);
    });
  });

  FeeLineItemEntity line(String sourceId, String rawAmount) =>
      FeeLineItemEntity(
        sourceId: sourceId,
        kind: FeeLineKind.debit,
        description: 'Tuition fee',
        amount: MonetaryAmount.observe(currencyText: 'UGX', rawAmount: rawAmount),
        evidence: FieldEvidence(
          sourcePage: '/fees',
          observedAt: DateTime.utc(2026, 10, 1),
          sourceAccount: 'student-1',
          originalValue: rawAmount,
          normalizedValue: MonetaryAmount.normalizeLocalizedAmount(rawAmount),
          validationOutcome: FieldValidationOutcome.valid,
        ),
      );

  group('SharedPreferencesInstitutionFeeRepository', () {
    test('upsert merges line items by source id and never duplicates a statement', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = SharedPreferencesInstitutionFeeRepository(prefs);

      await repository.upsertFeeStatement(
        FeeStatementEntity(
          sourceId: 'stmt-1',
          accountId: 'student-1',
          institutionId: 10,
          term: '2026/1',
          lineItems: [line('l1', '100,000')],
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      await repository.upsertFeeStatement(
        FeeStatementEntity(
          sourceId: 'stmt-1',
          accountId: 'student-1',
          institutionId: 10,
          term: '2026/1',
          lineItems: [line('l2', '50,000')],
          observedAt: DateTime.utc(2026, 10, 2),
        ),
      );

      final listed = await repository.listFeeStatements(
        accountId: 'student-1',
        institutionId: 10,
      );
      final statements = listed.fold((_) => const [], (value) => value);
      expect(statements, hasLength(1));
      expect(statements.single.lineItems, hasLength(2));
    });

    test('statements for different terms are kept separate', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repository = SharedPreferencesInstitutionFeeRepository(prefs);
      await repository.upsertFeeStatement(
        FeeStatementEntity(
          sourceId: 'stmt-1',
          accountId: 'student-1',
          institutionId: 10,
          term: '2026/1',
          lineItems: [line('l1', '100')],
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      await repository.upsertFeeStatement(
        FeeStatementEntity(
          sourceId: 'stmt-2',
          accountId: 'student-1',
          institutionId: 10,
          term: '2026/2',
          lineItems: [line('l2', '200')],
          observedAt: DateTime.utc(2026, 10, 1),
        ),
      );
      final listed = await repository.listFeeStatements(
        accountId: 'student-1',
        institutionId: 10,
      );
      expect(listed.fold((_) => const [], (value) => value), hasLength(2));
    });
  });
}
