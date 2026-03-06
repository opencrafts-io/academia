import 'package:drift/drift.dart';

@DataClassName('DashboardStatsData')
class DashboardStatsTable extends Table {
  IntColumn get attendees => integer()();

  IntColumn get scanners => integer()();
}
