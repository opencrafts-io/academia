// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstitutionProfile _$InstitutionProfileFromJson(Map<String, dynamic> json) =>
    InstitutionProfile(
      id: (json['id'] as num).toInt(),
      userID: json['user_id'] as String,
      studentId: json['student_id'] as String,
      nationalId: json['national_id'] as String?,
      nationality: json['nationality'] as String?,
      program: json['program'] as String?,
      major: json['major'] as String?,
      year: (json['year'] as num?)?.toInt(),
      gpa: (json['gpa'] as num?)?.toDouble(),
      disabilityStatus: json['disability_status'] as String?,
      school: json['school'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      enrollmentDate: json['enrollment_date'] == null
          ? null
          : DateTime.parse(json['enrollment_date'] as String),
      expectedGraduation: json['expected_graduation'] == null
          ? null
          : DateTime.parse(json['expected_graduation'] as String),
      rawData: json['raw_data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InstitutionProfileToJson(InstitutionProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userID,
      'student_id': instance.studentId,
      'national_id': instance.nationalId,
      'nationality': instance.nationality,
      'program': instance.program,
      'major': instance.major,
      'year': instance.year,
      'gpa': instance.gpa,
      'disability_status': instance.disabilityStatus,
      'school': instance.school,
      'phone': instance.phone,
      'address': instance.address,
      'enrollment_date': instance.enrollmentDate?.toIso8601String(),
      'expected_graduation': instance.expectedGraduation?.toIso8601String(),
      'raw_data': instance.rawData,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
