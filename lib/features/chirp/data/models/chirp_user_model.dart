import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import '../../../../database/database.dart';
import '../../domain/entities/chirp_user.dart';

@DataClassName('ChirpUserData')
class ChirpUserTable extends Table with TableMixin {
  @override
  @JsonKey("user_id")
  TextColumn get id => text()();
  @JsonKey("username")
  TextColumn get username => text().unique()();
  @JsonKey("name")
  TextColumn get name => text()();
  @JsonKey("email")
  TextColumn get email => text()();
  @JsonKey("vibe_points")
  IntColumn get vibepoints => integer().withDefault(Constant(0))();
  @JsonKey("avatar_url")
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
      username: username,
      createdAt: createdAt,
      updatedAt: updatedAt,
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
      username: username,
    );
  }
}
