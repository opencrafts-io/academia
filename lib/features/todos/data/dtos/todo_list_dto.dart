import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_list_dto.freezed.dart';
part 'todo_list_dto.g.dart';

@freezed
abstract class TodoListDto with _$TodoListDto {
  const factory TodoListDto({
    required String id,
    required String title,
    required String? color,
    @JsonKey(name: 'is_default') required bool isDefault,
    @JsonKey(name: 'sync_status') required String syncStatus,
    @JsonKey(name: 'sync_status_display') required String? syncStatusDisplay,
    @JsonKey(name: 'last_synced_at') required String? lastSyncedAt,
    @JsonKey(name: 'task_count') required int taskCount,
    @JsonKey(name: 'created_at') required String? createdAt,
    @JsonKey(name: 'updated_at') required String? updatedAt,
  }) = _TodoListDto;

  factory TodoListDto.fromJson(Map<String, dynamic> json) =>
      _$TodoListDtoFromJson(json);
}
