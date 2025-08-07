import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import '../../../../database/database.dart';
import '../../domain/entities/chirp_user.dart';

@DataClassName('ChirpUserData')
class ChirpUserTable extends Table with TableMixin {
  @override
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  IntColumn get vibepoints => integer().withDefault(Constant(0))();
  TextColumn get avatarUrl => text().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

extension ChirpUserDataHelper on ChirpUserData {
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

extension ChirpUserEntityHelper on ChirpUser {
  ChirpUserData toData() {
    return ChirpUserData(
      id: id,
      name: name,
      email: email,
      vibepoints: vibepoints,
      avatarUrl: avatarUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
