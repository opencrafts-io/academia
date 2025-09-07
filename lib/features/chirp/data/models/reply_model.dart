import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/post_model.dart';
import 'package:drift/drift.dart';

@DataClassName('PostReplyEntity')
class PostReplyTable extends Table with TableMixin {
  @JsonKey('parent_id')
  TextColumn get parentId => text().nullable().references(
    PostReplyTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
  @JsonKey('post_id')
  TextColumn get postId => text().references(PostTable, #id, onDelete: KeyAction.cascade)();
  @JsonKey('user_id')
  TextColumn get userId => text()();
  @JsonKey('user_name')
  TextColumn get userName => text()();
  @JsonKey('user_avatar')
  TextColumn get userAvatar => text().nullable()();
  TextColumn get content => text()();
  IntColumn get depth => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

}
