import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('TodoData')
class Todo extends Table {
  @DateTimeConverter()
  DateTimeColumn get completed => dateTime().nullable()();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();
  DateTimeColumn get due => dateTime().nullable()();
  TextColumn get etag => text()();
  BoolColumn get hidden => boolean().withDefault(Constant(false))();
  TextColumn get id => text()();
  TextColumn get kind => text()();
  TextColumn get notes => text().nullable()();
  @JsonKey("owner_id")
  TextColumn get owner => text()();
  TextColumn get parent => text().nullable()();
  TextColumn get position => text()();
  @JsonKey("self_link")
  TextColumn get selfLink => text()();
  TextColumn get status => text()();
  TextColumn get title => text()();
  DateTimeColumn get updated => dateTime().nullable()();
  @JsonKey("web_view_link")
  TextColumn get webViewLink => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
