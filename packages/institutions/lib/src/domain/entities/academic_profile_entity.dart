import 'field_evidence.dart';

/// The bounded set of profile fields this app actually supports importing.
///
/// This is deliberately exhaustive and small: per the portal-sync plan,
/// "import only supported app fields; minimize profile data; national
/// identity and disability fields should not be collected merely because
/// the portal displays them." A portal page may show many more labelled
/// fields than this; anything outside this enum is never captured into a
/// profile, regardless of what the analysis model proposes, because the
/// model's field-mapping schema can only reference these keys.
enum AcademicProfileFieldKey {
  fullName,
  registrationNumber,
  programme,
  faculty,
  yearOfStudy,
  enrollmentStatus,
  institutionEmail,
  phoneNumber,
}

/// One observed, evidenced value for a single supported profile field.
class AcademicProfileFieldValue {
  const AcademicProfileFieldValue({
    required this.key,
    required this.evidence,
  });

  final AcademicProfileFieldKey key;
  final FieldEvidence evidence;

  /// The value to show/import: the normalized value once validated, or the
  /// original captured text while unvalidated. Never shown for a rejected
  /// field.
  String? get displayValue => switch (evidence.validationOutcome) {
    FieldValidationOutcome.rejected => null,
    FieldValidationOutcome.valid => evidence.normalizedValue,
    FieldValidationOutcome.unvalidated => evidence.originalValue,
  };

  AcademicProfileFieldValue copyWith({
    AcademicProfileFieldKey? key,
    FieldEvidence? evidence,
  }) => AcademicProfileFieldValue(
    key: key ?? this.key,
    evidence: evidence ?? this.evidence,
  );

  Map<String, Object?> toJson() => {
    'key': key.name,
    'evidence': evidence.toJson(),
  };

  factory AcademicProfileFieldValue.fromJson(Map<String, Object?> json) =>
      AcademicProfileFieldValue(
        key: AcademicProfileFieldKey.values.firstWhere(
          (value) => value.name == json['key'],
        ),
        evidence: FieldEvidence.fromJson(
          json['evidence'] as Map<String, Object?>,
        ),
      );

  @override
  bool operator ==(Object other) =>
      other is AcademicProfileFieldValue &&
      other.key == key &&
      other.evidence == evidence;

  @override
  int get hashCode => Object.hash(key, evidence);
}

/// A student's academic profile as observed from a school portal, scoped to
/// one institution membership. This entity never carries a national ID,
/// disability status, or any field outside [AcademicProfileFieldKey].
class AcademicProfileEntity {
  AcademicProfileEntity({
    required this.sourceId,
    required this.accountId,
    required this.institutionId,
    required Map<AcademicProfileFieldKey, AcademicProfileFieldValue> fields,
    required this.observedAt,
  }) : fields = Map.unmodifiable(fields);

  /// Stable import identity: derived from the connection/account/institution,
  /// never from a mutable value. See `portal-sync-plan.md`'s
  /// "Define stable import identities" guidance.
  final String sourceId;
  final String accountId;
  final int institutionId;
  final Map<AcademicProfileFieldKey, AcademicProfileFieldValue> fields;
  final DateTime observedAt;

  bool get isValid =>
      sourceId.trim().isNotEmpty &&
      accountId.trim().isNotEmpty &&
      institutionId > 0 &&
      fields.values.any((value) => value.evidence.isValid);

  AcademicProfileEntity copyWith({
    String? sourceId,
    String? accountId,
    int? institutionId,
    Map<AcademicProfileFieldKey, AcademicProfileFieldValue>? fields,
    DateTime? observedAt,
  }) => AcademicProfileEntity(
    sourceId: sourceId ?? this.sourceId,
    accountId: accountId ?? this.accountId,
    institutionId: institutionId ?? this.institutionId,
    fields: fields ?? this.fields,
    observedAt: observedAt ?? this.observedAt,
  );

  /// Merges [incoming] fields into this profile, keeping any field this
  /// profile already has that [incoming] does not report (a partial capture
  /// must never delete a previously observed field) while letting newer
  /// valid observations of the same field replace older ones.
  AcademicProfileEntity mergedWith(AcademicProfileEntity incoming) {
    final merged = Map<AcademicProfileFieldKey, AcademicProfileFieldValue>.of(
      fields,
    );
    for (final entry in incoming.fields.entries) {
      merged[entry.key] = entry.value;
    }
    return copyWith(fields: merged, observedAt: incoming.observedAt);
  }

  Map<String, Object?> toJson() => {
    'sourceId': sourceId,
    'accountId': accountId,
    'institutionId': institutionId,
    'fields': fields.map(
      (key, value) => MapEntry(key.name, value.toJson()),
    ),
    'observedAt': observedAt.toIso8601String(),
  };

  factory AcademicProfileEntity.fromJson(Map<String, Object?> json) {
    final rawFields = (json['fields'] as Map).cast<String, Object?>();
    return AcademicProfileEntity(
      sourceId: json['sourceId'] as String,
      accountId: json['accountId'] as String,
      institutionId: json['institutionId'] as int,
      fields: {
        for (final entry in rawFields.entries)
          AcademicProfileFieldKey.values.firstWhere(
                (key) => key.name == entry.key,
              ):
              AcademicProfileFieldValue.fromJson(
                (entry.value as Map).cast<String, Object?>(),
              ),
      },
      observedAt: DateTime.parse(json['observedAt'] as String),
    );
  }
}
