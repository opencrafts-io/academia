// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_todo_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedTodoItemDto _$PaginatedTodoItemDtoFromJson(
  Map<String, dynamic> json,
) => _PaginatedTodoItemDto(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => TodoItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedTodoItemDtoToJson(
  _PaginatedTodoItemDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
