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
}
