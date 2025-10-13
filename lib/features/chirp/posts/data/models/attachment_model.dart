import 'package:drift/drift.dart';

@DataClassName('AttachmentData')
class AttachmentTable extends Table {
  @JsonKey("id")
  IntColumn get id => integer().autoIncrement()();

  @JsonKey('attachment_type')
  TextColumn get attachmentType => text().withLength(max: 20)();

  @JsonKey('file')
  TextColumn get file => text()();

  @JsonKey('file_size')
  IntColumn get size => integer()();

  @JsonKey('original_filename')
  TextColumn get name => text()();

  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();

  @JsonKey('post')
  IntColumn get postId => integer()();
}
