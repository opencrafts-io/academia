// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstitutionProfile _$InstitutionProfileFromJson(Map<String, dynamic> json) =>
    InstitutionProfile(
      institution: (json['institution'] as num).toInt(),
      userID: json['user_id'] as String,
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      id: (json['id'] as num?)?.toInt(),
      gender:
          $enumDecodeNullable(
            _$GenderEnumMap,
            json['gender'],
            unknownValue: Gender.unknown,
          ) ??
          Gender.unknown,
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
      email: json['email'] as String?,
      status:
          $enumDecodeNullable(
            _$AcademicStatusEnumMap,
            json['status'],
            unknownValue: AcademicStatus.unknown,
          ) ??
          AcademicStatus.unknown,
      profilePicture: json['profile_picture'] as String?,
      enrollmentDate: json['enrollment_date'] == null
          ? null
          : DateTime.parse(json['enrollment_date'] as String),
      expectedGraduation: json['expected_graduation'] == null
          ? null
          : DateTime.parse(json['expected_graduation'] as String),
      rawData: json['raw_data'] as Map<String, dynamic>?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InstitutionProfileToJson(InstitutionProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
      'user_id': instance.userID,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'gender': _$GenderEnumMap[instance.gender],
      'national_id': instance.nationalId,
      'nationality': instance.nationality,
      'program': instance.program,
      'major': instance.major,
      'year': instance.year,
      'gpa': instance.gpa,
      'profile_picture': instance.profilePicture,
      'disability_status': instance.disabilityStatus,
      'school': instance.school,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'status': _$AcademicStatusEnumMap[instance.status],
      'enrollment_date': instance.enrollmentDate?.toIso8601String(),
      'expected_graduation': instance.expectedGraduation?.toIso8601String(),
      'raw_data': instance.rawData,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.nonBinary: 'non_binary',
  Gender.genderqueer: 'genderqueer',
  Gender.genderfluid: 'genderfluid',
  Gender.agender: 'agender',
  Gender.transgenderMale: 'transgender_male',
  Gender.transgenderFemale: 'transgender_female',
  Gender.intersex: 'intersex',
  Gender.twoSpirit: 'two_spirit',
  Gender.preferNotToSay: 'prefer_not_to_say',
  Gender.other: 'other',
  Gender.unknown: 'unknown',
};

const _$AcademicStatusEnumMap = {
  AcademicStatus.active: 'active',
  AcademicStatus.suspended: 'suspended',
  AcademicStatus.completed: 'completed',
  AcademicStatus.inactive: 'inactive',
  AcademicStatus.unknown: 'unknown',
};
