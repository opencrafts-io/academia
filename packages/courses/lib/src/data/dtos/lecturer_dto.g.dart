// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LecturerDto _$LecturerDtoFromJson(Map<String, dynamic> json) => _LecturerDto(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  office: json['office'] as String?,
);

Map<String, dynamic> _$LecturerDtoToJson(_LecturerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'office': instance.office,
    };
