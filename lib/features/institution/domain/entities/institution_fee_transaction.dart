import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'institution_fee_transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class InstitutionFeeTransaction extends Equatable {
  final int? id;

  @JsonKey(name: 'institution')
  final int institution;

  @JsonKey(name: 'reference_number')
  final String? referenceNumber;

  @JsonKey(name: 'running_balance')
  final double? runningBalance;

  final double? debit;
  final double? credit;

  @JsonKey(name: 'posting_date')
  final DateTime? postingDate;

  final String? description;
  final String? title;
  final String? currency;

  const InstitutionFeeTransaction({
    this.id,
    required this.institution,
    this.referenceNumber,
    this.runningBalance = 0.0,
    this.debit = 0.0,
    this.credit = 0.0,
    this.postingDate,
    this.description,
    this.title,
    this.currency = "KES",
  });

  factory InstitutionFeeTransaction.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFeeTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$InstitutionFeeTransactionToJson(this);

  @override
  List<Object?> get props => [
    id,
    institution,
    referenceNumber,
    runningBalance,
    debit,
    credit,
    postingDate,
    description,
    title,
    currency,
  ];

  InstitutionFeeTransaction copyWith({
    int? id,
    int? institution,
    String? referenceNumber,
    double? runningBalance,
    double? debit,
    double? credit,
    DateTime? postingDate,
    String? description,
    String? title,
    String? currency,
  }) {
    return InstitutionFeeTransaction(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      runningBalance: runningBalance ?? this.runningBalance,
      debit: debit ?? this.debit,
      credit: credit ?? this.credit,
      postingDate: postingDate ?? this.postingDate,
      description: description ?? this.description,
      title: title ?? this.title,
      currency: currency ?? this.currency,
    );
  }
}
