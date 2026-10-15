// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenData _$TokenDataFromJson(Map<String, dynamic> json) => _TokenData(
  provider: json['verisafe'] as String,
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
  accessExpiresAt: _dateFromJson(json['access_expires_at'] as String?),
  refreshExpiresAt: _dateFromJson(json['refresh_expires_at'] as String?),
);

Map<String, dynamic> _$TokenDataToJson(_TokenData instance) =>
    <String, dynamic>{
      'verisafe': instance.provider,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'access_expires_at': _dateToJson(instance.accessExpiresAt),
      'refresh_expires_at': _dateToJson(instance.refreshExpiresAt),
    };
