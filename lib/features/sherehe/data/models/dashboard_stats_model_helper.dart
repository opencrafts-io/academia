import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/domain.dart';

extension DashboardStatsModelHelper on DashboardStatsData {
  DashboardStats toEntity() =>
      DashboardStats(attendees: attendees, scanners: scanners);
}

extension DashboardStatsEntityHelper on DashboardStats {
  DashboardStatsData toModel() =>
      DashboardStatsData(attendees: attendees, scanners: scanners);
}
