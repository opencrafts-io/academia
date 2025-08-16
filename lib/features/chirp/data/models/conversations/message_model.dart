import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import '../chirp_user_model.dart';

@DataClassName('MessageData')
class MessageTable extends Table with TableMixin {
  TextColumn get content => text()();
  TextColumn get senderId => text().references(ChirpUserTable, #id)();
  TextColumn get recipientId => text().references(ChirpUserTable, #id)();
  DateTimeColumn get sentAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(Constant(false))();
  TextColumn get imageUrl => text().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
