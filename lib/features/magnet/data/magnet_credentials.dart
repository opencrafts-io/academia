import 'package:drift/drift.dart';

class MagnetCredentials extends Table {
  // Verisafe's user id
  @JsonKey("user_id")
  TextColumn get userID => text()();

  // The institution id
  @JsonKey("institution_id")
  IntColumn get institutionID => integer()();

  TextColumn get username => text().named('username')();
  TextColumn get password => text().named('password')();

  /// Store the extra Map`<String, dynamic>` as a JSON string
  TextColumn get extra => text().named('extra').nullable()();

  @override
  Set<Column> get primaryKey => {username, institutionID, userID};
}
