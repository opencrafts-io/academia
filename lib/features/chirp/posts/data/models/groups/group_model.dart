import 'package:academia/core/data/table_mixin.dart';
import 'package:drift/drift.dart';

@DataClassName('GroupEntity')
class GroupTable extends Table with TableMixin {

  TextColumn get name => text()();
  TextColumn get description => text()();

  @JsonKey('creator_id')
  TextColumn get creatorId => text()();
  @JsonKey('creator_name')
  TextColumn get creatorName => text()();

  TextColumn get admins => text()();
  @JsonKey('admin_names')
  TextColumn get adminNames => text()();

  TextColumn get moderators => text()();
  @JsonKey('moderator_names')
  TextColumn get moderatorNames => text()();

  TextColumn get members => text()();
  @JsonKey('member_names')
  TextColumn get memberNames => text()();

  @JsonKey('banned_users')
  TextColumn get bannedUsers => text()();
  @JsonKey('banned_user_names')
  TextColumn get bannedUserNames => text()();

  @JsonKey('is_private')
  BoolColumn get isPrivate => boolean()();

  TextColumn get rules => text()();

  TextColumn get logo => text().nullable()();
  TextColumn get banner => text().nullable()();
  @JsonKey('logo_url')
  TextColumn get logoUrl => text().nullable()();
  @JsonKey('banner_url')
  TextColumn get bannerUrl => text().nullable()();

  @JsonKey('user_role')
  TextColumn get userRole => text().nullable()();
  @JsonKey('can_post')
  BoolColumn get canPost => boolean()();
  @JsonKey('can_moderate')
  BoolColumn get canModerate => boolean()();
  @JsonKey('can_admin')
  BoolColumn get canAdmin => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

