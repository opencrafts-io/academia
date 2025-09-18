import 'package:drift/drift.dart';

class MagnetStudentProfile extends Table {
  // Verisafe's user id
  @JsonKey("user_id")
  TextColumn get userID => text()();

  // The institution id
  @JsonKey("institution_id")
  IntColumn get institutionID => integer()();

  // Admission number as the primary key
  @JsonKey("admission_number")
  TextColumn get admissionNumber => text().named('admission_number')();

  @JsonKey("first_name")
  TextColumn get firstName => text().named('first_name')();
  @JsonKey("other_names")
  TextColumn get otherNames => text().named('other_names')();

  @JsonKey("national_id")
  TextColumn get nationalId => text().named('national_id').nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get email => text().nullable()();
  @JsonKey("phone_number")
  TextColumn get phoneNumber => text().named('phone_number').nullable()();
  @JsonKey("profile_picture_url")
  TextColumn get profilePictureUrl =>
      text().named('profile_picture_url').nullable()();

  @JsonKey("date_of_birth")
  DateTimeColumn get dateOfBirth =>
      dateTime().named('date_of_birth').nullable()();

  TextColumn get school => text().named('school')();
  TextColumn get campus => text().nullable()();
  @JsonKey("enrollment_status")
  TextColumn get enrollmentStatus =>
      text().named('enrollment_status').nullable()();
  TextColumn get programme => text().nullable()();
  TextColumn get degree => text().nullable()();

  IntColumn get academicYear => integer().nullable()();
  RealColumn get gpa => real().nullable()();

  @JsonKey("emergency_contact")
  TextColumn get emergencyContact =>
      text().named('emergency_contact').nullable()();
  @JsonKey("parent_name")
  TextColumn get parentName => text().named('parent_name').nullable()();

  @JsonKey("date_of_admission")
  DateTimeColumn get dateOfAdmission =>
      dateTime().named('date_of_admission').nullable()();
  @JsonKey("graduation_date")
  DateTimeColumn get graduationDate =>
      dateTime().named('graduation_date').nullable()();

  @JsonKey("disability_status")
  TextColumn get disabilityStatus =>
      text().named('disability_status').nullable()();

  @JsonKey("is_international_student")
  BoolColumn get isInternationalStudent =>
      boolean().named('is_international_student').nullable()();

  @override
  Set<Column> get primaryKey => {admissionNumber, institutionID, userID};
}
