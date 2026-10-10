/// Outcome of validating one observed field against a supported shape.
///
/// `unvalidated` means the value was captured but has not yet been checked
/// (for example, a localized number or date whose format was not recognized).
/// Only `valid` fields should be treated as confirmed for review/import;
/// `rejected` fields are retained for transparency but must not be imported.
enum FieldValidationOutcome { unvalidated, valid, rejected }

/// Field-level provenance for one observed value, per the portal-sync plan's
/// "Data quality and student protection" section: source page/document,
/// observation time, source account, original value, normalized value, and
/// validation outcome. This is intentionally generic so both profile fields
/// and fee line items can carry the same shape of evidence.
class FieldEvidence {
  const FieldEvidence({
    required this.sourcePage,
    required this.observedAt,
    required this.sourceAccount,
    required this.originalValue,
    this.normalizedValue,
    this.validationOutcome = FieldValidationOutcome.unvalidated,
  });

  /// The portal page path/document this value was read from. Never a full
  /// URL with query parameters or a student-identifying value.
  final String sourcePage;

  /// When the value was observed on the device, in UTC.
  final DateTime observedAt;

  /// The Academia account the observation belongs to. Never used to look up
  /// another student's values.
  final String sourceAccount;

  /// The raw text as captured, preserving localized date/number formats
  /// until validated. Never silently reformatted.
  final String originalValue;

  /// The normalized value once validated; null until validation succeeds.
  final String? normalizedValue;

  final FieldValidationOutcome validationOutcome;

  bool get isValid => validationOutcome == FieldValidationOutcome.valid;

  FieldEvidence copyWith({
    String? sourcePage,
    DateTime? observedAt,
    String? sourceAccount,
    String? originalValue,
    String? normalizedValue,
    bool clearNormalizedValue = false,
    FieldValidationOutcome? validationOutcome,
  }) => FieldEvidence(
    sourcePage: sourcePage ?? this.sourcePage,
    observedAt: observedAt ?? this.observedAt,
    sourceAccount: sourceAccount ?? this.sourceAccount,
    originalValue: originalValue ?? this.originalValue,
    normalizedValue: clearNormalizedValue
        ? null
        : normalizedValue ?? this.normalizedValue,
    validationOutcome: validationOutcome ?? this.validationOutcome,
  );

  Map<String, Object?> toJson() => {
    'sourcePage': sourcePage,
    'observedAt': observedAt.toIso8601String(),
    'sourceAccount': sourceAccount,
    'originalValue': originalValue,
    'normalizedValue': normalizedValue,
    'validationOutcome': validationOutcome.name,
  };

  factory FieldEvidence.fromJson(Map<String, Object?> json) => FieldEvidence(
    sourcePage: json['sourcePage'] as String,
    observedAt: DateTime.parse(json['observedAt'] as String),
    sourceAccount: json['sourceAccount'] as String,
    originalValue: json['originalValue'] as String,
    normalizedValue: json['normalizedValue'] as String?,
    validationOutcome: FieldValidationOutcome.values.firstWhere(
      (value) => value.name == json['validationOutcome'],
      orElse: () => FieldValidationOutcome.unvalidated,
    ),
  );

  @override
  bool operator ==(Object other) =>
      other is FieldEvidence &&
      other.sourcePage == sourcePage &&
      other.observedAt == observedAt &&
      other.sourceAccount == sourceAccount &&
      other.originalValue == originalValue &&
      other.normalizedValue == normalizedValue &&
      other.validationOutcome == validationOutcome;

  @override
  int get hashCode => Object.hash(
    sourcePage,
    observedAt,
    sourceAccount,
    originalValue,
    normalizedValue,
    validationOutcome,
  );
}
