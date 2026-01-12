//this is a temporary solution will work on this
import 'package:drift/drift.dart';

@DataClassName('ShereheUserData')
class ShereheUserTable extends Table {
  TextColumn get id => text()();

  TextColumn get username => text().nullable()();

  TextColumn get email => text()();

  TextColumn get name => text()();

  TextColumn get phone => text().nullable()();
}
