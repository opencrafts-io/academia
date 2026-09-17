// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_todo_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedTodoListDto _$PaginatedTodoListDtoFromJson(
  Map<String, dynamic> json,
) => _PaginatedTodoListDto(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => TodoListDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedTodoListDtoToJson(
  _PaginatedTodoListDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
