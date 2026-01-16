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
}
