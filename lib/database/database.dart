import 'package:academia/features/auth/data/models/token.dart';
import 'package:academia/features/profile/data/models/user_profile.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../features/chirp/data/data.dart';

part 'database.g.dart';

@DriftDatabase(tables: [UserProfile, Token, ConversationTable, MessageTable, AttachmentTable, PostTable, PostReplyTable
  ])
class AppDataBase extends _$AppDataBase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDataBase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

  static QueryExecutor _openConnection() {
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
