// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_todo_tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedTodoTagDto _$PaginatedTodoTagDtoFromJson(Map<String, dynamic> json) =>
    _PaginatedTodoTagDto(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => TodoTagDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedTodoTagDtoToJson(
  _PaginatedTodoTagDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
