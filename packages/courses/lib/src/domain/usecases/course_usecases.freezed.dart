// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_usecases.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateCourseParams {

 int get institutionId; String get title; String? get code; String? get termLabel; String? get academicYear; DateTime? get termStartDate; DateTime? get termEndDate; String? get previousCourseId;
/// Create a copy of CreateCourseParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCourseParamsCopyWith<CreateCourseParams> get copyWith => _$CreateCourseParamsCopyWithImpl<CreateCourseParams>(this as CreateCourseParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CreateCourseParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCourseParams&&(identical(other.institutionId, _this.institutionId) || other.institutionId == _this.institutionId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.termLabel, _this.termLabel) || other.termLabel == _this.termLabel)&&(identical(other.academicYear, _this.academicYear) || other.academicYear == _this.academicYear)&&(identical(other.termStartDate, _this.termStartDate) || other.termStartDate == _this.termStartDate)&&(identical(other.termEndDate, _this.termEndDate) || other.termEndDate == _this.termEndDate)&&(identical(other.previousCourseId, _this.previousCourseId) || other.previousCourseId == _this.previousCourseId));
}


@override
int get hashCode {
  final _this = this as CreateCourseParams;
  return Object.hash(runtimeType,_this.institutionId,_this.title,_this.code,_this.termLabel,_this.academicYear,_this.termStartDate,_this.termEndDate,_this.previousCourseId);
}

@override
String toString() {
  final _this = this as CreateCourseParams;
  return 'CreateCourseParams(institutionId: ${_this.institutionId}, title: ${_this.title}, code: ${_this.code}, termLabel: ${_this.termLabel}, academicYear: ${_this.academicYear}, termStartDate: ${_this.termStartDate}, termEndDate: ${_this.termEndDate}, previousCourseId: ${_this.previousCourseId})';
}


}

/// @nodoc
abstract mixin class $CreateCourseParamsCopyWith<$Res>  {
  factory $CreateCourseParamsCopyWith(CreateCourseParams value, $Res Function(CreateCourseParams) _then) = _$CreateCourseParamsCopyWithImpl;
@useResult
$Res call({
 int institutionId, String title, String? code, String? termLabel, String? academicYear, DateTime? termStartDate, DateTime? termEndDate, String? previousCourseId
});




}
/// @nodoc
class _$CreateCourseParamsCopyWithImpl<$Res>
    implements $CreateCourseParamsCopyWith<$Res> {
  _$CreateCourseParamsCopyWithImpl(this._self, this._then);

  final CreateCourseParams _self;
  final $Res Function(CreateCourseParams) _then;

/// Create a copy of CreateCourseParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institutionId = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourseId = freezed,}) {
  return _then(CreateCourseParams(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourseId: freezed == previousCourseId ? _self.previousCourseId : previousCourseId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateCourseParams].
extension CreateCourseParamsPatterns on CreateCourseParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateCourseParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateCourseParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateCourseParams value)  $default,){
final _that = this;
switch (_that) {
case _CreateCourseParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateCourseParams value)?  $default,){
final _that = this;
switch (_that) {
case _CreateCourseParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateCourseParams() when $default != null:
return $default(_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId)  $default,) {final _that = this;
switch (_that) {
case _CreateCourseParams():
return $default(_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId)?  $default,) {final _that = this;
switch (_that) {
case _CreateCourseParams() when $default != null:
return $default(_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId);case _:
  return null;

}
}

}

/// @nodoc


class _CreateCourseParams implements CreateCourseParams {
  const _CreateCourseParams({required this.institutionId, required this.title, this.code, this.termLabel, this.academicYear, this.termStartDate, this.termEndDate, this.previousCourseId});
  

@override final  int institutionId;
@override final  String title;
@override final  String? code;
@override final  String? termLabel;
@override final  String? academicYear;
@override final  DateTime? termStartDate;
@override final  DateTime? termEndDate;
@override final  String? previousCourseId;

/// Create a copy of CreateCourseParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCourseParamsCopyWith<_CreateCourseParams> get copyWith => __$CreateCourseParamsCopyWithImpl<_CreateCourseParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCourseParams&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.termLabel, termLabel) || other.termLabel == termLabel)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.termStartDate, termStartDate) || other.termStartDate == termStartDate)&&(identical(other.termEndDate, termEndDate) || other.termEndDate == termEndDate)&&(identical(other.previousCourseId, previousCourseId) || other.previousCourseId == previousCourseId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,institutionId,title,code,termLabel,academicYear,termStartDate,termEndDate,previousCourseId);
}

@override
String toString() {
    return 'CreateCourseParams(institutionId: $institutionId, title: $title, code: $code, termLabel: $termLabel, academicYear: $academicYear, termStartDate: $termStartDate, termEndDate: $termEndDate, previousCourseId: $previousCourseId)';
}


}

/// @nodoc
abstract mixin class _$CreateCourseParamsCopyWith<$Res> implements $CreateCourseParamsCopyWith<$Res> {
  factory _$CreateCourseParamsCopyWith(_CreateCourseParams value, $Res Function(_CreateCourseParams) _then) = __$CreateCourseParamsCopyWithImpl;
@override @useResult
$Res call({
 int institutionId, String title, String? code, String? termLabel, String? academicYear, DateTime? termStartDate, DateTime? termEndDate, String? previousCourseId
});




}
/// @nodoc
class __$CreateCourseParamsCopyWithImpl<$Res>
    implements _$CreateCourseParamsCopyWith<$Res> {
  __$CreateCourseParamsCopyWithImpl(this._self, this._then);

  final _CreateCourseParams _self;
  final $Res Function(_CreateCourseParams) _then;

/// Create a copy of CreateCourseParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institutionId = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourseId = freezed,}) {
  return _then(_CreateCourseParams(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourseId: freezed == previousCourseId ? _self.previousCourseId : previousCourseId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AddLecturerParams {

 String get courseId; String get name; String? get email; String? get phone; String? get office;
/// Create a copy of AddLecturerParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddLecturerParamsCopyWith<AddLecturerParams> get copyWith => _$AddLecturerParamsCopyWithImpl<AddLecturerParams>(this as AddLecturerParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AddLecturerParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddLecturerParams&&(identical(other.courseId, _this.courseId) || other.courseId == _this.courseId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.office, _this.office) || other.office == _this.office));
}


@override
int get hashCode {
  final _this = this as AddLecturerParams;
  return Object.hash(runtimeType,_this.courseId,_this.name,_this.email,_this.phone,_this.office);
}

@override
String toString() {
  final _this = this as AddLecturerParams;
  return 'AddLecturerParams(courseId: ${_this.courseId}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, office: ${_this.office})';
}


}

/// @nodoc
abstract mixin class $AddLecturerParamsCopyWith<$Res>  {
  factory $AddLecturerParamsCopyWith(AddLecturerParams value, $Res Function(AddLecturerParams) _then) = _$AddLecturerParamsCopyWithImpl;
@useResult
$Res call({
 String courseId, String name, String? email, String? phone, String? office
});




}
/// @nodoc
class _$AddLecturerParamsCopyWithImpl<$Res>
    implements $AddLecturerParamsCopyWith<$Res> {
  _$AddLecturerParamsCopyWithImpl(this._self, this._then);

  final AddLecturerParams _self;
  final $Res Function(AddLecturerParams) _then;

/// Create a copy of AddLecturerParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseId = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? office = freezed,}) {
  return _then(AddLecturerParams(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,office: freezed == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddLecturerParams].
extension AddLecturerParamsPatterns on AddLecturerParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddLecturerParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddLecturerParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddLecturerParams value)  $default,){
final _that = this;
switch (_that) {
case _AddLecturerParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddLecturerParams value)?  $default,){
final _that = this;
switch (_that) {
case _AddLecturerParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String courseId,  String name,  String? email,  String? phone,  String? office)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddLecturerParams() when $default != null:
return $default(_that.courseId,_that.name,_that.email,_that.phone,_that.office);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String courseId,  String name,  String? email,  String? phone,  String? office)  $default,) {final _that = this;
switch (_that) {
case _AddLecturerParams():
return $default(_that.courseId,_that.name,_that.email,_that.phone,_that.office);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String courseId,  String name,  String? email,  String? phone,  String? office)?  $default,) {final _that = this;
switch (_that) {
case _AddLecturerParams() when $default != null:
return $default(_that.courseId,_that.name,_that.email,_that.phone,_that.office);case _:
  return null;

}
}

}

/// @nodoc


class _AddLecturerParams implements AddLecturerParams {
  const _AddLecturerParams({required this.courseId, required this.name, this.email, this.phone, this.office});
  

@override final  String courseId;
@override final  String name;
@override final  String? email;
@override final  String? phone;
@override final  String? office;

/// Create a copy of AddLecturerParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddLecturerParamsCopyWith<_AddLecturerParams> get copyWith => __$AddLecturerParamsCopyWithImpl<_AddLecturerParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddLecturerParams&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.office, office) || other.office == office));
}


@override
int get hashCode {
    return Object.hash(runtimeType,courseId,name,email,phone,office);
}

@override
String toString() {
    return 'AddLecturerParams(courseId: $courseId, name: $name, email: $email, phone: $phone, office: $office)';
}


}

/// @nodoc
abstract mixin class _$AddLecturerParamsCopyWith<$Res> implements $AddLecturerParamsCopyWith<$Res> {
  factory _$AddLecturerParamsCopyWith(_AddLecturerParams value, $Res Function(_AddLecturerParams) _then) = __$AddLecturerParamsCopyWithImpl;
@override @useResult
$Res call({
 String courseId, String name, String? email, String? phone, String? office
});




}
/// @nodoc
class __$AddLecturerParamsCopyWithImpl<$Res>
    implements _$AddLecturerParamsCopyWith<$Res> {
  __$AddLecturerParamsCopyWithImpl(this._self, this._then);

  final _AddLecturerParams _self;
  final $Res Function(_AddLecturerParams) _then;

/// Create a copy of AddLecturerParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseId = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? office = freezed,}) {
  return _then(_AddLecturerParams(
courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,office: freezed == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
