import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('PostData')
class PostTable extends Table {
  @JsonKey("id")
  IntColumn get id => integer().autoIncrement()();

  TextColumn get community => text().map(JsonConverter())();

  @JsonKey("author_id")
  TextColumn get authorId => text()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  IntColumn get upvotes => integer().withDefault(const Constant(0))();

  IntColumn get downvotes => integer().withDefault(const Constant(0))();

  TextColumn get attachments => text().map(JsonListConverter())();

  @JsonKey("views_count")
  IntColumn get viewsCount => integer().withDefault(const Constant(0))();

  @JsonKey("comment_count")
  IntColumn get commentCount => integer().withDefault(const Constant(0))();

  TextColumn get comments => text().map(JsonListConverter())();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey("updated_at")
  DateTimeColumn get updatedAt => dateTime()();

  /// For internal trackog of when the post was lastly cached on the 
  // local device
  @JsonKey("cached_at")
  DateTimeColumn get cachedAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
}
