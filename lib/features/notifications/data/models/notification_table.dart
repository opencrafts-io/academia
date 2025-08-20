import 'package:academia/core/data/json_converter.dart';
import 'package:drift/drift.dart';

class NotificationTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get data => text().map(const JsonConverter()).nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  TextColumn get category => text().nullable()();
  TextColumn get actionUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

