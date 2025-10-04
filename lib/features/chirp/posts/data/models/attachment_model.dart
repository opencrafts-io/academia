import 'package:academia/core/core.dart';
import 'package:academia/features/chirp/posts/data/models/post_model.dart';
import 'package:drift/drift.dart';

@DataClassName('AttachmentEntity')
class AttachmentTable extends Table with TableMixin {
  @JsonKey('post_id')
  TextColumn get postId =>
      text().references(PostTable, #id, onDelete: KeyAction.cascade)();
  @JsonKey('attachment_type')
  TextColumn get attachmentType => text().withLength(max: 10)();
  @JsonKey('file_url')
  TextColumn get file => text()();
  @JsonKey('original_filename')
  TextColumn get name => text()();
  @JsonKey('file_size_mb')
  RealColumn get size => real()();
  @override
  @JsonKey('created_at')
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
