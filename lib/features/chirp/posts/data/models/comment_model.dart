import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('CommentData')
class CommentTable extends Table {
  @JsonKey('id')
  IntColumn get id => integer()();

  IntColumn get post => integer()();

  @JsonKey('author_id')
  TextColumn get authorId => text()();

  TextColumn get content => text()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();

  IntColumn get upvotes => integer().withDefault(const Constant(0))();

  IntColumn get downvotes => integer().withDefault(const Constant(0))();

  TextColumn get replies => text().map(JsonListConverter())();

  IntColumn get parent => integer().nullable()();
}
