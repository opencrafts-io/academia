import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'institution_profile.g.dart';

@JsonSerializable()
class InstitutionProfile extends Equatable {
  final int id;
  @JsonKey(name: 'user_id')
  final String userID;
  @JsonKey(name: 'student_id')
  final String studentId;
  @JsonKey(name: 'national_id')
  final String? nationalId;
  @JsonKey(name: 'nationality')
  final String? nationality;
  final String? program;
  final String? major;
  final int? year;
  final double? gpa;
  @JsonKey(name: 'disability_status')
  final String? disabilityStatus;
  final String? school;
  final String? phone;
  final String? address;
  @JsonKey(name: 'enrollment_date')
  final DateTime? enrollmentDate;
  @JsonKey(name: 'expected_graduation')
  final DateTime? expectedGraduation;
  @JsonKey(name: 'raw_data')
  final Map<String, dynamic>? rawData;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const InstitutionProfile({
    required this.id,
    required this.userID,
    required this.studentId,
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
    this.enrollmentDate,
    this.expectedGraduation,
    this.rawData,
    required this.createdAt,
    required this.updatedAt,
  });

  InstitutionProfile copyWith({
    int? id,
    String? userID,
    String? studentId,
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
    DateTime? enrollmentDate,
    DateTime? expectedGraduation,
    Map<String, dynamic>? rawData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InstitutionProfile(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      studentId: studentId ?? this.studentId,
      nationalId: nationalId ?? this.nationalId,
      nationality: nationality ?? this.nationality,
      program: program ?? this.program,
      major: major ?? this.major,
      year: year ?? this.year,
      gpa: gpa ?? this.gpa,
      disabilityStatus: disabilityStatus ?? this.disabilityStatus,
      school: school ?? this.school,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      expectedGraduation: expectedGraduation ?? this.expectedGraduation,
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
    enrollmentDate,
    expectedGraduation,
    rawData,
    createdAt,
    updatedAt,
  ];
}
