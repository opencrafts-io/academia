import 'package:drift/drift.dart';

import 'database.dart';

extension AppDatabaseExtension on AppDataBase {
  Future<void> migrate14To15(Migrator m) async {
    await m.createTable(examTimetables);
  }

  Future<void> migrate15To16(Migrator m) async {
    await m.createTable(institutionScrappingCommands);
  }

  Future<void> migrate16To17(Migrator m) async {
    await m.createTable(institutionKeys);
  }

  Future<void> migrate17To18(Migrator m) async {
    await m.createTable(institutionProfiles);
  }

  Future<void> migrate18To19(Migrator m) async {
    m.drop(institutionProfiles);
    m.create(institutionProfiles);
  }

  Future<void> migrate19To20(Migrator m) async {
    m.drop(institutionProfiles);
    m.create(institutionProfiles);
  }

  Future<void> migrate20To21(Migrator m) async {
    await m.createTable(institutionFeeTransactions);
  }

  Future<void> migrate21To22(Migrator m) async {
    // await m.createTable(institutionCourseTimetableEntry);
    // skip creation of institutionCourseTimetableEntry it'll
    // be deleted in migration 24
  }

  Future<void> migrate22To23(Migrator m) async {
    await m.database.customStatement('''
      CREATE TABLE IF NOT EXISTS "semester" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "description" TEXT,
        "institution_id" INTEGER REFERENCES "institution" ("institution_id"),
        "start_date" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "end_date" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');
  }

  Future<void> migrate23To24(Migrator m) async {
    await m.database.customStatement(
      "DROP TABLE IF EXISTS 'institution_course_timetable_entry';",
    );
    await _createRetiredCourseTables(m);
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

  Future<void> migrate26To27(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'event_table';");
    await m.database.customStatement("DROP TABLE IF EXISTS 'ticket_table';");
    await m.createTable(eventTable);
    await m.createTable(ticketTable);
  }

  Future<void> migrate27To28(Migrator m) async {
    //messed this one up, so run the next migration
    // await m.addColumn(eventTable, eventTable.institutions);
  }

  Future<void> migrate28To29(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'event_table';");
    await m.createTable(eventTable);
  }

  Future<void> migrate29To30(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'ticket_table';");
    await m.createTable(ticketTable);
  }

  Future<void> migrate30To31(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'todo';");
  }

  Future<void> migrate31To32(Migrator m) async {
    // Todos now use AppDatabaseV2. Existing v1 todo tables are left in place
    // for older installations but are no longer part of this database API.
  }

  Future<void> migrate32To33(Migrator m) async {
    // Todo schema creation is handled by the shared database package.
  }

  Future<void> migrate33To34(Migrator m) async {
    await m.database.customStatement("DROP TABLE IF EXISTS 'invite_table';");
    await m.database.customStatement("DROP TABLE IF EXISTS 'ticket_table';");
    await m.database.customStatement(
      "DROP TABLE IF EXISTS 'ticket_stats_table';",
    );
    await m.createTable(inviteTable);
    await m.createTable(ticketTable);
    await m.createTable(ticketStatsTable);
  }

  Future<void> migrate34To35(Migrator m) async {
    await m.database.customStatement(
      "DROP TABLE IF EXISTS 'notification_table';",
    );
  }

  Future<void> migrate35To36(Migrator m) async {
    // Schema changed: added institutionId to the primary key so cached exams
    // from different institutions sharing a course code no longer collide.
    // Course codes aren't globally unique, so old rows can't be reliably
    // reattributed to an institution; the cache clears and repopulates from
    // the next fetch/auto-import instead.
    await m.database.customStatement("DROP TABLE IF EXISTS 'exam_timetable';");
    await m.createTable(examTimetables);
  }

  Future<void> migrate36To37(Migrator m) async {
    // GroupTable ('group_table') backed an orphaned Groups subsystem with
    // zero repository/usecase/DI/UI wiring anywhere in the app - dead schema,
    // safe to drop outright.
    await m.deleteTable('group_table');
  }

  Future<void> migrate37To38(Migrator m) async {
    // Focus tracking is stored in the shared database package.
  }

  Future<void> migrate38To39(Migrator m) async {
    // The app no longer maps these tables. Keep existing rows on upgraded
    // installs in case a later migration needs to recover them.
  }

  Future<void> migrate39To40(Migrator m) async {
    await m.addColumn(posts, posts.poll);
  }

  Future<void> migrate40To41(Migrator m) async {
    // Remove retired course tables first because they referenced semester.
    for (final table in [
      'timetable_entry',
      'course',
      'timetable',
      'streak_milestone',
      'streak_activity',
      'leaderboard_rank',
      'semester',
    ]) {
      await m.database.customStatement('DROP TABLE IF EXISTS "$table";');
    }
  }

  Future<void> _createRetiredCourseTables(Migrator m) async {
    // Keep the v23-to-v24 transition valid without restoring the retired Dart
    // models to the current database API.
    await m.database.customStatement('''
      CREATE TABLE IF NOT EXISTS "course" (
        "id" TEXT NOT NULL PRIMARY KEY,
        "server_id" INTEGER UNIQUE,
        "institution" INTEGER REFERENCES "institution" ("institution_id"),
        "semester" INTEGER REFERENCES "semester" ("id"),
        "course_code" TEXT NOT NULL,
        "course_name" TEXT NOT NULL,
        "instructor" TEXT NOT NULL,
        "color" INTEGER DEFAULT 505294591,
        "is_synced" INTEGER NOT NULL DEFAULT 0 CHECK ("is_synced" IN (0, 1)),
        "is_deleted" INTEGER NOT NULL DEFAULT 0 CHECK ("is_deleted" IN (0, 1)),
        "created_at" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    await m.database.customStatement('''
      CREATE TABLE IF NOT EXISTS "timetable" (
        "id" TEXT NOT NULL PRIMARY KEY,
        "server_id" INTEGER UNIQUE,
        "name" TEXT NOT NULL,
        "user_id" TEXT NOT NULL,
        "institution" INTEGER REFERENCES "institution" ("institution_id"),
        "is_synced" INTEGER NOT NULL DEFAULT 0 CHECK ("is_synced" IN (0, 1)),
        "is_deleted" INTEGER NOT NULL DEFAULT 0 CHECK ("is_deleted" IN (0, 1)),
        "created_at" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,
        "updated_at" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');
    await m.database.customStatement('''
      CREATE TABLE IF NOT EXISTS "timetable_entry" (
        "id" TEXT NOT NULL PRIMARY KEY,
        "server_id" INTEGER UNIQUE,
        "user_id" TEXT NOT NULL,
        "institution_id" INTEGER NOT NULL,
        "course_id" TEXT NOT NULL REFERENCES "course" ("id"),
        "timetable_id" TEXT NOT NULL REFERENCES "timetable" ("id"),
        "rrule" TEXT,
        "start_date" INTEGER NOT NULL,
        "duration_minutes" INTEGER NOT NULL,
        "location" TEXT,
        "room" TEXT,
        "building" TEXT,
        "is_synced" INTEGER NOT NULL DEFAULT 0 CHECK ("is_synced" IN (0, 1)),
        "is_deleted" INTEGER NOT NULL DEFAULT 0 CHECK ("is_deleted" IN (0, 1)),
        "last_updated" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');
  }
}
