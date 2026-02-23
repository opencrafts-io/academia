// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseEntity {

/// Local UUID for offline-first identification
 String? get id;/// Unique ID from the remote database
 int? get serverId;/// Reference to the Institution ID
 int? get institutionId;/// Reference to the Semester ID
 int? get semesterId; String get courseCode; String get courseName; String get instructor;/// UI color for the course, defaults to a specific dark hex if null
 Color? get color; bool get isSynced; bool get isDeleted; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseEntityCopyWith<CourseEntity> get copyWith => _$CourseEntityCopyWithImpl<CourseEntity>(this as CourseEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.color, color) || other.color == color)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,serverId,institutionId,semesterId,courseCode,courseName,instructor,color,isSynced,isDeleted,createdAt,updatedAt);

@override
String toString() {
  return 'CourseEntity(id: $id, serverId: $serverId, institutionId: $institutionId, semesterId: $semesterId, courseCode: $courseCode, courseName: $courseName, instructor: $instructor, color: $color, isSynced: $isSynced, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourseEntityCopyWith<$Res>  {
  factory $CourseEntityCopyWith(CourseEntity value, $Res Function(CourseEntity) _then) = _$CourseEntityCopyWithImpl;
@useResult
$Res call({
 String? id, int? serverId, int? institutionId, int? semesterId, String courseCode, String courseName, String instructor, Color? color, bool isSynced, bool isDeleted, DateTime? createdAt, DateTime? updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? serverId = freezed,Object? institutionId = freezed,Object? semesterId = freezed,Object? courseCode = null,Object? courseName = null,Object? instructor = null,Object? color = freezed,Object? isSynced = null,Object? isDeleted = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,semesterId: freezed == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as int?,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? serverId,  int? institutionId,  int? semesterId,  String courseCode,  String courseName,  String instructor,  Color? color,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.institutionId,_that.semesterId,_that.courseCode,_that.courseName,_that.instructor,_that.color,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? serverId,  int? institutionId,  int? semesterId,  String courseCode,  String courseName,  String instructor,  Color? color,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CourseEntity():
return $default(_that.id,_that.serverId,_that.institutionId,_that.semesterId,_that.courseCode,_that.courseName,_that.instructor,_that.color,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? serverId,  int? institutionId,  int? semesterId,  String courseCode,  String courseName,  String instructor,  Color? color,  bool isSynced,  bool isDeleted,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CourseEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.institutionId,_that.semesterId,_that.courseCode,_that.courseName,_that.instructor,_that.color,_that.isSynced,_that.isDeleted,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CourseEntity implements CourseEntity {
  const _CourseEntity({this.id, this.serverId, this.institutionId, this.semesterId, required this.courseCode, required this.courseName, required this.instructor, this.color = const Color(0x1E1E2EFF), this.isSynced = false, this.isDeleted = false, this.createdAt, this.updatedAt});
  

/// Local UUID for offline-first identification
@override final  String? id;
/// Unique ID from the remote database
@override final  int? serverId;
/// Reference to the Institution ID
@override final  int? institutionId;
/// Reference to the Semester ID
@override final  int? semesterId;
@override final  String courseCode;
@override final  String courseName;
@override final  String instructor;
/// UI color for the course, defaults to a specific dark hex if null
@override@JsonKey() final  Color? color;
@override@JsonKey() final  bool isSynced;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CourseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseEntityCopyWith<_CourseEntity> get copyWith => __$CourseEntityCopyWithImpl<_CourseEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.semesterId, semesterId) || other.semesterId == semesterId)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.color, color) || other.color == color)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,serverId,institutionId,semesterId,courseCode,courseName,instructor,color,isSynced,isDeleted,createdAt,updatedAt);

@override
String toString() {
  return 'CourseEntity(id: $id, serverId: $serverId, institutionId: $institutionId, semesterId: $semesterId, courseCode: $courseCode, courseName: $courseName, instructor: $instructor, color: $color, isSynced: $isSynced, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourseEntityCopyWith<$Res> implements $CourseEntityCopyWith<$Res> {
  factory _$CourseEntityCopyWith(_CourseEntity value, $Res Function(_CourseEntity) _then) = __$CourseEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? serverId, int? institutionId, int? semesterId, String courseCode, String courseName, String instructor, Color? color, bool isSynced, bool isDeleted, DateTime? createdAt, DateTime? updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? serverId = freezed,Object? institutionId = freezed,Object? semesterId = freezed,Object? courseCode = null,Object? courseName = null,Object? instructor = null,Object? color = freezed,Object? isSynced = null,Object? isDeleted = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CourseEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,semesterId: freezed == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as int?,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,instructor: null == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
