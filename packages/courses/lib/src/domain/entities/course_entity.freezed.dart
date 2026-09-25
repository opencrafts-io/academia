// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseEntity {

 String get id; int get institutionId; String get title; String? get code; String? get termLabel; String? get academicYear; DateTime? get termStartDate; DateTime? get termEndDate; String? get previousCourseId; DateTime? get archivedAt; DateTime get createdAt; DateTime get updatedAt; List<LecturerEntity> get lecturers;
/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseEntityCopyWith<CourseEntity> get copyWith => _$CourseEntityCopyWithImpl<CourseEntity>(this as CourseEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CourseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.institutionId, _this.institutionId) || other.institutionId == _this.institutionId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.termLabel, _this.termLabel) || other.termLabel == _this.termLabel)&&(identical(other.academicYear, _this.academicYear) || other.academicYear == _this.academicYear)&&(identical(other.termStartDate, _this.termStartDate) || other.termStartDate == _this.termStartDate)&&(identical(other.termEndDate, _this.termEndDate) || other.termEndDate == _this.termEndDate)&&(identical(other.previousCourseId, _this.previousCourseId) || other.previousCourseId == _this.previousCourseId)&&(identical(other.archivedAt, _this.archivedAt) || other.archivedAt == _this.archivedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&const DeepCollectionEquality().equals(other.lecturers, _this.lecturers));
}


@override
int get hashCode {
  final _this = this as CourseEntity;
  return Object.hash(runtimeType,_this.id,_this.institutionId,_this.title,_this.code,_this.termLabel,_this.academicYear,_this.termStartDate,_this.termEndDate,_this.previousCourseId,_this.archivedAt,_this.createdAt,_this.updatedAt,const DeepCollectionEquality().hash(_this.lecturers));
}

@override
String toString() {
  final _this = this as CourseEntity;
  return 'CourseEntity(id: ${_this.id}, institutionId: ${_this.institutionId}, title: ${_this.title}, code: ${_this.code}, termLabel: ${_this.termLabel}, academicYear: ${_this.academicYear}, termStartDate: ${_this.termStartDate}, termEndDate: ${_this.termEndDate}, previousCourseId: ${_this.previousCourseId}, archivedAt: ${_this.archivedAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, lecturers: ${_this.lecturers})';
}


}

/// @nodoc
abstract mixin class $CourseEntityCopyWith<$Res>  {
  factory $CourseEntityCopyWith(CourseEntity value, $Res Function(CourseEntity) _then) = _$CourseEntityCopyWithImpl;
@useResult
$Res call({
 String id, int institutionId, String title, String? code, String? termLabel, String? academicYear, DateTime? termStartDate, DateTime? termEndDate, String? previousCourseId, DateTime? archivedAt, DateTime createdAt, DateTime updatedAt, List<LecturerEntity> lecturers
});




}
/// @nodoc
class _$CourseEntityCopyWithImpl<$Res>
    implements $CourseEntityCopyWith<$Res> {
  _$CourseEntityCopyWithImpl(this._self, this._then);

  final CourseEntity _self;
  final $Res Function(CourseEntity) _then;

/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? institutionId = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourseId = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? lecturers = null,}) {
  return _then(CourseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourseId: freezed == previousCourseId ? _self.previousCourseId : previousCourseId // ignore: cast_nullable_to_non_nullable
as String?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lecturers: null == lecturers ? _self.lecturers : lecturers // ignore: cast_nullable_to_non_nullable
as List<LecturerEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseEntity].
extension CourseEntityPatterns on CourseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseEntity value)  $default,){
final _that = this;
switch (_that) {
case _CourseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId,  DateTime? archivedAt,  DateTime createdAt,  DateTime updatedAt,  List<LecturerEntity> lecturers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
return $default(_that.id,_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId,  DateTime? archivedAt,  DateTime createdAt,  DateTime updatedAt,  List<LecturerEntity> lecturers)  $default,) {final _that = this;
switch (_that) {
case _CourseEntity():
return $default(_that.id,_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int institutionId,  String title,  String? code,  String? termLabel,  String? academicYear,  DateTime? termStartDate,  DateTime? termEndDate,  String? previousCourseId,  DateTime? archivedAt,  DateTime createdAt,  DateTime updatedAt,  List<LecturerEntity> lecturers)?  $default,) {final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
return $default(_that.id,_that.institutionId,_that.title,_that.code,_that.termLabel,_that.academicYear,_that.termStartDate,_that.termEndDate,_that.previousCourseId,_that.archivedAt,_that.createdAt,_that.updatedAt,_that.lecturers);case _:
  return null;

}
}

}

/// @nodoc


class _CourseEntity implements CourseEntity {
  const _CourseEntity({required this.id, required this.institutionId, required this.title, this.code, this.termLabel, this.academicYear, this.termStartDate, this.termEndDate, this.previousCourseId, this.archivedAt, required this.createdAt, required this.updatedAt,  List<LecturerEntity> lecturers = const []}): _lecturers = lecturers;


@override final  String id;
@override final  int institutionId;
@override final  String title;
@override final  String? code;
@override final  String? termLabel;
@override final  String? academicYear;
@override final  DateTime? termStartDate;
@override final  DateTime? termEndDate;
@override final  String? previousCourseId;
@override final  DateTime? archivedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<LecturerEntity> _lecturers;
@override@JsonKey() List<LecturerEntity> get lecturers {
  if (_lecturers is EqualUnmodifiableListView) return _lecturers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lecturers);
}


/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseEntityCopyWith<_CourseEntity> get copyWith => __$CourseEntityCopyWithImpl<_CourseEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.termLabel, termLabel) || other.termLabel == termLabel)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.termStartDate, termStartDate) || other.termStartDate == termStartDate)&&(identical(other.termEndDate, termEndDate) || other.termEndDate == termEndDate)&&(identical(other.previousCourseId, previousCourseId) || other.previousCourseId == previousCourseId)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.lecturers, _lecturers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,institutionId,title,code,termLabel,academicYear,termStartDate,termEndDate,previousCourseId,archivedAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_lecturers));
}

@override
String toString() {
    return 'CourseEntity(id: $id, institutionId: $institutionId, title: $title, code: $code, termLabel: $termLabel, academicYear: $academicYear, termStartDate: $termStartDate, termEndDate: $termEndDate, previousCourseId: $previousCourseId, archivedAt: $archivedAt, createdAt: $createdAt, updatedAt: $updatedAt, lecturers: $lecturers)';
}


}

/// @nodoc
abstract mixin class _$CourseEntityCopyWith<$Res> implements $CourseEntityCopyWith<$Res> {
  factory _$CourseEntityCopyWith(_CourseEntity value, $Res Function(_CourseEntity) _then) = __$CourseEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, int institutionId, String title, String? code, String? termLabel, String? academicYear, DateTime? termStartDate, DateTime? termEndDate, String? previousCourseId, DateTime? archivedAt, DateTime createdAt, DateTime updatedAt, List<LecturerEntity> lecturers
});




}
/// @nodoc
class __$CourseEntityCopyWithImpl<$Res>
    implements _$CourseEntityCopyWith<$Res> {
  __$CourseEntityCopyWithImpl(this._self, this._then);

  final _CourseEntity _self;
  final $Res Function(_CourseEntity) _then;

/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? institutionId = null,Object? title = null,Object? code = freezed,Object? termLabel = freezed,Object? academicYear = freezed,Object? termStartDate = freezed,Object? termEndDate = freezed,Object? previousCourseId = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? updatedAt = null,Object? lecturers = null,}) {
  return _then(_CourseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,termLabel: freezed == termLabel ? _self.termLabel : termLabel // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,termStartDate: freezed == termStartDate ? _self.termStartDate : termStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,termEndDate: freezed == termEndDate ? _self.termEndDate : termEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previousCourseId: freezed == previousCourseId ? _self.previousCourseId : previousCourseId // ignore: cast_nullable_to_non_nullable
as String?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lecturers: null == lecturers ? _self._lecturers : lecturers // ignore: cast_nullable_to_non_nullable
as List<LecturerEntity>,
  ));
}


}

// dart format on
