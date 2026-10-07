// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => _AccountDto(
  id: json['id'] as String? ?? '',
  vibePoints: (json['vibe_points'] as num?)?.toInt() ?? 0,
  pointsTotal: (json['points_total'] as num?)?.toInt(),
  points: (json['points'] as num?)?.toInt(),
);

Map<String, dynamic> _$AccountDtoToJson(_AccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vibe_points': instance.vibePoints,
      'points_total': instance.pointsTotal,
      'points': instance.points,
    };
