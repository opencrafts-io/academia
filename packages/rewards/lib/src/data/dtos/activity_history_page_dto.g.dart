// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityHistoryPageDto _$ActivityHistoryPageDtoFromJson(
  Map<String, dynamic> json,
) => _ActivityHistoryPageDto(
  count: (json['count'] as num?)?.toInt() ?? 0,
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => ActivityHistoryDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ActivityHistoryDto>[],
);

Map<String, dynamic> _$ActivityHistoryPageDtoToJson(
  _ActivityHistoryPageDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};
