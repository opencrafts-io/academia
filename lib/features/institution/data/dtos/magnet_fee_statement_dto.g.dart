// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magnet_fee_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MagnetFeeStatementDto _$MagnetFeeStatementDtoFromJson(
  Map<String, dynamic> json,
) => _MagnetFeeStatementDto(
  title: json['title'] as String?,
  institution: _parseInstitutionId(json['institution']),
  referenceNumber: json['reference_number'] as String?,
  runningBalance: _parseCommaDouble(json['balance']),
  debit: _parseCommaDouble(json['debit']),
  credit: _parseCommaDouble(json['credit']),
  postingDateRaw: json['posting_date'] as String?,
  date: json['date'] as String?,
  description: json['description'] as String?,
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$MagnetFeeStatementDtoToJson(
  _MagnetFeeStatementDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'institution': instance.institution,
  'reference_number': instance.referenceNumber,
  'balance': instance.runningBalance,
  'debit': instance.debit,
  'credit': instance.credit,
  'posting_date': instance.postingDateRaw,
  'date': instance.date,
  'description': instance.description,
  'currency': instance.currency,
};
