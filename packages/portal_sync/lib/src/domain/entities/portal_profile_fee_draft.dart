/// Lightweight, locally extracted profile/fee drafts, mirroring the shape
/// of `PortalCourseDraft`/`PortalMeetingDraft` in `portal_draft.dart`. These
/// carry raw and (when confidently parsed) normalized text, plus minimal
/// identity/provenance -- not the richer field-level evidence model defined
/// in `package:institutions`. Building that evidence (which needs account
/// and connection context) is the composition root's job, exactly as
/// `AcademiaPortalImporter` builds `CourseEntity`/`ScheduleEntryEntity` from
/// `PortalCourseDraft`/`PortalMeetingDraft` today.
library;

class PortalProfileFieldDraft {
  const PortalProfileFieldDraft({
    required this.sourceId,
    required this.fieldKey,
    required this.sourcePage,
    required this.rawValue,
  });

  /// Stable import identity, derived from the connection/account/institution
  /// and the field key -- never from the value itself.
  final String sourceId;

  /// Matches `PortalProfileFieldKey.name` / `AcademicProfileFieldKey.name`.
  final String fieldKey;
  final String sourcePage;
  final String rawValue;
}

class PortalFeeLineItemDraft {
  const PortalFeeLineItemDraft({
    required this.sourceId,
    required this.kind,
    required this.description,
    required this.rawAmount,
    this.currencyText,
    this.rawDate,
    required this.sourcePage,
  });

  final String sourceId;

  /// Matches `FeeLineKind.name` in `package:institutions`
  /// ("debit"/"credit"/"runningBalance"/"balanceDue").
  final String kind;
  final String description;
  final String rawAmount;
  final String? currencyText;
  final String? rawDate;
  final String sourcePage;
}

/// An extracted, not-yet-saved set of profile fields and fee line items for
/// one portal connection. Analogous to `PortalDraft`, but for the
/// profile/fee_statement categories.
class PortalProfileFeeDraft {
  PortalProfileFeeDraft({
    required List<PortalProfileFieldDraft> profileFields,
    required List<PortalFeeLineItemDraft> feeLineItems,
    required this.sourceOrigin,
    required this.observedAt,
  }) : profileFields = List.unmodifiable(profileFields),
       feeLineItems = List.unmodifiable(feeLineItems);

  final List<PortalProfileFieldDraft> profileFields;
  final List<PortalFeeLineItemDraft> feeLineItems;
  final String sourceOrigin;
  final DateTime observedAt;

  bool get isValid {
    if (sourceOrigin.isEmpty) return false;
    if (profileFields.isEmpty && feeLineItems.isEmpty) return false;
    final fieldIds = <String>{};
    for (final field in profileFields) {
      if (field.sourceId.isEmpty ||
          field.fieldKey.trim().isEmpty ||
          field.rawValue.trim().isEmpty ||
          !fieldIds.add(field.sourceId)) {
        return false;
      }
    }
    final lineIds = <String>{};
    for (final line in feeLineItems) {
      if (line.sourceId.isEmpty ||
          line.description.trim().isEmpty ||
          line.rawAmount.trim().isEmpty ||
          !lineIds.add(line.sourceId)) {
        return false;
      }
    }
    return true;
  }
}

class PortalProfileFeeImportResult {
  const PortalProfileFeeImportResult({
    required this.importedProfileFields,
    required this.importedFeeLineItems,
    this.message,
  });

  final int importedProfileFields;
  final int importedFeeLineItems;
  final String? message;
}
