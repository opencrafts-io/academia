import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/profile/data/models/user_profile.dart';
import 'package:academia/features/todos/data/models/todo.dart';
import 'package:academia/features/chirp/data/models/conversations/conversation_model.dart';
import 'package:academia/features/chirp/data/models/conversations/message_model.dart';
import 'package:academia/features/sherehe/data/data.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:academia/features/chirp/data/models/chirp_user_model.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [UserProfile, Token, ConversationTable, MessageTable, ChirpUserTable, Todo, EventTable, AttendeeTable,TicketTable,],
)

class AppDataBase extends _$AppDataBase {
  final Logger _logger = Logger();
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDataBase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        _logger.i("Migrating from version $from to version $to");
        if (to > from) {
          m.createAll();
          _logger.i("Migrated from version $from to version $to");
        }
      },
      beforeOpen: (details) async {
        _logger.i(
          "Openning cache db version ${details.versionNow} initial version ${details.versionBefore}",
        );
      },
    );
  }

  static QueryExecutor _openConnection() {
    driftRuntimeOptions.defaultSerializer = const ValueSerializer.defaults(
      serializeDateTimeValuesAsString: true,
    );
    return driftDatabase(
      name: 'academia.db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker_dart.js'),
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
