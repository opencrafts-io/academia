// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilestonePageDto _$MilestonePageDtoFromJson(Map<String, dynamic> json) =>
    _MilestonePageDto(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => MilestoneDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MilestoneDto>[],
    );

Map<String, dynamic> _$MilestonePageDtoToJson(_MilestonePageDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
