// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_fee_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstitutionFeeTransaction _$InstitutionFeeTransactionFromJson(
  Map<String, dynamic> json,
) => InstitutionFeeTransaction(
  id: (json['id'] as num?)?.toInt(),
  institution: (json['institution'] as num).toInt(),
  referenceNumber: json['reference_number'] as String?,
  runningBalance: (json['running_balance'] as num?)?.toDouble() ?? 0.0,
  debit: (json['debit'] as num?)?.toDouble() ?? 0.0,
  credit: (json['credit'] as num?)?.toDouble() ?? 0.0,
  postingDate: json['posting_date'] == null
      ? null
      : DateTime.parse(json['posting_date'] as String),
  description: json['description'] as String?,
  title: json['title'] as String?,
  currency: json['currency'] as String? ?? "KES",
);

Map<String, dynamic> _$InstitutionFeeTransactionToJson(
  InstitutionFeeTransaction instance,
) => <String, dynamic>{
  'id': instance.id,
  'institution': instance.institution,
  'reference_number': instance.referenceNumber,
  'running_balance': instance.runningBalance,
  'debit': instance.debit,
  'credit': instance.credit,
  'posting_date': instance.postingDate?.toIso8601String(),
  'description': instance.description,
  'title': instance.title,
  'currency': instance.currency,
};
