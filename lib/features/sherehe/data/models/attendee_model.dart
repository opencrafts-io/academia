import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/data/models/event_model.dart';
import 'package:drift/drift.dart';

@DataClassName('AttendeeData')
class AttendeeTable extends Table with TableMixin {
  @JsonKey('first_name')
  TextColumn get firstName => text()();
  @JsonKey('middle_name')
  TextColumn get middleName => text().nullable()();
  @JsonKey('last_name')
  TextColumn get lastName => text()();
  @JsonKey('event_id')
  TextColumn get eventId => text().references(EventTable, #id)();
  @JsonKey('email')
  TextColumn get email => text()();
  @override
  Set<Column> get primaryKey => {id};
}
