import 'package:todos/src/domain/entities/todo_list_entity.dart';
import 'package:todos/src/domain/enums/sync_status.dart';
import 'package:todos/src/data/dtos/todo_list_dto.dart';

extension TodoListEntityMapper on TodoListEntity {
  TodoListEntity toDomain() => this;

  TodoListEntity toDataModel({bool isDirty = true}) =>
      copyWith(isDirty: isDirty);

  TodoListDto toDto() {
    final dtoColor = color == null
        ? null
        : "#${color!.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}";
    return TodoListDto(
      id: id,
      title: title,
      color: dtoColor,
      isDefault: isDefault,
      syncStatus: syncStatus.name,
      syncStatusDisplay: null,
      lastSyncedAt: lastSyncedAt?.toIso8601String(),
      taskCount: taskCount,
      createdAt: createdAt?.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}

extension TodoListDtoMapper on TodoListDto {
  TodoListEntity toEntity({int? localId}) => TodoListEntity(
    localId: localId ?? 0,
    id: id,
    title: title,
    color: color != null
        ? int.tryParse(color!.replaceFirst('#', ''), radix: 16)
        : null,
    isDefault: isDefault,
    taskCount: taskCount,
    syncStatus: _parseSyncStatus(syncStatus),
    isPendingDeletion: false,
    isDirty: false,
    lastSyncedAt: lastSyncedAt != null
        ? DateTime.tryParse(lastSyncedAt!)
        : null,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
  );

  TodoListEntity toDataModel({
    int localId = 0,
    bool isDirty = false,
    bool isPendingDeletion = false,
  }) =>
      toEntity(localId: localId)
          .copyWith(isDirty: isDirty, isPendingDeletion: isPendingDeletion);

  SyncStatus _parseSyncStatus(String status) => SyncStatus.values.firstWhere(
    (value) => value.name == status.toLowerCase(),
    orElse: () => SyncStatus.pending,
  );
}
