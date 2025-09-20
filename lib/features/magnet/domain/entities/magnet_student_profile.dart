/// Entity class for representing a student's profile from magnet
class MagnetStudentProfile {
  // Verisafe's user id
  final String userID;

  // The institution the student's profile is part of
  final int institutionID;

  /// The student's admission number.
  final String admissionNumber;

  /// The student's first name.
  final String firstName;

  /// The student's other names (e.g., middle name and surname).
  final String otherNames;

  final String? nationalID;

  final String? gender;

  final String? address;

  final String? email;

  final String? phoneNumber;

  final String? profilePictureUrl;

  final DateTime? dateOfBirth;

  /// The student's school name.
  final String school;

  final String? campus;

  final String? enrollmentStatus;

  final String? programme;

  final String? degree;

  final int? academicYear;

  final double? gpa;

  final String? emergencyContact;

  final String? parentName;

  final DateTime? dateOfAdmission;

  final DateTime? graduationDate;

  final String? disabilityStatus;

  final bool? isInternationalStudent;

  const MagnetStudentProfile({
    required this.userID,
    required this.institutionID,
    required this.admissionNumber,
    required this.firstName,
    required this.otherNames,
    required this.school,
    this.nationalID,
    this.gender,
    this.address,
    this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.dateOfBirth,
    this.campus,
    this.enrollmentStatus,
    this.programme,
    this.degree,
    this.academicYear,
    this.gpa,
    this.emergencyContact,
    this.parentName,
    this.dateOfAdmission,
    this.graduationDate,
    this.disabilityStatus,
    this.isInternationalStudent,
  });

  /// Returns the student's full name.
  String get fullName => '$firstName $otherNames';

  /// Creates a copy of this [MagnetStudentProfile] object with the given
  /// fields replaced with new values.
  MagnetStudentProfile copyWith({
    String? userID,
    int? institutionID,
    String? admissionNumber,
    String? firstName,
    String? otherNames,
    String? nationalID,
    String? gender,
    String? address,
    String? email,
    String? phoneNumber,
    String? profilePictureUrl,
    DateTime? dateOfBirth,
    String? school,
    String? campus,
    String? enrollmentStatus,
    String? programme,
    String? degree,
    int? academicYear,
    double? gpa,
    String? emergencyContact,
    String? parentName,
    DateTime? dateOfAdmission,
    DateTime? graduationDate,
    String? disabilityStatus,
    bool? isInternationalStudent,
  }) {
    return MagnetStudentProfile(
      userID: userID ?? this.userID,
      institutionID: institutionID ?? this.institutionID,
      admissionNumber: admissionNumber ?? this.admissionNumber,
      firstName: firstName ?? this.firstName,
      otherNames: otherNames ?? this.otherNames,
      nationalID: nationalID ?? this.nationalID,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      school: school ?? this.school,
      campus: campus ?? this.campus,
      enrollmentStatus: enrollmentStatus ?? this.enrollmentStatus,
      programme: programme ?? this.programme,
      degree: degree ?? this.degree,
      academicYear: academicYear ?? this.academicYear,
      gpa: gpa ?? this.gpa,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      parentName: parentName ?? this.parentName,
      dateOfAdmission: dateOfAdmission ?? this.dateOfAdmission,
      graduationDate: graduationDate ?? this.graduationDate,
      disabilityStatus: disabilityStatus ?? this.disabilityStatus,
      isInternationalStudent:
          isInternationalStudent ?? this.isInternationalStudent,
    );
  }
}
