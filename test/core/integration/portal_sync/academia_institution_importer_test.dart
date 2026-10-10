import 'package:academia/core/integration/portal_sync/academia_institution_importer.dart';
import 'package:academia/core/integration/portal_sync/academia_portal_importer.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:institutions/institutions.dart';
import 'package:portal_sync/portal_sync.dart';

void main() {
  late _ProfileRepository profileRepository;
  late _FeeRepository feeRepository;
  late _Ledger ledger;
  late AcademiaInstitutionPortalImporter importer;
  var currentAccount = 'student';

  setUp(() {
    profileRepository = _ProfileRepository();
    feeRepository = _FeeRepository();
    ledger = _Ledger();
    currentAccount = 'student';
    importer = AcademiaInstitutionPortalImporter(
      profileRepository: profileRepository,
      feeRepository: feeRepository,
      ledger: ledger,
      accountId: 'student',
      institutionId: 10,
      isCurrentAccount: () => currentAccount == 'student',
    );
  });

  PortalProfileFeeDraft draft({
    List<PortalProfileFieldDraft> fields = const [],
    List<PortalFeeLineItemDraft> lines = const [],
  }) => PortalProfileFeeDraft(
    profileFields: fields,
    feeLineItems: lines,
    sourceOrigin: 'https://portal.school.edu',
    observedAt: DateTime.utc(2026, 10, 4),
  );

  const nameField = PortalProfileFieldDraft(
    sourceId: 'field-name',
    fieldKey: 'fullName',
    sourcePage: '/profile',
    rawValue: 'Jane Doe',
  );

  const tuitionLine = PortalFeeLineItemDraft(
    sourceId: 'line-tuition',
    kind: 'debit',
    description: 'Tuition fee',
    rawAmount: '1,500,000',
    currencyText: 'UGX',
    sourcePage: '/fees',
  );

  test('saves a new profile field and fee line', () async {
    final result = await importer.importProfileFeeDraft(
      draft(fields: [nameField], lines: [tuitionLine]),
    );
    expect(result.importedProfileFields, 1);
    expect(result.importedFeeLineItems, 1);
    final profile = (await profileRepository.getProfile(
      accountId: 'student',
      institutionId: 10,
    )).fold((_) => null, (value) => value);
    expect(
      profile?.fields[AcademicProfileFieldKey.fullName]?.displayValue,
      'Jane Doe',
    );
    final statement = (await feeRepository.getFeeStatement(
      accountId: 'student',
      institutionId: 10,
      term: 'current',
    )).fold((_) => null, (value) => value);
    expect(statement?.lineItems.single.amount.currencyCode, 'UGX');
  });

  test('retry does not duplicate a profile field or fee line', () async {
    await importer.importProfileFeeDraft(
      draft(fields: [nameField], lines: [tuitionLine]),
    );
    await importer.importProfileFeeDraft(
      draft(fields: [nameField], lines: [tuitionLine]),
    );
    final profile = (await profileRepository.getProfile(
      accountId: 'student',
      institutionId: 10,
    )).fold((_) => null, (value) => value);
    expect(profile?.fields, hasLength(1));
    final statement = (await feeRepository.getFeeStatement(
      accountId: 'student',
      institutionId: 10,
      term: 'current',
    )).fold((_) => null, (value) => value);
    expect(statement?.lineItems, hasLength(1));
  });

  test('a changed portal value updates the stored field on re-import', () async {
    await importer.importProfileFeeDraft(draft(fields: [nameField]));
    const renamed = PortalProfileFieldDraft(
      sourceId: 'field-name',
      fieldKey: 'fullName',
      sourcePage: '/profile',
      rawValue: 'Jane A. Doe',
    );
    await importer.importProfileFeeDraft(draft(fields: [renamed]));
    final profile = (await profileRepository.getProfile(
      accountId: 'student',
      institutionId: 10,
    )).fold((_) => null, (value) => value);
    expect(
      profile?.fields[AcademicProfileFieldKey.fullName]?.displayValue,
      'Jane A. Doe',
    );
  });

  test('a manually edited field is preserved on the next import', () async {
    await importer.importProfileFeeDraft(draft(fields: [nameField]));
    // Simulate the student manually editing the saved profile.
    final existing = (await profileRepository.getProfile(
      accountId: 'student',
      institutionId: 10,
    )).fold((_) => null, (value) => value)!;
    await profileRepository.upsertProfile(
      existing.copyWith(
        fields: {
          AcademicProfileFieldKey.fullName: AcademicProfileFieldValue(
            key: AcademicProfileFieldKey.fullName,
            evidence: FieldEvidence(
              sourcePage: '/profile',
              observedAt: DateTime.utc(2026, 10, 5),
              sourceAccount: 'student',
              originalValue: 'My Preferred Name',
              normalizedValue: 'My Preferred Name',
              validationOutcome: FieldValidationOutcome.valid,
            ),
          ),
        },
      ),
    );
    final result = await importer.importProfileFeeDraft(
      draft(
        fields: const [
          PortalProfileFieldDraft(
            sourceId: 'field-name',
            fieldKey: 'fullName',
            sourcePage: '/profile',
            rawValue: 'Jane Doe Again',
          ),
        ],
      ),
    );
    final profile = (await profileRepository.getProfile(
      accountId: 'student',
      institutionId: 10,
    )).fold((_) => null, (value) => value);
    expect(
      profile?.fields[AcademicProfileFieldKey.fullName]?.displayValue,
      'My Preferred Name',
    );
    expect(result.message, contains('kept'));
  });

  test('a fee line absent from a later partial capture is never deleted', () async {
    const creditLine = PortalFeeLineItemDraft(
      sourceId: 'line-credit',
      kind: 'credit',
      description: 'Bank payment',
      rawAmount: '500,000',
      currencyText: 'UGX',
      sourcePage: '/fees',
    );
    await importer.importProfileFeeDraft(
      draft(lines: [tuitionLine, creditLine]),
    );
    // A later, partial capture only observes one line.
    await importer.importProfileFeeDraft(draft(lines: [tuitionLine]));
    final statement = (await feeRepository.getFeeStatement(
      accountId: 'student',
      institutionId: 10,
      term: 'current',
    )).fold((_) => null, (value) => value);
    expect(statement?.lineItems, hasLength(2));
  });

  test('account change stops writes', () async {
    currentAccount = 'someone-else';
    await expectLater(
      importer.importProfileFeeDraft(draft(fields: [nameField])),
      throwsStateError,
    );
  });
}

class _Ledger implements PortalImportLedger {
  final values = <String, PortalImportLink>{};
  @override
  Future<PortalImportLink?> get(String key) async => values[key];
  @override
  Future<void> put(String key, PortalImportLink value) async {
    values[key] = value;
  }
}

class _ProfileRepository implements InstitutionProfileRepository {
  AcademicProfileEntity? stored;

  @override
  Future<Either<Failure, AcademicProfileEntity?>> getProfile({
    required String accountId,
    required int institutionId,
  }) async => Right(stored);

  @override
  Future<Either<Failure, AcademicProfileEntity>> upsertProfile(
    AcademicProfileEntity profile,
  ) async {
    stored = stored?.mergedWith(profile) ?? profile;
    return Right(stored!);
  }

  @override
  Future<Either<Failure, Unit>> clearAccount(String accountId) async {
    stored = null;
    return const Right(unit);
  }
}

class _FeeRepository implements InstitutionFeeRepository {
  FeeStatementEntity? stored;

  @override
  Future<Either<Failure, FeeStatementEntity?>> getFeeStatement({
    required String accountId,
    required int institutionId,
    String? term,
  }) async => Right(stored);

  @override
  Future<Either<Failure, List<FeeStatementEntity>>> listFeeStatements({
    required String accountId,
    required int institutionId,
  }) async => Right(stored == null ? const [] : [stored!]);

  @override
  Future<Either<Failure, FeeStatementEntity>> upsertFeeStatement(
    FeeStatementEntity statement,
  ) async {
    stored = stored?.mergedWith(statement) ?? statement;
    return Right(stored!);
  }

  @override
  Future<Either<Failure, Unit>> clearAccount(String accountId) async {
    stored = null;
    return const Right(unit);
  }
}
