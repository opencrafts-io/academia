import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('UserData')
class UserTable extends Table with TableMixin {
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get avatar => text().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
