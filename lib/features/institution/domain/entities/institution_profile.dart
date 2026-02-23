import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'institution_profile.g.dart';

enum Gender {
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

enum AcademicStatus {
  @JsonValue("active")
  active,

  @JsonValue("suspended")
  suspended,

  @JsonValue("completed")
  completed,

  @JsonValue("inactive")
  inactive,

  @JsonValue("unknown")
  unknown,
}

@JsonSerializable()
class InstitutionProfile extends Equatable {
  final int? id;
  final int institution;
  @JsonKey(name: 'user_id')
  final String userID;
  @JsonKey(name: 'student_id')
  final String studentId;
  @JsonKey(name: 'student_name')
  final String studentName;
  @JsonKey(defaultValue: Gender.unknown, unknownEnumValue: Gender.unknown)
  final Gender? gender;
  @JsonKey(name: 'national_id')
  final String? nationalId;
  @JsonKey(name: 'nationality')
  final String? nationality;
  final String? program;
  final String? major;
  final int? year;
  final double? gpa;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;

  @JsonKey(name: 'disability_status')
  final String? disabilityStatus;
  final String? school;
  final String? phone;
  final String? email;
  final String? address;
  @JsonKey(
    defaultValue: AcademicStatus.unknown,
    unknownEnumValue: AcademicStatus.unknown,
  )
  final AcademicStatus? status;
  @JsonKey(name: 'enrollment_date')
  final DateTime? enrollmentDate;
  @JsonKey(name: 'expected_graduation')
  final DateTime? expectedGraduation;
  @JsonKey(name: 'raw_data')
  final Map<String, dynamic>? rawData;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const InstitutionProfile({
    required this.institution,
    required this.userID,
    required this.studentId,
    required this.studentName,
    this.id,
    this.gender,
    this.nationalId,
    this.nationality,
    this.program,
    this.major,
    this.year,
    this.gpa,
    this.disabilityStatus,
    this.school,
    this.phone,
    this.address,
    this.email,
    this.status,
    this.profilePicture,
    this.enrollmentDate,
    this.expectedGraduation,
    this.rawData,
    required this.createdAt,
    required this.updatedAt,
  });

  InstitutionProfile copyWith({
    int? id,
    int? institution,
    String? userID,
    String? studentId,
    String? studentName,
    Gender? gender,
    String? nationalId,
    String? nationality,
    String? program,
    String? major,
    int? year,
    double? gpa,
    String? disabilityStatus,
    String? school,
    String? phone,
    String? address,
    String? email,
    AcademicStatus? status,
    String? profilePicture,
    DateTime? enrollmentDate,
    DateTime? expectedGraduation,
    Map<String, dynamic>? rawData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InstitutionProfile(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      userID: userID ?? this.userID,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      nationalId: nationalId ?? this.nationalId,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      program: program ?? this.program,
      major: major ?? this.major,
      year: year ?? this.year,
      gpa: gpa ?? this.gpa,
      disabilityStatus: disabilityStatus ?? this.disabilityStatus,
      school: school ?? this.school,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      status: status ?? this.status,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      expectedGraduation: expectedGraduation ?? this.expectedGraduation,
      profilePicture: profilePicture ?? this.profilePicture,
      rawData: rawData ?? this.rawData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory InstitutionProfile.fromJson(Map<String, dynamic> json) {
    return _$InstitutionProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InstitutionProfileToJson(this);

  @override
  String toString() =>
      'InstitutionProfile(id: $id, studentId: $studentId, userID: $userID)';

  @override
  List<Object?> get props => [
    id,
    userID,
    studentId,
    studentName,
    gender,
    nationalId,
    nationality,
    program,
    major,
    year,
    gpa,
    disabilityStatus,
    school,
    phone,
    address,
    email,
    status,
    profilePicture,
    enrollmentDate,
    expectedGraduation,
    rawData,
    createdAt,
    updatedAt,
  ];
}
