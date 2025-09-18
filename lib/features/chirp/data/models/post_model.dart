import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/groups/group_model.dart';
import 'package:drift/drift.dart';

@DataClassName('PostEntity')
class PostTable extends Table with TableMixin {

  TextColumn get groupId => text().references(GroupTable, #id)();

  @JsonKey('user_id')
  TextColumn get userId => text()();

  @JsonKey('user_name')
  TextColumn get userName => text()();

  TextColumn get email => text()();

  @JsonKey('avatar_url')
  TextColumn get avatarUrl => text().nullable()();

  TextColumn get content => text()();

  @JsonKey('like_count')
  IntColumn get likeCount => integer()();

  @JsonKey('comment_count')
  IntColumn get commentCount => integer()();

  @JsonKey('is_liked')
  BoolColumn get isLiked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>>? get primaryKey => {id};

}
