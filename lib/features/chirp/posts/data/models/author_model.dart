import 'package:drift/drift.dart';

@DataClassName('AuthorData')
class AuthorTable extends Table {
  @JsonKey('user_id')
  TextColumn get userId => text()();

  TextColumn get name => text()();

  TextColumn get email => text()();

  TextColumn get phone => text()();

  TextColumn get username => text()();

  @JsonKey('avatar_url')
  TextColumn get avatarUrl => text().nullable()();

  @JsonKey('vibe_points')
  IntColumn get vibePoints => integer().withDefault(const Constant(0))();

  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey('updated_at')
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId};
}
