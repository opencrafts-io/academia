// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoItemDto _$TodoItemDtoFromJson(Map<String, dynamic> json) => _TodoItemDto(
  id: json['id'] as String?,
  taskList: json['task_list'] as String?,
  title: json['title'] as String,
  notes: json['notes'] as String?,
  status: json['status'] as String?,
  statusDisplay: json['status_display'] as String?,
  priority: json['priority'] as String?,
  priorityDisplay: json['priority_display'] as String?,
  due: json['due'] as String?,
  completed: json['completed'] as String?,
  subtaskCount: (json['subtask_count'] as num).toInt(),
  position: json['position'] as String?,
  hidden: json['hidden'] as bool,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  syncStatus: json['sync_status'] as String?,
  syncStatusDisplay: json['sync_status_display'] as String?,
  lastSyncedAt: json['last_synced_at'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$TodoItemDtoToJson(_TodoItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_list': instance.taskList,
      'title': instance.title,
      'notes': instance.notes,
      'status': instance.status,
      'status_display': instance.statusDisplay,
      'priority': instance.priority,
      'priority_display': instance.priorityDisplay,
      'due': instance.due,
      'completed': instance.completed,
      'subtask_count': instance.subtaskCount,
      'position': instance.position,
      'hidden': instance.hidden,
      'tags': instance.tags,
      'sync_status': instance.syncStatus,
      'sync_status_display': instance.syncStatusDisplay,
      'last_synced_at': instance.lastSyncedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
