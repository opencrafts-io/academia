// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstitutionProfile {

 int? get id; int get institution; String get userID; String get studentId; String get studentName; Gender? get gender; String? get nationalId; String? get nationality; String? get program; String? get major; int? get year; double? get gpa; String? get disabilityStatus; String? get school; String? get phone; String? get email; String? get address; AcademicStatus? get status; String? get profilePicture; DateTime? get enrollmentDate; DateTime? get expectedGraduation; Map<String, dynamic>? get rawData; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of InstitutionProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionProfileCopyWith<InstitutionProfile> get copyWith => _$InstitutionProfileCopyWithImpl<InstitutionProfile>(this as InstitutionProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nationalId, nationalId) || other.nationalId == nationalId)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.program, program) || other.program == program)&&(identical(other.major, major) || other.major == major)&&(identical(other.year, year) || other.year == year)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&(identical(other.disabilityStatus, disabilityStatus) || other.disabilityStatus == disabilityStatus)&&(identical(other.school, school) || other.school == school)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.status, status) || other.status == status)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.enrollmentDate, enrollmentDate) || other.enrollmentDate == enrollmentDate)&&(identical(other.expectedGraduation, expectedGraduation) || other.expectedGraduation == expectedGraduation)&&const DeepCollectionEquality().equals(other.rawData, rawData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,institution,userID,studentId,studentName,gender,nationalId,nationality,program,major,year,gpa,disabilityStatus,school,phone,email,address,status,profilePicture,enrollmentDate,expectedGraduation,const DeepCollectionEquality().hash(rawData),createdAt,updatedAt]);

@override
String toString() {
  return 'InstitutionProfile(id: $id, institution: $institution, userID: $userID, studentId: $studentId, studentName: $studentName, gender: $gender, nationalId: $nationalId, nationality: $nationality, program: $program, major: $major, year: $year, gpa: $gpa, disabilityStatus: $disabilityStatus, school: $school, phone: $phone, email: $email, address: $address, status: $status, profilePicture: $profilePicture, enrollmentDate: $enrollmentDate, expectedGraduation: $expectedGraduation, rawData: $rawData, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $InstitutionProfileCopyWith<$Res>  {
  factory $InstitutionProfileCopyWith(InstitutionProfile value, $Res Function(InstitutionProfile) _then) = _$InstitutionProfileCopyWithImpl;
@useResult
$Res call({
 int? id, int institution, String userID, String studentId, String studentName, Gender? gender, String? nationalId, String? nationality, String? program, String? major, int? year, double? gpa, String? disabilityStatus, String? school, String? phone, String? email, String? address, AcademicStatus? status, String? profilePicture, DateTime? enrollmentDate, DateTime? expectedGraduation, Map<String, dynamic>? rawData, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$InstitutionProfileCopyWithImpl<$Res>
    implements $InstitutionProfileCopyWith<$Res> {
  _$InstitutionProfileCopyWithImpl(this._self, this._then);

  final InstitutionProfile _self;
  final $Res Function(InstitutionProfile) _then;

/// Create a copy of InstitutionProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? institution = null,Object? userID = null,Object? studentId = null,Object? studentName = null,Object? gender = freezed,Object? nationalId = freezed,Object? nationality = freezed,Object? program = freezed,Object? major = freezed,Object? year = freezed,Object? gpa = freezed,Object? disabilityStatus = freezed,Object? school = freezed,Object? phone = freezed,Object? email = freezed,Object? address = freezed,Object? status = freezed,Object? profilePicture = freezed,Object? enrollmentDate = freezed,Object? expectedGraduation = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,disabilityStatus: freezed == disabilityStatus ? _self.disabilityStatus : disabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AcademicStatus?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,enrollmentDate: freezed == enrollmentDate ? _self.enrollmentDate : enrollmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedGraduation: freezed == expectedGraduation ? _self.expectedGraduation : expectedGraduation // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionProfile].
extension InstitutionProfilePatterns on InstitutionProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionProfile value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionProfile value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int institution,  String userID,  String studentId,  String studentName,  Gender? gender,  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa,  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address,  AcademicStatus? status,  String? profilePicture,  DateTime? enrollmentDate,  DateTime? expectedGraduation,  Map<String, dynamic>? rawData,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionProfile() when $default != null:
return $default(_that.id,_that.institution,_that.userID,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.profilePicture,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int institution,  String userID,  String studentId,  String studentName,  Gender? gender,  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa,  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address,  AcademicStatus? status,  String? profilePicture,  DateTime? enrollmentDate,  DateTime? expectedGraduation,  Map<String, dynamic>? rawData,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _InstitutionProfile():
return $default(_that.id,_that.institution,_that.userID,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.profilePicture,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int institution,  String userID,  String studentId,  String studentName,  Gender? gender,  String? nationalId,  String? nationality,  String? program,  String? major,  int? year,  double? gpa,  String? disabilityStatus,  String? school,  String? phone,  String? email,  String? address,  AcademicStatus? status,  String? profilePicture,  DateTime? enrollmentDate,  DateTime? expectedGraduation,  Map<String, dynamic>? rawData,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionProfile() when $default != null:
return $default(_that.id,_that.institution,_that.userID,_that.studentId,_that.studentName,_that.gender,_that.nationalId,_that.nationality,_that.program,_that.major,_that.year,_that.gpa,_that.disabilityStatus,_that.school,_that.phone,_that.email,_that.address,_that.status,_that.profilePicture,_that.enrollmentDate,_that.expectedGraduation,_that.rawData,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _InstitutionProfile implements InstitutionProfile {
  const _InstitutionProfile({this.id, required this.institution, required this.userID, required this.studentId, required this.studentName, this.gender, this.nationalId, this.nationality, this.program, this.major, this.year, this.gpa, this.disabilityStatus, this.school, this.phone, this.email, this.address, this.status, this.profilePicture, this.enrollmentDate, this.expectedGraduation, final  Map<String, dynamic>? rawData, required this.createdAt, required this.updatedAt}): _rawData = rawData;
  

@override final  int? id;
@override final  int institution;
@override final  String userID;
@override final  String studentId;
@override final  String studentName;
@override final  Gender? gender;
@override final  String? nationalId;
@override final  String? nationality;
@override final  String? program;
@override final  String? major;
@override final  int? year;
@override final  double? gpa;
@override final  String? disabilityStatus;
@override final  String? school;
@override final  String? phone;
@override final  String? email;
@override final  String? address;
@override final  AcademicStatus? status;
@override final  String? profilePicture;
@override final  DateTime? enrollmentDate;
@override final  DateTime? expectedGraduation;
 final  Map<String, dynamic>? _rawData;
@override Map<String, dynamic>? get rawData {
  final value = _rawData;
  if (value == null) return null;
  if (_rawData is EqualUnmodifiableMapView) return _rawData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of InstitutionProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionProfileCopyWith<_InstitutionProfile> get copyWith => __$InstitutionProfileCopyWithImpl<_InstitutionProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.nationalId, nationalId) || other.nationalId == nationalId)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.program, program) || other.program == program)&&(identical(other.major, major) || other.major == major)&&(identical(other.year, year) || other.year == year)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&(identical(other.disabilityStatus, disabilityStatus) || other.disabilityStatus == disabilityStatus)&&(identical(other.school, school) || other.school == school)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.status, status) || other.status == status)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.enrollmentDate, enrollmentDate) || other.enrollmentDate == enrollmentDate)&&(identical(other.expectedGraduation, expectedGraduation) || other.expectedGraduation == expectedGraduation)&&const DeepCollectionEquality().equals(other._rawData, _rawData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,institution,userID,studentId,studentName,gender,nationalId,nationality,program,major,year,gpa,disabilityStatus,school,phone,email,address,status,profilePicture,enrollmentDate,expectedGraduation,const DeepCollectionEquality().hash(_rawData),createdAt,updatedAt]);

@override
String toString() {
  return 'InstitutionProfile(id: $id, institution: $institution, userID: $userID, studentId: $studentId, studentName: $studentName, gender: $gender, nationalId: $nationalId, nationality: $nationality, program: $program, major: $major, year: $year, gpa: $gpa, disabilityStatus: $disabilityStatus, school: $school, phone: $phone, email: $email, address: $address, status: $status, profilePicture: $profilePicture, enrollmentDate: $enrollmentDate, expectedGraduation: $expectedGraduation, rawData: $rawData, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InstitutionProfileCopyWith<$Res> implements $InstitutionProfileCopyWith<$Res> {
  factory _$InstitutionProfileCopyWith(_InstitutionProfile value, $Res Function(_InstitutionProfile) _then) = __$InstitutionProfileCopyWithImpl;
@override @useResult
$Res call({
 int? id, int institution, String userID, String studentId, String studentName, Gender? gender, String? nationalId, String? nationality, String? program, String? major, int? year, double? gpa, String? disabilityStatus, String? school, String? phone, String? email, String? address, AcademicStatus? status, String? profilePicture, DateTime? enrollmentDate, DateTime? expectedGraduation, Map<String, dynamic>? rawData, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$InstitutionProfileCopyWithImpl<$Res>
    implements _$InstitutionProfileCopyWith<$Res> {
  __$InstitutionProfileCopyWithImpl(this._self, this._then);

  final _InstitutionProfile _self;
  final $Res Function(_InstitutionProfile) _then;

/// Create a copy of InstitutionProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? institution = null,Object? userID = null,Object? studentId = null,Object? studentName = null,Object? gender = freezed,Object? nationalId = freezed,Object? nationality = freezed,Object? program = freezed,Object? major = freezed,Object? year = freezed,Object? gpa = freezed,Object? disabilityStatus = freezed,Object? school = freezed,Object? phone = freezed,Object? email = freezed,Object? address = freezed,Object? status = freezed,Object? profilePicture = freezed,Object? enrollmentDate = freezed,Object? expectedGraduation = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_InstitutionProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,nationalId: freezed == nationalId ? _self.nationalId : nationalId // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,disabilityStatus: freezed == disabilityStatus ? _self.disabilityStatus : disabilityStatus // ignore: cast_nullable_to_non_nullable
as String?,school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AcademicStatus?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,enrollmentDate: freezed == enrollmentDate ? _self.enrollmentDate : enrollmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedGraduation: freezed == expectedGraduation ? _self.expectedGraduation : expectedGraduation // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self._rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
