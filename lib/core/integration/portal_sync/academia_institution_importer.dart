import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:institutions/institutions.dart';
import 'package:portal_sync/portal_sync.dart';

import 'academia_portal_importer.dart'
    show PortalImportLedger, PortalImportLink;

/// Adapts reviewed portal profile/fee drafts to `packages/institutions`'
/// repositories, mirroring `AcademiaPortalImporter`'s identity/ledger
/// pattern: stable import identity, merge-not-replace on repeat import, and
/// manual-edit preservation via a per-field/per-line baseline hash.
///
/// Fee statements are not yet grouped by term here -- every extracted fee
/// line is written into one statement per account/institution. Term
/// grouping is tracked as open work in `docs/portal-sync-internal.md`.
class AcademiaInstitutionPortalImporter implements PortalProfileFeeImporter {
  AcademiaInstitutionPortalImporter({
    required this.profileRepository,
    required this.feeRepository,
    required this.ledger,
    required this.accountId,
    required this.institutionId,
    required this.isCurrentAccount,
  });

  final InstitutionProfileRepository profileRepository;
  final InstitutionFeeRepository feeRepository;
  final PortalImportLedger ledger;
  final String accountId;
  final int institutionId;
  final bool Function() isCurrentAccount;
  bool _saving = false;

  static const String _statementTerm = 'current';

  void _checkAccount() {
    if (!isCurrentAccount()) throw StateError('The signed-in account changed.');
  }

  String _key(String origin, String kind, String sourceId) =>
      'institution_import_v1_${_hash([accountId, institutionId, origin, kind, sourceId])}';

  @override
  Future<PortalProfileFeeImportResult> importProfileFeeDraft(
    PortalProfileFeeDraft draft,
  ) async {
    _checkAccount();
    if (_saving || !draft.isValid) {
      throw StateError('No validated import is ready.');
    }
    _saving = true;
    try {
      var kept = 0;
      final fieldsSaved = await _saveProfileFields(draft, onKept: () => kept++);
      final linesSaved = await _saveFeeLines(draft, onKept: () => kept++);
      return PortalProfileFeeImportResult(
        importedProfileFields: fieldsSaved,
        importedFeeLineItems: linesSaved,
        message: kept > 0
            ? 'Saved $fieldsSaved profile fields and $linesSaved fee lines. $kept existing or manually edited values were kept.'
            : 'Saved $fieldsSaved profile fields and $linesSaved fee statement lines.',
      );
    } finally {
      _saving = false;
    }
  }

  Future<int> _saveProfileFields(
    PortalProfileFeeDraft draft, {
    required void Function() onKept,
  }) async {
    if (draft.profileFields.isEmpty) return 0;
    _checkAccount();
    final existing = (await profileRepository.getProfile(
      accountId: accountId,
      institutionId: institutionId,
    )).fold((_) => null, (value) => value);
    final existingFields = existing?.fields ?? const {};
    final toWrite = <AcademicProfileFieldKey, AcademicProfileFieldValue>{};
    var saved = 0;
    for (final fieldDraft in draft.profileFields) {
      _checkAccount();
      AcademicProfileFieldKey? fieldKey;
      for (final candidate in AcademicProfileFieldKey.values) {
        if (candidate.name == fieldDraft.fieldKey) {
          fieldKey = candidate;
          break;
        }
      }
      if (fieldKey == null) {
        // Not a field this app supports importing; never written.
        onKept();
        continue;
      }
      final key = _key(draft.sourceOrigin, 'profile_field', fieldDraft.sourceId);
      final link = await ledger.get(key);
      final normalized = fieldDraft.rawValue.trim();
      final desiredHash = _hash([normalized]);
      final currentValue = existingFields[fieldKey];
      final currentHash = currentValue == null
          ? null
          : _hash([currentValue.evidence.originalValue]);
      if (link != null && currentHash != null && currentHash != link.baselineHash) {
        // The stored value diverged from our last import baseline: a manual
        // edit happened since. Preserve it rather than overwriting silently.
        onKept();
        continue;
      }
      if (currentValue != null && currentHash == desiredHash) {
        continue; // Unchanged; nothing to write or re-link.
      }
      final value = AcademicProfileFieldValue(
        key: fieldKey,
        evidence: FieldEvidence(
          sourcePage: fieldDraft.sourcePage,
          observedAt: draft.observedAt,
          sourceAccount: accountId,
          originalValue: normalized,
          normalizedValue: normalized,
          validationOutcome: FieldValidationOutcome.valid,
        ),
      );
      toWrite[fieldKey] = value;
      await ledger.put(key, PortalImportLink(fieldDraft.sourceId, desiredHash));
      saved++;
    }
    if (toWrite.isNotEmpty) {
      _checkAccount();
      final profile = AcademicProfileEntity(
        sourceId: _hash([accountId, institutionId, 'profile']),
        accountId: accountId,
        institutionId: institutionId,
        fields: toWrite,
        observedAt: draft.observedAt,
      );
      final result = await profileRepository.upsertProfile(profile);
      result.fold(
        (_) => throw StateError('Could not save the academic profile.'),
        (_) {},
      );
    }
    return saved;
  }

  Future<int> _saveFeeLines(
    PortalProfileFeeDraft draft, {
    required void Function() onKept,
  }) async {
    if (draft.feeLineItems.isEmpty) return 0;
    _checkAccount();
    final existing = (await feeRepository.getFeeStatement(
      accountId: accountId,
      institutionId: institutionId,
      term: _statementTerm,
    )).fold((_) => null, (value) => value);
    final existingLines = {
      for (final item in existing?.lineItems ?? const <FeeLineItemEntity>[])
        item.sourceId: item,
    };
    final toWrite = <FeeLineItemEntity>[];
    var saved = 0;
    for (final lineDraft in draft.feeLineItems) {
      _checkAccount();
      FeeLineKind? kind;
      for (final candidate in FeeLineKind.values) {
        if (candidate.name == lineDraft.kind) {
          kind = candidate;
          break;
        }
      }
      if (kind == null) {
        onKept();
        continue;
      }
      final key = _key(draft.sourceOrigin, 'fee_line', lineDraft.sourceId);
      final link = await ledger.get(key);
      final desiredHash = _hash([
        lineDraft.description,
        lineDraft.rawAmount,
        lineDraft.currencyText,
        lineDraft.rawDate,
      ]);
      final current = existingLines[lineDraft.sourceId];
      final currentHash = current == null
          ? null
          : _hash([
              current.description,
              current.amount.rawAmount,
              current.amount.currencyCode,
              current.rawDate,
            ]);
      if (link != null && currentHash != null && currentHash != link.baselineHash) {
        onKept();
        continue;
      }
      if (current != null && currentHash == desiredHash) {
        continue;
      }
      final amount = MonetaryAmount.observe(
        currencyText: lineDraft.currencyText,
        rawAmount: lineDraft.rawAmount,
      );
      final line = FeeLineItemEntity(
        sourceId: lineDraft.sourceId,
        kind: kind,
        description: lineDraft.description,
        amount: amount,
        rawDate: lineDraft.rawDate,
        evidence: FieldEvidence(
          sourcePage: lineDraft.sourcePage,
          observedAt: draft.observedAt,
          sourceAccount: accountId,
          originalValue: lineDraft.rawAmount,
          normalizedValue: amount.normalizedAmount,
          validationOutcome: amount.validationOutcome,
        ),
      );
      toWrite.add(line);
      await ledger.put(key, PortalImportLink(lineDraft.sourceId, desiredHash));
      saved++;
    }
    if (toWrite.isNotEmpty) {
      _checkAccount();
      final statement = FeeStatementEntity(
        sourceId: _hash([accountId, institutionId, _statementTerm]),
        accountId: accountId,
        institutionId: institutionId,
        term: _statementTerm,
        lineItems: toWrite,
        observedAt: draft.observedAt,
      );
      final result = await feeRepository.upsertFeeStatement(statement);
      result.fold(
        (_) => throw StateError('Could not save the fee statement.'),
        (_) {},
      );
    }
    return saved;
  }

  static String _hash(List<Object?> fields) =>
      sha256.convert(utf8.encode(jsonEncode(fields))).toString();
}
