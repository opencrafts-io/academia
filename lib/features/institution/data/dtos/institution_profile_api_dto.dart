import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_profile_api_dto.freezed.dart';
part 'institution_profile_api_dto.g.dart';

enum ApiGender {
  @JsonValue('male')
  male,

  @JsonValue('female')
  female,

  @JsonValue('non_binary')
  nonBinary,

  @JsonValue('genderqueer')
  genderqueer,

  @JsonValue('genderfluid')
  genderfluid,

  @JsonValue('agender')
  agender,

  @JsonValue('transgender_male')
  transgenderMale,

  @JsonValue('transgender_female')
  transgenderFemale,

  @JsonValue('intersex')
  intersex,

  @JsonValue('two_spirit')
  twoSpirit,

  @JsonValue('prefer_not_to_say')
  preferNotToSay,

  @JsonValue('other')
  other,

  @JsonValue('unknown')
  unknown,
}

enum ApiAcademicStatus {
  @JsonValue('active')
  active,

  @JsonValue('suspended')
  suspended,

  @JsonValue('completed')
  completed,

  @JsonValue('inactive')
  inactive,

  @JsonValue('unknown')
  unknown,
}

@freezed
abstract class InstitutionProfileApiDto with _$InstitutionProfileApiDto {
  const factory InstitutionProfileApiDto({
    int? id,
    required int institution,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'student_id') required String studentId,
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(
      unknownEnumValue: ApiGender.unknown,
      defaultValue: ApiGender.unknown,
    )
    ApiGender? gender,
    @JsonKey(name: 'national_id') String? nationalId,
    String? nationality,
    String? program,
    String? major,
    int? year,
    double? gpa,
    @JsonKey(name: 'profile_picture') String? profilePicture,
    @JsonKey(name: 'disability_status') String? disabilityStatus,
    String? school,
    String? phone,
    String? email,
    String? address,
    @JsonKey(
      unknownEnumValue: ApiAcademicStatus.unknown,
      defaultValue: ApiAcademicStatus.unknown,
    )
    ApiAcademicStatus? status,
    @JsonKey(name: 'enrollment_date') DateTime? enrollmentDate,
    @JsonKey(name: 'expected_graduation') DateTime? expectedGraduation,
    @JsonKey(name: 'raw_data') Map<String, dynamic>? rawData,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _InstitutionProfileApiDto;

  factory InstitutionProfileApiDto.fromJson(Map<String, dynamic> json) =>
      _$InstitutionProfileApiDtoFromJson(json);
}
