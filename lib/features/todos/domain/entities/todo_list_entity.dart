import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academia/features/features.dart';

part 'todo_list_entity.freezed.dart';

@freezed
abstract class TodoListEntity with _$TodoListEntity {
  const factory TodoListEntity({
    required int localId,
    String? id,
    required String title,
    int? color,
    required bool isDefault,
    required SyncStatus syncStatus,
    required int taskCount,
    DateTime? lastSyncedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    required bool isPendingDeletion,
  }) = _TodoListEntity;
}
