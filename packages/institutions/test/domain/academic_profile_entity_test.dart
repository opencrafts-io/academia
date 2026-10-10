import 'package:flutter_test/flutter_test.dart';
import 'package:institutions/institutions.dart';

void main() {
  AcademicProfileFieldValue fieldValue(
    AcademicProfileFieldKey key,
    String original, {
    String? normalized,
    FieldValidationOutcome outcome = FieldValidationOutcome.valid,
    DateTime? observedAt,
  }) => AcademicProfileFieldValue(
    key: key,
    evidence: FieldEvidence(
      sourcePage: '/student/profile',
      observedAt: observedAt ?? DateTime.utc(2026, 10, 1),
      sourceAccount: 'student-1',
      originalValue: original,
      normalizedValue: normalized,
      validationOutcome: outcome,
    ),
  );

  test('a profile with at least one valid field is valid', () {
    final profile = AcademicProfileEntity(
      sourceId: 'src-1',
      accountId: 'student-1',
      institutionId: 10,
      fields: {
        AcademicProfileFieldKey.fullName: fieldValue(
          AcademicProfileFieldKey.fullName,
          'Jane Doe',
          normalized: 'Jane Doe',
        ),
      },
      observedAt: DateTime.utc(2026, 10, 1),
    );
    expect(profile.isValid, isTrue);
  });

  test('a profile with only rejected/unvalidated fields is not valid', () {
    final profile = AcademicProfileEntity(
      sourceId: 'src-1',
      accountId: 'student-1',
      institutionId: 10,
      fields: {
        AcademicProfileFieldKey.fullName: fieldValue(
          AcademicProfileFieldKey.fullName,
          'Jane Doe',
          outcome: FieldValidationOutcome.unvalidated,
        ),
      },
      observedAt: DateTime.utc(2026, 10, 1),
    );
    expect(profile.isValid, isFalse);
  });

  test('rejected fields have no display value', () {
    final value = fieldValue(
      AcademicProfileFieldKey.phoneNumber,
      '0712 345 678',
      outcome: FieldValidationOutcome.rejected,
    );
    expect(value.displayValue, isNull);
  });

  test(
    'merging a partial capture keeps previously observed fields absent from it',
    () {
      final original = AcademicProfileEntity(
        sourceId: 'src-1',
        accountId: 'student-1',
        institutionId: 10,
        fields: {
          AcademicProfileFieldKey.fullName: fieldValue(
            AcademicProfileFieldKey.fullName,
            'Jane Doe',
            normalized: 'Jane Doe',
          ),
          AcademicProfileFieldKey.registrationNumber: fieldValue(
            AcademicProfileFieldKey.registrationNumber,
            'REG-001',
            normalized: 'REG-001',
          ),
        },
        observedAt: DateTime.utc(2026, 10, 1),
      );
      final partial = AcademicProfileEntity(
        sourceId: 'src-1',
        accountId: 'student-1',
        institutionId: 10,
        fields: {
          AcademicProfileFieldKey.registrationNumber: fieldValue(
            AcademicProfileFieldKey.registrationNumber,
            'REG-002',
            normalized: 'REG-002',
            observedAt: DateTime.utc(2026, 10, 2),
          ),
        },
        observedAt: DateTime.utc(2026, 10, 2),
      );
      final merged = original.mergedWith(partial);
      expect(
        merged.fields[AcademicProfileFieldKey.fullName]?.displayValue,
        'Jane Doe',
      );
      expect(
        merged.fields[AcademicProfileFieldKey.registrationNumber]
            ?.displayValue,
        'REG-002',
      );
    },
  );

  test('round-trips through JSON', () {
    final profile = AcademicProfileEntity(
      sourceId: 'src-1',
      accountId: 'student-1',
      institutionId: 10,
      fields: {
        AcademicProfileFieldKey.programme: fieldValue(
          AcademicProfileFieldKey.programme,
          'BSc Computer Science',
          normalized: 'BSc Computer Science',
        ),
      },
      observedAt: DateTime.utc(2026, 10, 1),
    );
    final decoded = AcademicProfileEntity.fromJson(profile.toJson());
    expect(decoded.sourceId, profile.sourceId);
    expect(
      decoded.fields[AcademicProfileFieldKey.programme]?.displayValue,
      'BSc Computer Science',
    );
  });
}
