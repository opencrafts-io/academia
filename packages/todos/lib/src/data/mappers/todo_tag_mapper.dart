import 'package:todos/src/domain/entities/todo_tag_entity.dart';
import 'package:todos/src/domain/enums/sync_status.dart';
import 'package:todos/src/data/dtos/todo_tag_dto.dart';

extension TodoTagEntityMapper on TodoTagEntity {
  TodoTagEntity toDomain() => this;

  TodoTagEntity toDataModel({bool isDirty = true}) =>
      copyWith(isDirty: isDirty);

  TodoTagDto toDto() => TodoTagDto(
    id: id,
    name: name,
    color: color,
    createdAt: createdAt?.toIso8601String(),
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

  TodoTagEntity toDataModel({
    int localId = 0,
    bool isDirty = false,
    bool isPendingDeletion = false,
  }) =>
      toEntity(localId: localId)
          .copyWith(isDirty: isDirty, isPendingDeletion: isPendingDeletion);
}
