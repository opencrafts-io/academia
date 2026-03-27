import 'package:drift/drift.dart';
import 'database.dart';

extension AppDatabaseExtension on AppDataBase {
  Future<void> migrate14To15(Migrator m) async {
    await m.createTable(examTimetable);
  }

  Future<void> migrate15To16(Migrator m) async {
    await m.createTable(institutionScrappingCommand);
  }

  Future<void> migrate16To17(Migrator m) async {
    await m.createTable(institutionKey);
  }

  Future<void> migrate17To18(Migrator m) async {
    await m.createTable(institutionProfile);
  }

  Future<void> migrate18To19(Migrator m) async {
    m.drop(institutionProfile);
    m.create(institutionProfile);
  }

  Future<void> migrate19To20(Migrator m) async {
    m.drop(institutionProfile);
    m.create(institutionProfile);
  }

  Future<void> migrate20To21(Migrator m) async {
    await m.createTable(institutionFeeTransaction);
  }

  Future<void> migrate21To22(Migrator m) async {
    // await m.createTable(institutionCourseTimetableEntry);
    // skip creation of institutionCourseTimetableEntry it'll
    // be deleted in migration 24
  }

  Future<void> migrate22To23(Migrator m) async {
    await m.createTable(semester);
  }

  Future<void> migrate23To24(Migrator m) async {
    await m.deleteTable('institution_course_timetable_entry');
    await m.createTable(course);
    await m.createTable(timetable);
    await m.createTable(timetableEntry);
  }

  Future<void> migrate24To25(Migrator m) async {
    // Delete all existing sherehe tables to start from a fresh start
    await m.database.customStatement("DROP TABLE IF EXISTS 'attendee_table';");
    await m.database.customStatement("DROP TABLE IF EXISTS 'event_table';");
    await m.database.customStatement(
      "DROP TABLE IF EXISTS 'payment_info_table';",
    );
    await m.database.customStatement(
      "DROP TABLE IF EXISTS 'sherehe_user_table';",
    );
    await m.database.customStatement("DROP TABLE IF EXISTS 'ticket_table';");

    // Recreate all previously deleted tables
    await m.createTable(attendeeTable);
    await m.createTable(eventTable);
    await m.createTable(paymentInfoTable);
    await m.createTable(shereheUserTable);
    await m.createTable(ticketTable);

    // Add all the missing sherehe tables
    await m.createTable(dashboardStatsTable);
    await m.createTable(ticketStatsTable);
    await m.createTable(scannerTable);
  }

  Future<void> migrate25To26(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'token';");
  }
}
