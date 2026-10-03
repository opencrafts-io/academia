import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:database/tables/tables.dart';
import 'package:database/daos/daos.dart';

part 'app_database_v2.g.dart';

@DriftDatabase(
  tables: [
    Plans,
    BillingOrders,
    BillingOrderItems,
    BillingSubscriptions,
    BillingSubscriptionStatuses,
    BillingEntitlements,
    LockInRuleRecords,
    LockInAttempts,
    Courses,
    Lecturers,
    ScheduleEntries,
    TodoLists,
    TodoTagItems,
    TodoItems,
    TodoItemTags,
  ],
  daos: [
    PlanDao,
    OrderDao,
    SubscriptionDao,
    EntitlementDao,
    LockInDao,
    CourseDao,
    TodoListDao,
    TodoTagDao,
    TodoItemDao,
  ],
)
class AppDatabaseV2 extends _$AppDatabaseV2 {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabaseV2([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 8;

  static QueryExecutor _openConnection() {
    driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults(
      serializeDateTimeValuesAsString: true,
    );

    return driftDatabase(
      name: 'academia_v2',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            log(
              'Using ${result.chosenImplementation} due to unsupported '
              'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        final stopwatch = Stopwatch()..start();
        try {
          await m.createAll();
          stopwatch.stop();
          log(
            '[✓] Database initialization completed successfully',
            name: 'DatabaseMigration',
            level: 0, // Info level
          );
          log(
            'Execution time: ${stopwatch.elapsedMilliseconds}ms',
            name: 'DatabaseMigration.Performance',
          );
        } catch (e, stackTrace) {
          log(
            '[✗] Database initialization failed',
            name: 'DatabaseMigration.Error',
            level: 1000, // Error level
            error: e,
            stackTrace: stackTrace,
          );
          rethrow;
        }
      },
      beforeOpen: (details) async {
        try {
          log(
            '[→] Opening database connection',
            name: 'DatabaseMigration.Connection',
            level: 0,
          );
          log(
            'Schema version: ${details.versionNow} | Previously: ${details.wasCreated ? "new database" : details.versionBefore}',
            name: 'DatabaseMigration.SchemaInfo',
          );
        } catch (e, stackTrace) {
          log(
            '[✗] Error during beforeOpen phase',
            name: 'DatabaseMigration.BeforeOpen',
            level: 1000,
            error: e,
            stackTrace: stackTrace,
          );
          rethrow;
        }
      },
      onUpgrade: _schemaUpgrade,
    );
  }
}

extension Migrations on GeneratedDatabase {
  OnUpgrade get _schemaUpgrade => (m, from, to) async {
    final db = this as AppDatabaseV2;
    if (from < 2 && to >= 2) {
      await m.createTable(db.plans);
    }
    if (from < 3 && to >= 3) {
      await m.createTable(db.billingOrders);
      await m.createTable(db.billingSubscriptions);
      await m.createTable(db.billingSubscriptionStatuses);
      await m.createTable(db.billingEntitlements);
    }
    if (from < 4 && to >= 4) {
      await m.createTable(db.billingOrderItems);
    }
    if (from < 5 && to >= 5) {
      await m.createTable(db.lockInRuleRecords);
      await m.createTable(db.lockInAttempts);
    }
    if (from < 6 && to >= 6) {
      await db.customStatement('''
        CREATE TABLE courses (
          id TEXT NOT NULL,
          institution_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          code TEXT NULL,
          term_label TEXT NULL,
          academic_year TEXT NULL,
          term_start_date INTEGER NULL,
          term_end_date INTEGER NULL,
          previous_course_id TEXT NULL,
          archived_at INTEGER NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          cached_at INTEGER NOT NULL,
          PRIMARY KEY (id)
        )
      ''');
      await m.createTable(db.lecturers);
    }
    if (from < 7 && to >= 7) {
      await m.createTable(db.todoLists);
      await m.createTable(db.todoTagItems);
      await m.createTable(db.todoItems);
      await m.createTable(db.todoItemTags);
    }
    if (from < 8 && to >= 8) {
      await m.addColumn(db.courses, db.courses.serverId);
      await m.addColumn(db.courses, db.courses.idempotencyKey);
      await m.addColumn(db.courses, db.courses.syncStatus);
      await m.addColumn(db.courses, db.courses.lastSyncError);
      await m.addColumn(db.courses, db.courses.color);
      await db.customStatement(
        "UPDATE courses SET server_id = id WHERE sync_status = 'synced'",
      );
      await m.createTable(db.scheduleEntries);
    }
  };
}
