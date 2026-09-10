import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/tables.dart';
import 'daos/daos.dart';

part 'app_database_v2.g.dart';

@LazySingleton()
@DriftDatabase(
  tables: [
    Plans,
    BillingOrders,
    BillingOrderItems,
    BillingSubscriptions,
    BillingSubscriptionStatuses,
    BillingEntitlements,
  ],
  daos: [PlanDao, OrderDao, SubscriptionDao, EntitlementDao],
)
class AppDatabaseV2 extends _$AppDatabaseV2 {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabaseV2([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

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
    if (from < 2) {
      await m.createTable(db.plans);
    }
    if (from < 3) {
      await m.createTable(db.billingOrders);
      await m.createTable(db.billingSubscriptions);
      await m.createTable(db.billingSubscriptionStatuses);
      await m.createTable(db.billingEntitlements);
    }
    if (from < 4) {
      await m.createTable(db.billingOrderItems);
    }
  };
}
