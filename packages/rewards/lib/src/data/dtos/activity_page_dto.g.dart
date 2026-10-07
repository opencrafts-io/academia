// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityPageDto _$ActivityPageDtoFromJson(Map<String, dynamic> json) =>
    _ActivityPageDto(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => ActivityDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ActivityDto>[],
    );

Map<String, dynamic> _$ActivityPageDtoToJson(_ActivityPageDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
