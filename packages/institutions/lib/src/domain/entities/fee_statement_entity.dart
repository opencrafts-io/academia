import 'field_evidence.dart';
import 'monetary_amount.dart';

/// Distinguishes the kinds of fee-statement line this app supports, per the
/// portal-sync plan: "distinguish debit, credit, running balance, and
/// balance due." These are never collapsed into a single signed amount --
/// a portal's own labelling decides which kind a row is, never a guess
/// based on sign alone.
enum FeeLineKind { debit, credit, runningBalance, balanceDue }

/// One observed fee-statement row.
class FeeLineItemEntity {
  const FeeLineItemEntity({
    required this.sourceId,
    required this.kind,
    required this.description,
    required this.amount,
    this.rawDate,
    this.normalizedDate,
    required this.evidence,
  });

  /// Stable import identity for this line, derived from the statement's
  /// identity plus row-specific evidence (never from the amount alone,
  /// which can legitimately repeat across rows).
  final String sourceId;
  final FeeLineKind kind;

  /// The portal's own label for the row (e.g. "Tuition fee", "M-Pesa
  /// payment"), preserved as captured.
  final String description;
  final MonetaryAmount amount;

  /// Localized date text as captured; preserved until validated.
  final String? rawDate;
  final DateTime? normalizedDate;
  final FieldEvidence evidence;

  bool get isValid =>
      sourceId.trim().isNotEmpty &&
      description.trim().isNotEmpty &&
      amount.isValid;

  FeeLineItemEntity copyWith({
    String? sourceId,
    FeeLineKind? kind,
    String? description,
    MonetaryAmount? amount,
    String? rawDate,
    DateTime? normalizedDate,
    FieldEvidence? evidence,
  }) => FeeLineItemEntity(
    sourceId: sourceId ?? this.sourceId,
    kind: kind ?? this.kind,
    description: description ?? this.description,
    amount: amount ?? this.amount,
    rawDate: rawDate ?? this.rawDate,
    normalizedDate: normalizedDate ?? this.normalizedDate,
    evidence: evidence ?? this.evidence,
  );

  Map<String, Object?> toJson() => {
    'sourceId': sourceId,
    'kind': kind.name,
    'description': description,
    'amount': amount.toJson(),
    'rawDate': rawDate,
    'normalizedDate': normalizedDate?.toIso8601String(),
    'evidence': evidence.toJson(),
  };

  factory FeeLineItemEntity.fromJson(Map<String, Object?> json) =>
      FeeLineItemEntity(
        sourceId: json['sourceId'] as String,
        kind: FeeLineKind.values.firstWhere(
          (value) => value.name == json['kind'],
        ),
        description: json['description'] as String,
        amount: MonetaryAmount.fromJson(
          (json['amount'] as Map).cast<String, Object?>(),
        ),
        rawDate: json['rawDate'] as String?,
        normalizedDate: json['normalizedDate'] == null
            ? null
            : DateTime.parse(json['normalizedDate'] as String),
        evidence: FieldEvidence.fromJson(
          (json['evidence'] as Map).cast<String, Object?>(),
        ),
      );
}

/// A student's fee statement as observed from a school portal, scoped to one
/// institution membership and (optionally) one term. Currency is carried
/// per line via [FeeLineItemEntity.amount] rather than at the statement
/// level, because a single statement may legitimately mix currencies or
/// contain rows whose currency could not be confirmed.
class FeeStatementEntity {
  FeeStatementEntity({
    required this.sourceId,
    required this.accountId,
    required this.institutionId,
    this.term,
    required List<FeeLineItemEntity> lineItems,
    required this.observedAt,
  }) : lineItems = List.unmodifiable(lineItems);

  final String sourceId;
  final String accountId;
  final int institutionId;
  final String? term;
  final List<FeeLineItemEntity> lineItems;
  final DateTime observedAt;

  bool get isValid =>
      sourceId.trim().isNotEmpty &&
      accountId.trim().isNotEmpty &&
      institutionId > 0 &&
      lineItems.isNotEmpty &&
      lineItems.every((item) => item.isValid) &&
      _uniqueSourceIds;

  bool get _uniqueSourceIds =>
      lineItems.map((item) => item.sourceId).toSet().length ==
      lineItems.length;

  FeeStatementEntity copyWith({
    String? sourceId,
    String? accountId,
    int? institutionId,
    String? term,
    List<FeeLineItemEntity>? lineItems,
    DateTime? observedAt,
  }) => FeeStatementEntity(
    sourceId: sourceId ?? this.sourceId,
    accountId: accountId ?? this.accountId,
    institutionId: institutionId ?? this.institutionId,
    term: term ?? this.term,
    lineItems: lineItems ?? this.lineItems,
    observedAt: observedAt ?? this.observedAt,
  );

  /// Merges newly observed line items into this statement by [sourceId].
  /// Lines absent from a partial [incoming] capture are kept -- absence is
  /// never treated as deletion.
  FeeStatementEntity mergedWith(FeeStatementEntity incoming) {
    final merged = {for (final item in lineItems) item.sourceId: item};
    for (final item in incoming.lineItems) {
      merged[item.sourceId] = item;
    }
    return copyWith(
      lineItems: merged.values.toList(growable: false),
      observedAt: incoming.observedAt,
    );
  }

  Map<String, Object?> toJson() => {
    'sourceId': sourceId,
    'accountId': accountId,
    'institutionId': institutionId,
    'term': term,
    'lineItems': lineItems.map((item) => item.toJson()).toList(),
    'observedAt': observedAt.toIso8601String(),
  };

  factory FeeStatementEntity.fromJson(Map<String, Object?> json) =>
      FeeStatementEntity(
        sourceId: json['sourceId'] as String,
        accountId: json['accountId'] as String,
        institutionId: json['institutionId'] as int,
        term: json['term'] as String?,
        lineItems: (json['lineItems'] as List)
            .map(
              (item) =>
                  FeeLineItemEntity.fromJson((item as Map).cast<String, Object?>()),
            )
            .toList(),
        observedAt: DateTime.parse(json['observedAt'] as String),
      );
}
