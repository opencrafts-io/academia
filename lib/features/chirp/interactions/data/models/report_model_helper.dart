import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/interactions/domain/entities/report.dart';

extension ReportModelHelper on ReportData {
  Report toEntity() {
    return Report(
      id: id,
      reportType: reportType,
      reason: reason,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReportEntityHelper on Report {
  ReportData toData() {
    return ReportData(
      id: id,
      reportType: reportType,
      reportedUser: null,
      reportedPost: null,
      reportedComment: null,
      reportedCommunity: null,
      reason: reason,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      cachedAt: DateTime.now(),
    );
  }
}
