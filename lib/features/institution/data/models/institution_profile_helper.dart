import 'package:academia/database/database.dart' as db;
import 'package:academia/features/institution/institution.dart';

db.Gender? _toDbGender(ApiGender? gender) =>
    gender == null ? null : db.Gender.values.byName(gender.name);

db.AcademicStatus? _toDbAcademicStatus(ApiAcademicStatus? status) =>
    status == null ? null : db.AcademicStatus.values.byName(status.name);

ApiGender? _toApiGender(db.Gender? gender) =>
    gender == null ? null : ApiGender.values.byName(gender.name);

ApiAcademicStatus? _toApiAcademicStatus(db.AcademicStatus? status) =>
    status == null ? null : ApiAcademicStatus.values.byName(status.name);

extension InstitutionProfileHelper on InstitutionProfile {
  db.InstitutionProfile toData() => db.InstitutionProfile(
    id: id,
    institutionID: institution,
    userID: userID,
    studentID: studentId,
    studentName: studentName,
    gender: gender ?? db.Gender.unknown,
    status: status ?? db.AcademicStatus.unknown,
    email: email,
    profilePicture: profilePicture,
    nationalID: nationalId,
    nationality: nationality,
    program: program,
    major: major,
    year: year,
    gpa: gpa,
    disabilityStatus: disabilityStatus,
    school: school,
    phone: phone,
    address: address,
    enrollmentDate: enrollmentDate,
    expectedGraduation: expectedGraduation,
    rawData: rawData,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
}

extension InstitutionProfileDataHelper on db.InstitutionProfile {
  InstitutionProfile toEntity() => InstitutionProfile(
    id: id,
    institution: institutionID,
    userID: userID,
    studentId: studentID,
    studentName: studentName,
    gender: gender,
    status: status,
    email: email,
    profilePicture: profilePicture,
    nationalId: nationalID,
    nationality: nationality,
    program: program,
    major: major,
    year: year,
    gpa: gpa,
    disabilityStatus: disabilityStatus,
    school: school,
    phone: phone,
    address: address,
    enrollmentDate: enrollmentDate,
    expectedGraduation: expectedGraduation,
    rawData: rawData,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension InstitutionProfileApiDtoMapper on InstitutionProfileApiDto {
  db.InstitutionProfile toData() => db.InstitutionProfile(
    id: id,
    institutionID: institution,
    userID: userId,
    studentID: studentId,
    studentName: studentName,
    gender: _toDbGender(gender) ?? db.Gender.unknown,
    status: _toDbAcademicStatus(status) ?? db.AcademicStatus.unknown,
    email: email,
    profilePicture: profilePicture,
    nationalID: nationalId,
    nationality: nationality,
    program: program,
    major: major,
    year: year,
    gpa: gpa,
    disabilityStatus: disabilityStatus,
    school: school,
    phone: phone,
    address: address,
    enrollmentDate: enrollmentDate,
    expectedGraduation: expectedGraduation,
    rawData: rawData,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );

  InstitutionProfile toEntity() => toData().toEntity();
}

extension InstitutionProfileEntityApiDtoMapper on InstitutionProfile {
  InstitutionProfileApiDto toApiDto() => InstitutionProfileApiDto(
    id: id,
    institution: institution,
    userId: userID,
    studentId: studentId,
    studentName: studentName,
    gender: _toApiGender(gender),
    nationalId: nationalId,
    nationality: nationality,
    program: program,
    major: major,
    year: year,
    gpa: gpa,
    profilePicture: profilePicture,
    disabilityStatus: disabilityStatus,
    school: school,
    phone: phone,
    email: email,
    address: address,
    status: _toApiAcademicStatus(status),
    enrollmentDate: enrollmentDate,
    expectedGraduation: expectedGraduation,
    rawData: rawData,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
