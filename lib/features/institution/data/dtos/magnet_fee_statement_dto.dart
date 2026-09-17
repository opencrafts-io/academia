import 'package:academia/features/institution/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'magnet_fee_statement_dto.freezed.dart';
part 'magnet_fee_statement_dto.g.dart';

double? _parseCommaDouble(dynamic value) {
  if (value == null) return null;
  return double.tryParse(value.toString().replaceAll(',', ''));
}

int _parseInstitutionId(dynamic value) => int.tryParse(value.toString()) ?? 0;

/// Mirrors a single entry of the raw `fees_fees_statements` array returned
/// by a Magnet scrape.
@freezed
abstract class MagnetFeeStatementDto with _$MagnetFeeStatementDto {
  const factory MagnetFeeStatementDto({
    String? title,
    @JsonKey(fromJson: _parseInstitutionId) required int institution,
    @JsonKey(name: 'reference_number') String? referenceNumber,
    @JsonKey(name: 'balance', fromJson: _parseCommaDouble)
    double? runningBalance,
    @JsonKey(fromJson: _parseCommaDouble) double? debit,
    @JsonKey(fromJson: _parseCommaDouble) double? credit,
    @JsonKey(name: 'posting_date') String? postingDateRaw,
    String? date,
    String? description,
    String? currency,
  }) = _MagnetFeeStatementDto;

  factory MagnetFeeStatementDto.fromJson(Map<String, dynamic> json) =>
      _$MagnetFeeStatementDtoFromJson(json);
}

extension MagnetFeeStatementDtoMapper on MagnetFeeStatementDto {
  InstitutionFeeTransaction toEntity() => InstitutionFeeTransaction(
    title: title,
    institution: institution,
    referenceNumber: referenceNumber,
    runningBalance: runningBalance,
    debit: debit,
    credit: credit,
    postingDate:
        DateTime.tryParse(postingDateRaw ?? date ?? '') ?? DateTime.now(),
    description: description,
    currency: currency,
  );
}

/// Parses the raw `fees_fees_statements` array from a Magnet scrape result.
List<InstitutionFeeTransaction> parseFeeTransactionsFromScrape(
  Map<String, dynamic> data,
) {
  final List<dynamic> rawList = data['fees_fees_statements'] ?? [];
  return rawList
      .map(
        (json) =>
            MagnetFeeStatementDto.fromJson(Map<String, dynamic>.from(json)),
      )
      .map((dto) => dto.toEntity())
      .toList();
}
