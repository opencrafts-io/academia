import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';

@freezed
abstract class Report with _$Report {
  const factory Report({
    required int id,
    required String reportType,
    required String reason,
    required String status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Report;
}
