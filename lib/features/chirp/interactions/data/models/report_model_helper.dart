import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/interactions/data/dtos/report_api_dto.dart';
import 'package:academia/features/chirp/interactions/domain/entities/report.dart';

extension ReportApiDtoMapper on ReportApiDto {
  db.Report toData() => db.Report(
    id: id,
    reportType: reportType,
    reportedUser: reportedUser,
    reportedPost: reportedPost,
    reportedComment: reportedComment,
    reportedCommunity: reportedCommunity,
    reason: reason,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Report toEntity() => toData().toEntity();
}

extension ReportModelHelper on db.Report {
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
  db.Report toData() {
    return db.Report(
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
