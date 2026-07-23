import 'package:academia/database/database.dart' show Gender, AcademicStatus;
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:academia/database/database.dart' show Gender, AcademicStatus;

part 'institution_profile.freezed.dart';

@freezed
abstract class InstitutionProfile with _$InstitutionProfile {
  const factory InstitutionProfile({
    int? id,
    required int institution,
    required String userID,
    required String studentId,
    required String studentName,
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
    String? email,
    String? address,
    AcademicStatus? status,
    String? profilePicture,
    DateTime? enrollmentDate,
    DateTime? expectedGraduation,
    Map<String, dynamic>? rawData,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _InstitutionProfile;
}
