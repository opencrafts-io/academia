import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';

@DataClassName('PostEntity')
class PostTable extends Table with TableMixin {
  @JsonKey('user_id')
  TextColumn get userId => text()();

  TextColumn get content => text()();

  @JsonKey('like_count')
  IntColumn get likeCount => integer()();

  @JsonKey('is_liked')
  BoolColumn get isLiked => boolean()();

  @override
  Set<Column<Object>>? get primaryKey => {id};

}
