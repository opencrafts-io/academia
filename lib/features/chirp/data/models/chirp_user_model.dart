import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/chirp_user.dart';
import '../../../../database/database.dart';

@DataClassName('ChirpUserData')
class ChirpUserTable extends Table with TableMixin {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  IntColumn get vibepoints => integer().withDefault(Constant(0))();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

// Convert from database model TO domain entity
extension ChirpUserModelHelper on ChirpUserData {
  ChirpUser toEntity() {
    return ChirpUser(
      id: id,
      name: name,
      email: email,
      vibepoints: vibepoints,
      avatarUrl: avatarUrl,
    );
  }
}

// Convert from domain entity TO database model
extension ChirpUserEntityHelper on ChirpUser {
  ChirpUserData toData() => ChirpUserData(
    id: id,
    name: name,
    email: email,
    vibepoints: vibepoints,
    avatarUrl: avatarUrl,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
