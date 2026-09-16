import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academia/features/features.dart';
part 'todo_tag_entity.freezed.dart';

@freezed
abstract class TodoTagEntity with _$TodoTagEntity {
  const factory TodoTagEntity({
    required int localId,
    String? id,
    required String name,
    String? color,
    required SyncStatus syncStatus,
    DateTime? createdAt,
    required bool isPendingDeletion,
    required bool isDirty,
  }) = _TodoTagEntity;
}
