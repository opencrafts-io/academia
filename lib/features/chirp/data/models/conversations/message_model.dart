import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import 'user_model.dart';

@DataClassName('MessageData')
class MessageTable extends Table with TableMixin {
  TextColumn get content => text()();
  TextColumn get senderId => text().references(UserTable, #id)();
  TextColumn get recipientId => text().references(UserTable, #id)();
  DateTimeColumn get sentAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(Constant(false))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
