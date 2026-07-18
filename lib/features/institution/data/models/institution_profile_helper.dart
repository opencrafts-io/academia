import 'package:academia/database/database.dart' as db;
import 'package:academia/features/institution/institution.dart';

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
