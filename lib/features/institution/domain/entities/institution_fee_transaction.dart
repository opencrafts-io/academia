import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_fee_transaction.freezed.dart';

@freezed
abstract class InstitutionFeeTransaction with _$InstitutionFeeTransaction {
  const factory InstitutionFeeTransaction({
    int? id,
    required int institution,
    String? referenceNumber,
    @Default(0.0) double? runningBalance,
    @Default(0.0) double? debit,
    @Default(0.0) double? credit,
    DateTime? postingDate,
    String? description,
    String? title,
    @Default("KES") String? currency,
  }) = _InstitutionFeeTransaction;
}
