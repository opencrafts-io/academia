// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_profile_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InstitutionProfileApiDto _$InstitutionProfileApiDtoFromJson(
  Map<String, dynamic> json,
) => _InstitutionProfileApiDto(
  id: (json['id'] as num?)?.toInt(),
  institution: (json['institution'] as num).toInt(),
  userId: json['user_id'] as String,
  studentId: json['student_id'] as String,
  studentName: json['student_name'] as String,
  gender:
      $enumDecodeNullable(
        _$ApiGenderEnumMap,
        json['gender'],
        unknownValue: ApiGender.unknown,
      ) ??
      ApiGender.unknown,
  nationalId: json['national_id'] as String?,
  nationality: json['nationality'] as String?,
  program: json['program'] as String?,
  major: json['major'] as String?,
  year: (json['year'] as num?)?.toInt(),
  gpa: (json['gpa'] as num?)?.toDouble(),
  profilePicture: json['profile_picture'] as String?,
  disabilityStatus: json['disability_status'] as String?,
  school: json['school'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  address: json['address'] as String?,
  status:
      $enumDecodeNullable(
        _$ApiAcademicStatusEnumMap,
        json['status'],
        unknownValue: ApiAcademicStatus.unknown,
      ) ??
      ApiAcademicStatus.unknown,
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

Map<String, dynamic> _$InstitutionProfileApiDtoToJson(
  _InstitutionProfileApiDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'institution': instance.institution,
  'user_id': instance.userId,
  'student_id': instance.studentId,
  'student_name': instance.studentName,
  'gender': _$ApiGenderEnumMap[instance.gender],
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
  'status': _$ApiAcademicStatusEnumMap[instance.status],
  'enrollment_date': instance.enrollmentDate?.toIso8601String(),
  'expected_graduation': instance.expectedGraduation?.toIso8601String(),
  'raw_data': instance.rawData,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$ApiGenderEnumMap = {
  ApiGender.male: 'male',
  ApiGender.female: 'female',
  ApiGender.nonBinary: 'non_binary',
  ApiGender.genderqueer: 'genderqueer',
  ApiGender.genderfluid: 'genderfluid',
  ApiGender.agender: 'agender',
  ApiGender.transgenderMale: 'transgender_male',
  ApiGender.transgenderFemale: 'transgender_female',
  ApiGender.intersex: 'intersex',
  ApiGender.twoSpirit: 'two_spirit',
  ApiGender.preferNotToSay: 'prefer_not_to_say',
  ApiGender.other: 'other',
  ApiGender.unknown: 'unknown',
};

const _$ApiAcademicStatusEnumMap = {
  ApiAcademicStatus.active: 'active',
  ApiAcademicStatus.suspended: 'suspended',
  ApiAcademicStatus.completed: 'completed',
  ApiAcademicStatus.inactive: 'inactive',
  ApiAcademicStatus.unknown: 'unknown',
};
