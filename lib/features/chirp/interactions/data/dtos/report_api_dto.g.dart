// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportApiDto _$ReportApiDtoFromJson(Map<String, dynamic> json) =>
    _ReportApiDto(
      id: (json['id'] as num).toInt(),
      reportType: json['report_type'] as String,
      reportedUser: json['reported_user'] as String?,
      reportedPost: (json['reported_post'] as num?)?.toInt(),
      reportedComment: (json['reported_comment'] as num?)?.toInt(),
      reportedCommunity: (json['reported_community'] as num?)?.toInt(),
      reason: json['reason'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReportApiDtoToJson(_ReportApiDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'report_type': instance.reportType,
      'reported_user': instance.reportedUser,
      'reported_post': instance.reportedPost,
      'reported_comment': instance.reportedComment,
      'reported_community': instance.reportedCommunity,
      'reason': instance.reason,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
