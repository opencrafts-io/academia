// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InstitutionApiDto _$InstitutionApiDtoFromJson(Map<String, dynamic> json) =>
    _InstitutionApiDto(
      institutionId: (json['institution_id'] as num).toInt(),
      name: json['name'] as String,
      webPages: (json['web_pages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      domains: (json['domains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      alphaTwoCode: json['alpha_two_code'] as String?,
      country: json['country'] as String?,
      stateProvince: json['state_province'] as String?,
    );

Map<String, dynamic> _$InstitutionApiDtoToJson(_InstitutionApiDto instance) =>
    <String, dynamic>{
      'institution_id': instance.institutionId,
      'name': instance.name,
      'web_pages': instance.webPages,
      'domains': instance.domains,
      'alpha_two_code': instance.alphaTwoCode,
      'country': instance.country,
      'state_province': instance.stateProvince,
    };
