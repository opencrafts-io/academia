import 'package:academia/database/database.dart';
import 'package:academia/features/todos/data/dtos/todo_tag_dto.dart';
import 'package:academia/features/todos/domain/domain.dart';

extension TodoTagDataMapper on TodoTagItem {
  TodoTagEntity toDomain() => TodoTagEntity(
    localId: localId,
    id: id,
    name: name,
    color: color,
    syncStatus: syncStatus,
    createdAt: createdAt,
    isPendingDeletion: isPendingDeletion,
    isDirty: isDirty,
  );

  TodoTagDto toDto() => TodoTagDto(
    id: id,
    name: name,
    color: color,
    createdAt: createdAt?.toIso8601String(),
  );
}

extension TodoTagEntityMapper on TodoTagEntity {
  TodoTagItem toDataModel({bool isDirty = true}) => TodoTagItem(
    localId: localId,
    id: id,
    name: name,
    color: color,
    syncStatus: syncStatus,
    createdAt: createdAt,
    isPendingDeletion: isPendingDeletion,
    isDirty: isDirty,
  );
}

extension TodoTagDtoMapper on TodoTagDto {
  TodoTagEntity toEntity({int localId = 0}) => TodoTagEntity(
    localId: localId,
    id: id,
    name: name,
    color: color,
    syncStatus: SyncStatus.synced,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    isPendingDeletion: false,
    isDirty: false,
  );

  TodoTagItem toDataModel({
    int localId = 0,
    bool isDirty = false,
    bool isPendingDeletion = false,
  }) => TodoTagItem(
    localId: localId,
    id: id,
    name: name,
    color: color,
    syncStatus: SyncStatus.synced,
    createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
    isPendingDeletion: isPendingDeletion,
    isDirty: isDirty,
  );
}

extension TodoTagEntityToDto on TodoTagEntity {
  TodoTagDto toDto() => TodoTagDto(
    id: id,
    name: name,
    color: color,
    createdAt: createdAt?.toIso8601String(),
  );
}
