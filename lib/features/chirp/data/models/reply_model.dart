import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/data/models/post_model.dart';
import 'package:drift/drift.dart';

@DataClassName('PostReplyEntity')
class PostReplyTable extends Table with TableMixin {
  @JsonKey('post_id')
  TextColumn get postId => text().references(PostTable, #id, onDelete: KeyAction.cascade)();
  @JsonKey('user_id')
  TextColumn get userId => text()();
  TextColumn get content => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
