import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import 'package:academia/features/chirp/data/models/chirp_user_model.dart';
import 'message_model.dart';

@DataClassName('ConversationData')
class ConversationTable extends Table with TableMixin {
  TextColumn get userId => text().references(ChirpUserTable, #id)();
  TextColumn get lastMessageId =>
      text().nullable().references(MessageTable, #id)();
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
