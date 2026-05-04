import 'package:academia/database/database.dart';
import 'package:academia/features/todos/data/dtos/todo_list_dto.dart';
import 'package:academia/features/todos/domain/domain.dart';

extension TodoListMapper on TodoList {
  TodoListEntity toDomain() => TodoListEntity(
    title: title,
    localId: localId,
    isDefault: isDefault,
    taskCount: taskCount,
    syncStatus: syncStatus,
    isPendingDeletion: isPendingDeletion,
    id: id,
    color: color,
    createdAt: createdAt,
    updatedAt: updatedAt,
    lastSyncedAt: lastSyncedAt,
  );

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

extension TodoEntityMapper on TodoListEntity {
  TodoList toDataModel({bool isDirty = true}) {
    return TodoList(
      localId: localId,
      id: id,
      title: title,
      color: color,
      isDefault: isDefault,
      syncStatus: syncStatus,
      taskCount: taskCount,
      lastSyncedAt: lastSyncedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isPendingDeletion: isPendingDeletion,
      isDirty: isDirty,
    );
  }
}

extension TodoListDtoMapper on TodoListDto {
  TodoListEntity toEntity({int? localId}) {
    return TodoListEntity(
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
      lastSyncedAt: lastSyncedAt != null
          ? DateTime.tryParse(lastSyncedAt!)
          : null,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
    );
  }

  SyncStatus _parseSyncStatus(String status) {
    return SyncStatus.values.firstWhere(
      (e) => e.name == status.toLowerCase(),
      orElse: () => SyncStatus.pending,
    );
  }
}

extension TodoListEntityToDto on TodoListEntity {
  TodoListDto toDto() {
    return TodoListDto(
      id: id,
      title: title,
      color: color?.toRadixString(16).padLeft(6, '0'),
      isDefault: isDefault,
      syncStatus: syncStatus.name,
      syncStatusDisplay: null,
      taskCount: taskCount,
      lastSyncedAt: lastSyncedAt?.toIso8601String(),
      createdAt: createdAt?.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}

extension TodoListDtoToData on TodoListDto {
  TodoList toDataModel({
    int localId = 0,
    bool isDirty = false,
    bool isPendingDeletion = false,
  }) {
    return TodoList(
      localId: localId,
      id: id,
      title: title,
      color: color != null
          ? int.tryParse(
              color!.replaceFirst('#', '')..padLeft(8, 'F'),
              radix: 16,
            )
          : null,
      isDefault: isDefault,
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == syncStatus.toLowerCase(),
        orElse: () => SyncStatus.synced,
      ),
      taskCount: taskCount,
      lastSyncedAt: lastSyncedAt != null
          ? DateTime.tryParse(lastSyncedAt!)
          : null,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      isPendingDeletion: isPendingDeletion,
      isDirty: isDirty,
    );
  }
}
