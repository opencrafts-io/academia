import 'package:drift/drift.dart';

/// [TableMixin] provides common fields on most tables like
/// id, created_at, updated_at
/// use them instead of rewriting on your own
mixin TableMixin on Table {
  // Id for storing uuid
  TextColumn get id => text()();

  // For storing creation time timestamp
  @JsonKey('created_at')
  DateTimeColumn get createdAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  // For storing time of update timestamp
  @JsonKey('updated_at')
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();
}
