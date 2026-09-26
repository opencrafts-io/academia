// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_profile_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InstitutionProfileApiDto {

 int? get id; int get institution;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'student_id') String get studentId;@JsonKey(name: 'student_name') String get studentName;@JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown) ApiGender? get gender;@JsonKey(name: 'national_id') String? get nationalId; String? get nationality; String? get program; String? get major; int? get year; double? get gpa;@JsonKey(name: 'profile_picture') String? get profilePicture;@JsonKey(name: 'disability_status') String? get disabilityStatus; String? get school; String? get phone; String? get email; String? get address;@JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown) ApiAcademicStatus? get status;@JsonKey(name: 'enrollment_date') DateTime? get enrollmentDate;@JsonKey(name: 'expected_graduation') DateTime? get expectedGraduation;@JsonKey(name: 'raw_data') Map<String, dynamic>? get rawData;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of InstitutionProfileApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionProfileApiDtoCopyWith<InstitutionProfileApiDto> get copyWith => _$InstitutionProfileApiDtoCopyWithImpl<InstitutionProfileApiDto>(this as InstitutionProfileApiDto, _$identity);

  /// Serializes this InstitutionProfileApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InstitutionProfileApiDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionProfileApiDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.institution, _this.institution) || other.institution == _this.institution)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.studentName, _this.studentName) || other.studentName == _this.studentName)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.nationalId, _this.nationalId) || other.nationalId == _this.nationalId)&&(identical(other.nationality, _this.nationality) || other.nationality == _this.nationality)&&(identical(other.program, _this.program) || other.program == _this.program)&&(identical(other.major, _this.major) || other.major == _this.major)&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.gpa, _this.gpa) || other.gpa == _this.gpa)&&(identical(other.profilePicture, _this.profilePicture) || other.profilePicture == _this.profilePicture)&&(identical(other.disabilityStatus, _this.disabilityStatus) || other.disabilityStatus == _this.disabilityStatus)&&(identical(other.school, _this.school) || other.school == _this.school)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.enrollmentDate, _this.enrollmentDate) || other.enrollmentDate == _this.enrollmentDate)&&(identical(other.expectedGraduation, _this.expectedGraduation) || other.expectedGraduation == _this.expectedGraduation)&&const DeepCollectionEquality().equals(other.rawData, _this.rawData)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InstitutionProfileApiDto;
  return Object.hashAll([runtimeType,_this.id,_this.institution,_this.userId,_this.studentId,_this.studentName,_this.gender,_this.nationalId,_this.nationality,_this.program,_this.major,_this.year,_this.gpa,_this.profilePicture,_this.disabilityStatus,_this.school,_this.phone,_this.email,_this.address,_this.status,_this.enrollmentDate,_this.expectedGraduation,const DeepCollectionEquality().hash(_this.rawData),_this.createdAt,_this.updatedAt]);
}

@override
String toString() {
  final _this = this as InstitutionProfileApiDto;
  return 'InstitutionProfileApiDto(id: ${_this.id}, institution: ${_this.institution}, userId: ${_this.userId}, studentId: ${_this.studentId}, studentName: ${_this.studentName}, gender: ${_this.gender}, nationalId: ${_this.nationalId}, nationality: ${_this.nationality}, program: ${_this.program}, major: ${_this.major}, year: ${_this.year}, gpa: ${_this.gpa}, profilePicture: ${_this.profilePicture}, disabilityStatus: ${_this.disabilityStatus}, school: ${_this.school}, phone: ${_this.phone}, email: ${_this.email}, address: ${_this.address}, status: ${_this.status}, enrollmentDate: ${_this.enrollmentDate}, expectedGraduation: ${_this.expectedGraduation}, rawData: ${_this.rawData}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $InstitutionProfileApiDtoCopyWith<$Res>  {
  factory $InstitutionProfileApiDtoCopyWith(InstitutionProfileApiDto value, $Res Function(InstitutionProfileApiDto) _then) = _$InstitutionProfileApiDtoCopyWithImpl;
@useResult
$Res call({
 int? id, int institution,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'student_name') String studentName,@JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown) ApiGender? gender,@JsonKey(name: 'national_id') String? nationalId, String? nationality, String? program, String? major, int? year, double? gpa,@JsonKey(name: 'profile_picture') String? profilePicture,@JsonKey(name: 'disability_status') String? disabilityStatus, String? school, String? phone, String? email, String? address,@JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown) ApiAcademicStatus? status,@JsonKey(name: 'enrollment_date') DateTime? enrollmentDate,@JsonKey(name: 'expected_graduation') DateTime? expectedGraduation,@JsonKey(name: 'raw_data') Map<String, dynamic>? rawData,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$InstitutionProfileApiDtoCopyWithImpl<$Res>
    implements $InstitutionProfileApiDtoCopyWith<$Res> {
  _$InstitutionProfileApiDtoCopyWithImpl(this._self, this._then);

  final InstitutionProfileApiDto _self;
  final $Res Function(InstitutionProfileApiDto) _then;

/// Create a copy of InstitutionProfileApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? institution = null,Object? userId = null,Object? studentId = null,Object? studentName = null,Object? gender = freezed,Object? nationalId = freezed,Object? nationality = freezed,Object? program = freezed,Object? major = freezed,Object? year = freezed,Object? gpa = freezed,Object? profilePicture = freezed,Object? disabilityStatus = freezed,Object? school = freezed,Object? phone = freezed,Object? email = freezed,Object? address = freezed,Object? status = freezed,Object? enrollmentDate = freezed,Object? expectedGraduation = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(InstitutionProfileApiDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as ApiGender?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,disabilityStatus: freezed == disabilityStatus ? _self.disabilityStatus : disabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApiAcademicStatus?,enrollmentDate: freezed == enrollmentDate ? _self.enrollmentDate : enrollmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedGraduation: freezed == expectedGraduation ? _self.expectedGraduation : expectedGraduation // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionProfileApiDto].
extension InstitutionProfileApiDtoPatterns on InstitutionProfileApiDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionProfileApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionProfileApiDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionProfileApiDto value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionProfileApiDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionProfileApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionProfileApiDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int institution, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'student_name')  String studentName, @JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown)  ApiGender? gender, @JsonKey(name: 'national_id')  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'disability_status')  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address, @JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown)  ApiAcademicStatus? status, @JsonKey(name: 'enrollment_date')  DateTime? enrollmentDate, @JsonKey(name: 'expected_graduation')  DateTime? expectedGraduation, @JsonKey(name: 'raw_data')  Map<String, dynamic>? rawData, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionProfileApiDto() when $default != null:
return $default(_that.id,_that.institution,_that.userId,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.profilePicture,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int institution, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'student_name')  String studentName, @JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown)  ApiGender? gender, @JsonKey(name: 'national_id')  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'disability_status')  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address, @JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown)  ApiAcademicStatus? status, @JsonKey(name: 'enrollment_date')  DateTime? enrollmentDate, @JsonKey(name: 'expected_graduation')  DateTime? expectedGraduation, @JsonKey(name: 'raw_data')  Map<String, dynamic>? rawData, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _InstitutionProfileApiDto():
return $default(_that.id,_that.institution,_that.userId,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.profilePicture,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int institution, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'student_id')  String studentId, @JsonKey(name: 'student_name')  String studentName, @JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown)  ApiGender? gender, @JsonKey(name: 'national_id')  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'disability_status')  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address, @JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown)  ApiAcademicStatus? status, @JsonKey(name: 'enrollment_date')  DateTime? enrollmentDate, @JsonKey(name: 'expected_graduation')  DateTime? expectedGraduation, @JsonKey(name: 'raw_data')  Map<String, dynamic>? rawData, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionProfileApiDto() when $default != null:
return $default(_that.id,_that.institution,_that.userId,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.profilePicture,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstitutionProfileApiDto implements InstitutionProfileApiDto {
  const _InstitutionProfileApiDto({this.id, required this.institution, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'student_id') required this.studentId, @JsonKey(name: 'student_name') required this.studentName, @JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown) this.gender, @JsonKey(name: 'national_id') this.nationalId, this.nationality, this.program, this.major, this.year, this.gpa, @JsonKey(name: 'profile_picture') this.profilePicture, @JsonKey(name: 'disability_status') this.disabilityStatus, this.school, this.phone, this.email, this.address, @JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown) this.status, @JsonKey(name: 'enrollment_date') this.enrollmentDate, @JsonKey(name: 'expected_graduation') this.expectedGraduation, @JsonKey(name: 'raw_data')  Map<String, dynamic>? rawData, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _rawData = rawData;
  factory _InstitutionProfileApiDto.fromJson(Map<String, dynamic> json) => _$InstitutionProfileApiDtoFromJson(json);

@override final  int? id;
@override final  int institution;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'student_id') final  String studentId;
@override@JsonKey(name: 'student_name') final  String studentName;
@override@JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown) final  ApiGender? gender;
@override@JsonKey(name: 'national_id') final  String? nationalId;
@override final  String? nationality;
@override final  String? program;
@override final  String? major;
@override final  int? year;
@override final  double? gpa;
@override@JsonKey(name: 'profile_picture') final  String? profilePicture;
@override@JsonKey(name: 'disability_status') final  String? disabilityStatus;
@override final  String? school;
@override final  String? phone;
@override final  String? email;
@override final  String? address;
@override@JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown) final  ApiAcademicStatus? status;
@override@JsonKey(name: 'enrollment_date') final  DateTime? enrollmentDate;
@override@JsonKey(name: 'expected_graduation') final  DateTime? expectedGraduation;
 final  Map<String, dynamic>? _rawData;
@override@JsonKey(name: 'raw_data') Map<String, dynamic>? get rawData {
  final value = _rawData;
  if (value == null) return null;
  if (_rawData is EqualUnmodifiableMapView) return _rawData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of InstitutionProfileApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionProfileApiDtoCopyWith<_InstitutionProfileApiDto> get copyWith => __$InstitutionProfileApiDtoCopyWithImpl<_InstitutionProfileApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstitutionProfileApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionProfileApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nationalId, nationalId) || other.nationalId == nationalId)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.program, program) || other.program == program)&&(identical(other.major, major) || other.major == major)&&(identical(other.year, year) || other.year == year)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.disabilityStatus, disabilityStatus) || other.disabilityStatus == disabilityStatus)&&(identical(other.school, school) || other.school == school)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.status, status) || other.status == status)&&(identical(other.enrollmentDate, enrollmentDate) || other.enrollmentDate == enrollmentDate)&&(identical(other.expectedGraduation, expectedGraduation) || other.expectedGraduation == expectedGraduation)&&const DeepCollectionEquality().equals(other.rawData, _rawData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,institution,userId,studentId,studentName,gender,nationalId,nationality,program,major,year,gpa,profilePicture,disabilityStatus,school,phone,email,address,status,enrollmentDate,expectedGraduation,const DeepCollectionEquality().hash(_rawData),createdAt,updatedAt]);
}

@override
String toString() {
    return 'InstitutionProfileApiDto(id: $id, institution: $institution, userId: $userId, studentId: $studentId, studentName: $studentName, gender: $gender, nationalId: $nationalId, nationality: $nationality, program: $program, major: $major, year: $year, gpa: $gpa, profilePicture: $profilePicture, disabilityStatus: $disabilityStatus, school: $school, phone: $phone, email: $email, address: $address, status: $status, enrollmentDate: $enrollmentDate, expectedGraduation: $expectedGraduation, rawData: $rawData, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InstitutionProfileApiDtoCopyWith<$Res> implements $InstitutionProfileApiDtoCopyWith<$Res> {
  factory _$InstitutionProfileApiDtoCopyWith(_InstitutionProfileApiDto value, $Res Function(_InstitutionProfileApiDto) _then) = __$InstitutionProfileApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, int institution,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'student_id') String studentId,@JsonKey(name: 'student_name') String studentName,@JsonKey(unknownEnumValue: ApiGender.unknown, defaultValue: ApiGender.unknown) ApiGender? gender,@JsonKey(name: 'national_id') String? nationalId, String? nationality, String? program, String? major, int? year, double? gpa,@JsonKey(name: 'profile_picture') String? profilePicture,@JsonKey(name: 'disability_status') String? disabilityStatus, String? school, String? phone, String? email, String? address,@JsonKey(unknownEnumValue: ApiAcademicStatus.unknown, defaultValue: ApiAcademicStatus.unknown) ApiAcademicStatus? status,@JsonKey(name: 'enrollment_date') DateTime? enrollmentDate,@JsonKey(name: 'expected_graduation') DateTime? expectedGraduation,@JsonKey(name: 'raw_data') Map<String, dynamic>? rawData,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$InstitutionProfileApiDtoCopyWithImpl<$Res>
    implements _$InstitutionProfileApiDtoCopyWith<$Res> {
  __$InstitutionProfileApiDtoCopyWithImpl(this._self, this._then);

  final _InstitutionProfileApiDto _self;
  final $Res Function(_InstitutionProfileApiDto) _then;

/// Create a copy of InstitutionProfileApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? institution = null,Object? userId = null,Object? studentId = null,Object? studentName = null,Object? gender = freezed,Object? nationalId = freezed,Object? nationality = freezed,Object? program = freezed,Object? major = freezed,Object? year = freezed,Object? gpa = freezed,Object? profilePicture = freezed,Object? disabilityStatus = freezed,Object? school = freezed,Object? phone = freezed,Object? email = freezed,Object? address = freezed,Object? status = freezed,Object? enrollmentDate = freezed,Object? expectedGraduation = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_InstitutionProfileApiDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as ApiGender?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,disabilityStatus: freezed == disabilityStatus ? _self.disabilityStatus : disabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApiAcademicStatus?,enrollmentDate: freezed == enrollmentDate ? _self.enrollmentDate : enrollmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedGraduation: freezed == expectedGraduation ? _self.expectedGraduation : expectedGraduation // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self._rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
