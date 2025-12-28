// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrapping_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScrappingResult _$ScrappingResultFromJson(Map<String, dynamic> json) =>
    ScrappingResult(
      commandID: json['command_id'] as String?,
      success: json['success'] as bool,
      data: json['data'] as Map<String, dynamic>,
      executionTime: Duration(
        microseconds: (json['execution_time'] as num).toInt(),
      ),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ScrappingResultToJson(ScrappingResult instance) =>
    <String, dynamic>{
      'command_id': instance.commandID,
      'success': instance.success,
      'data': instance.data,
      'execution_time': instance.executionTime.inMicroseconds,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
