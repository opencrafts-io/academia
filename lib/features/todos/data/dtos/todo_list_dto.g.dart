// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoListDto _$TodoListDtoFromJson(Map<String, dynamic> json) => _TodoListDto(
  id: json['id'] as String,
  title: json['title'] as String,
  color: json['color'] as String?,
  isDefault: json['is_default'] as bool,
  syncStatus: json['sync_status'] as String,
  syncStatusDisplay: json['sync_status_display'] as String?,
  lastSyncedAt: json['last_synced_at'] as String?,
  taskCount: (json['task_count'] as num).toInt(),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$TodoListDtoToJson(_TodoListDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'is_default': instance.isDefault,
      'sync_status': instance.syncStatus,
      'sync_status_display': instance.syncStatusDisplay,
      'last_synced_at': instance.lastSyncedAt,
      'task_count': instance.taskCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
