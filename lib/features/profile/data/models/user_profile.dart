import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('UserProfileData')
class UserProfile extends Table with TableMixin {
  @DateTimeConverter()
  TextColumn get name => text()();
  TextColumn get username => text().nullable()();
  TextColumn get email => text()();
  @JsonKey('terms_accepted')
  BoolColumn get termsAccepted => boolean().withDefault(Constant(false))();
  @JsonKey('onboarded')
  BoolColumn get onboarded => boolean().withDefault(Constant(false))();
  @JsonKey("national_id")
  TextColumn get nationalID => text().nullable()();
  @JsonKey("avatar_url")
  TextColumn get avatarUrl => text().nullable()();
  @JsonKey("bio")
  TextColumn get bio => text().nullable()();
  @JsonKey("phone")
  TextColumn get phone => text().nullable()();
  @JsonKey("vibe_points")
  IntColumn get vibePoints => integer().withDefault(Constant(0))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
