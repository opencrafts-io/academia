import 'package:drift/drift.dart';

@DataClassName('TokenData')
class Token extends Table {
  IntColumn get id => integer().autoIncrement()();

  @JsonKey("access_token")
  TextColumn get accessToken => text()();

  @JsonKey("refresh_token")
  TextColumn get refreshToken => text()();

  @JsonKey("provider")
  TextColumn get provider => text().unique()();

  @JsonKey("expires_at")
  DateTimeColumn get expiresAt => dateTime().nullable()();

  @JsonKey('created_at')
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  // For storing time of update timestamp
  @JsonKey('updated_at')
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
