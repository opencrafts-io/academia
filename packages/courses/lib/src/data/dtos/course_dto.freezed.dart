// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseDto {

 String get id; int get institution; String get title; String? get code;@JsonKey(name: 'term_label') String? get termLabel;@JsonKey(name: 'academic_year') String? get academicYear;@JsonKey(name: 'term_start_date') DateTime? get termStartDate;@JsonKey(name: 'term_end_date') DateTime? get termEndDate;@JsonKey(name: 'previous_course') String? get previousCourse;@JsonKey(name: 'archived_at') DateTime? get archivedAt;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; List<LecturerDto> get lecturers;
/// Create a copy of CourseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDtoCopyWith<CourseDto> get copyWith => _$CourseDtoCopyWithImpl<CourseDto>(this as CourseDto, _$identity);

  /// Serializes this CourseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CourseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.institution, _this.institution) || other.institution == _this.institution)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.termLabel, _this.termLabel) || other.termLabel == _this.termLabel)&&(identical(other.academicYear, _this.academicYear) || other.academicYear == _this.academicYear)&&(identical(other.termStartDate, _this.termStartDate) || other.termStartDate == _this.termStartDate)&&(identical(other.termEndDate, _this.termEndDate) || other.termEndDate == _this.termEndDate)&&(identical(other.previousCourse, _this.previousCourse) || other.previousCourse == _this.previousCourse)&&(identical(other.archivedAt, _this.archivedAt) || other.archivedAt == _this.archivedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.lecturers, _this.lecturers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CourseDto;
  return Object.hash(runtimeType,_this.id,_this.institution,_this.title,_this.code,_this.termLabel,_this.academicYear,_this.termStartDate,_this.termEndDate,_this.previousCourse,_this.archivedAt,_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.lecturers));
}

@override
String toString() {
  final _this = this as CourseDto;
  return 'CourseDto(id: ${_this.id}, institution: ${_this.institution}, title: ${_this.title}, code: ${_this.code}, termLabel: ${_this.termLabel}, academicYear: ${_this.academicYear}, termStartDate: ${_this.termStartDate}, termEndDate: ${_this.termEndDate}, previousCourse: ${_this.previousCourse}, archivedAt: ${_this.archivedAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, lecturers: ${_this.lecturers})';
}


}

/// @nodoc
abstract mixin class $CourseDtoCopyWith<$Res>  {
  factory $CourseDtoCopyWith(CourseDto value, $Res Function(CourseDto) _then) = _$CourseDtoCopyWithImpl;
@useResult
$Res call({
 String id, int institution, String title, String? code,@JsonKey(name: 'term_label') String? termLabel,@JsonKey(name: 'academic_year') String? academicYear,@JsonKey(name: 'term_start_date') DateTime? termStartDate,@JsonKey(name: 'term_end_date') DateTime? termEndDate,@JsonKey(name: 'previous_course') String? previousCourse,@JsonKey(name: 'archived_at') DateTime? archivedAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, List<LecturerDto> lecturers
});




}
/// @nodoc
class _$CourseDtoCopyWithImpl<$Res>
    implements $CourseDtoCopyWith<$Res> {
  _$CourseDtoCopyWithImpl(this._self, this._then);

  final CourseDto _self;
  final $Res Function(CourseDto) _then;

/// Create a copy of CourseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? institution = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourse = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? lecturers = null,}) {
  return _then(CourseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourse: freezed == previousCourse ? _self.previousCourse : previousCourse // ignore: cast_nullable_to_non_nullable
as String?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lecturers: null == lecturers ? _self.lecturers : lecturers // ignore: cast_nullable_to_non_nullable
as List<LecturerDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseDto].
extension CourseDtoPatterns on CourseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseDto value)  $default,){
final _that = this;
switch (_that) {
case _CourseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CourseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int institution,  String title,  String? code, @JsonKey(name: 'term_label')  String? termLabel, @JsonKey(name: 'academic_year')  String? academicYear, @JsonKey(name: 'term_start_date')  DateTime? termStartDate, @JsonKey(name: 'term_end_date')  DateTime? termEndDate, @JsonKey(name: 'previous_course')  String? previousCourse, @JsonKey(name: 'archived_at')  DateTime? archivedAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<LecturerDto> lecturers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseDto() when $default != null:
return $default(_that.id,_that.institution,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourse,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int institution,  String title,  String? code, @JsonKey(name: 'term_label')  String? termLabel, @JsonKey(name: 'academic_year')  String? academicYear, @JsonKey(name: 'term_start_date')  DateTime? termStartDate, @JsonKey(name: 'term_end_date')  DateTime? termEndDate, @JsonKey(name: 'previous_course')  String? previousCourse, @JsonKey(name: 'archived_at')  DateTime? archivedAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<LecturerDto> lecturers)  $default,) {final _that = this;
switch (_that) {
case _CourseDto():
return $default(_that.id,_that.institution,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourse,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int institution,  String title,  String? code, @JsonKey(name: 'term_label')  String? termLabel, @JsonKey(name: 'academic_year')  String? academicYear, @JsonKey(name: 'term_start_date')  DateTime? termStartDate, @JsonKey(name: 'term_end_date')  DateTime? termEndDate, @JsonKey(name: 'previous_course')  String? previousCourse, @JsonKey(name: 'archived_at')  DateTime? archivedAt, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  List<LecturerDto> lecturers)?  $default,) {final _that = this;
switch (_that) {
case _CourseDto() when $default != null:
return $default(_that.id,_that.institution,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourse,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourseDto implements CourseDto {
  const _CourseDto({required this.id, required this.institution, required this.title, this.code, @JsonKey(name: 'term_label') this.termLabel, @JsonKey(name: 'academic_year') this.academicYear, @JsonKey(name: 'term_start_date') this.termStartDate, @JsonKey(name: 'term_end_date') this.termEndDate, @JsonKey(name: 'previous_course') this.previousCourse, @JsonKey(name: 'archived_at') this.archivedAt, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt,  List<LecturerDto> lecturers = const []}): _lecturers = lecturers;
  factory _CourseDto.fromJson(Map<String, dynamic> json) => _$CourseDtoFromJson(json);

@override final  String id;
@override final  int institution;
@override final  String title;
@override final  String? code;
@override@JsonKey(name: 'term_label') final  String? termLabel;
@override@JsonKey(name: 'academic_year') final  String? academicYear;
@override@JsonKey(name: 'term_start_date') final  DateTime? termStartDate;
@override@JsonKey(name: 'term_end_date') final  DateTime? termEndDate;
@override@JsonKey(name: 'previous_course') final  String? previousCourse;
@override@JsonKey(name: 'archived_at') final  DateTime? archivedAt;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
 final  List<LecturerDto> _lecturers;
@override@JsonKey() List<LecturerDto> get lecturers {
  if (_lecturers is EqualUnmodifiableListView) return _lecturers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lecturers);
}


/// Create a copy of CourseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseDtoCopyWith<_CourseDto> get copyWith => __$CourseDtoCopyWithImpl<_CourseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.termLabel, termLabel) || other.termLabel == termLabel)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.termStartDate, termStartDate) || other.termStartDate == termStartDate)&&(identical(other.termEndDate, termEndDate) || other.termEndDate == termEndDate)&&(identical(other.previousCourse, previousCourse) || other.previousCourse == previousCourse)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.lecturers, _lecturers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,institution,title,code,termLabel,academicYear,termStartDate,termEndDate,previousCourse,archivedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_lecturers));
}

@override
String toString() {
    return 'CourseDto(id: $id, institution: $institution, title: $title, code: $code, termLabel: $termLabel, academicYear: $academicYear, termStartDate: $termStartDate, termEndDate: $termEndDate, previousCourse: $previousCourse, archivedAt: $archivedAt, createdAt: $createdAt, updatedAt: $updatedAt, lecturers: $lecturers)';
}


}

/// @nodoc
abstract mixin class _$CourseDtoCopyWith<$Res> implements $CourseDtoCopyWith<$Res> {
  factory _$CourseDtoCopyWith(_CourseDto value, $Res Function(_CourseDto) _then) = __$CourseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int institution, String title, String? code,@JsonKey(name: 'term_label') String? termLabel,@JsonKey(name: 'academic_year') String? academicYear,@JsonKey(name: 'term_start_date') DateTime? termStartDate,@JsonKey(name: 'term_end_date') DateTime? termEndDate,@JsonKey(name: 'previous_course') String? previousCourse,@JsonKey(name: 'archived_at') DateTime? archivedAt,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, List<LecturerDto> lecturers
});




}
/// @nodoc
class __$CourseDtoCopyWithImpl<$Res>
    implements _$CourseDtoCopyWith<$Res> {
  __$CourseDtoCopyWithImpl(this._self, this._then);

  final _CourseDto _self;
  final $Res Function(_CourseDto) _then;

/// Create a copy of CourseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? institution = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourse = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? lecturers = null,}) {
  return _then(_CourseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourse: freezed == previousCourse ? _self.previousCourse : previousCourse // ignore: cast_nullable_to_non_nullable
as String?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lecturers: null == lecturers ? _self._lecturers : lecturers // ignore: cast_nullable_to_non_nullable
as List<LecturerDto>,
  ));
}


}

// dart format on
