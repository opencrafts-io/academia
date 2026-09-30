// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_entry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleEntryEntity {

 String get id; String? get serverId; String get idempotencyKey; String get syncStatus; String? get lastSyncError; String get studentCourseId; String get dayOfWeek; String get startTime; String get endTime; String? get venue; String? get campus; String? get section; String? get label; String? get color; bool get isRecurring; DateTime? get specificDate; DateTime get createdAt; DateTime get updatedAt; String? get courseTitle; String? get courseCode; String? get courseColor;
/// Create a copy of ScheduleEntryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleEntryEntityCopyWith<ScheduleEntryEntity> get copyWith => _$ScheduleEntryEntityCopyWithImpl<ScheduleEntryEntity>(this as ScheduleEntryEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScheduleEntryEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleEntryEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.serverId, _this.serverId) || other.serverId == _this.serverId)&&(identical(other.idempotencyKey, _this.idempotencyKey) || other.idempotencyKey == _this.idempotencyKey)&&(identical(other.syncStatus, _this.syncStatus) || other.syncStatus == _this.syncStatus)&&(identical(other.lastSyncError, _this.lastSyncError) || other.lastSyncError == _this.lastSyncError)&&(identical(other.studentCourseId, _this.studentCourseId) || other.studentCourseId == _this.studentCourseId)&&(identical(other.dayOfWeek, _this.dayOfWeek) || other.dayOfWeek == _this.dayOfWeek)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.endTime, _this.endTime) || other.endTime == _this.endTime)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.campus, _this.campus) || other.campus == _this.campus)&&(identical(other.section, _this.section) || other.section == _this.section)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.isRecurring, _this.isRecurring) || other.isRecurring == _this.isRecurring)&&(identical(other.specificDate, _this.specificDate) || other.specificDate == _this.specificDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.courseTitle, _this.courseTitle) || other.courseTitle == _this.courseTitle)&&(identical(other.courseCode, _this.courseCode) || other.courseCode == _this.courseCode)&&(identical(other.courseColor, _this.courseColor) || other.courseColor == _this.courseColor));
}


@override
int get hashCode {
  final _this = this as ScheduleEntryEntity;
  return Object.hashAll([runtimeType,_this.id,_this.serverId,_this.idempotencyKey,_this.syncStatus,_this.lastSyncError,_this.studentCourseId,_this.dayOfWeek,_this.startTime,_this.endTime,_this.venue,_this.campus,_this.section,_this.label,_this.color,_this.isRecurring,_this.specificDate,_this.createdAt,_this.updatedAt,_this.courseTitle,_this.courseCode,_this.courseColor]);
}

@override
String toString() {
  final _this = this as ScheduleEntryEntity;
  return 'ScheduleEntryEntity(id: ${_this.id}, serverId: ${_this.serverId}, idempotencyKey: ${_this.idempotencyKey}, syncStatus: ${_this.syncStatus}, lastSyncError: ${_this.lastSyncError}, studentCourseId: ${_this.studentCourseId}, dayOfWeek: ${_this.dayOfWeek}, startTime: ${_this.startTime}, endTime: ${_this.endTime}, venue: ${_this.venue}, campus: ${_this.campus}, section: ${_this.section}, label: ${_this.label}, color: ${_this.color}, isRecurring: ${_this.isRecurring}, specificDate: ${_this.specificDate}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, courseTitle: ${_this.courseTitle}, courseCode: ${_this.courseCode}, courseColor: ${_this.courseColor})';
}


}

/// @nodoc
abstract mixin class $ScheduleEntryEntityCopyWith<$Res>  {
  factory $ScheduleEntryEntityCopyWith(ScheduleEntryEntity value, $Res Function(ScheduleEntryEntity) _then) = _$ScheduleEntryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? serverId, String idempotencyKey, String syncStatus, String? lastSyncError, String studentCourseId, String dayOfWeek, String startTime, String endTime, String? venue, String? campus, String? section, String? label, String? color, bool isRecurring, DateTime? specificDate, DateTime createdAt, DateTime updatedAt, String? courseTitle, String? courseCode, String? courseColor
});




}
/// @nodoc
class _$ScheduleEntryEntityCopyWithImpl<$Res>
    implements $ScheduleEntryEntityCopyWith<$Res> {
  _$ScheduleEntryEntityCopyWithImpl(this._self, this._then);

  final ScheduleEntryEntity _self;
  final $Res Function(ScheduleEntryEntity) _then;

/// Create a copy of ScheduleEntryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = freezed,Object? idempotencyKey = null,Object? syncStatus = null,Object? lastSyncError = freezed,Object? studentCourseId = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? venue = freezed,Object? campus = freezed,Object? section = freezed,Object? label = freezed,Object? color = freezed,Object? isRecurring = null,Object? specificDate = freezed,Object? createdAt = null,Object? updatedAt = null,Object? courseTitle = freezed,Object? courseCode = freezed,Object? courseColor = freezed,}) {
  return _then(ScheduleEntryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String,lastSyncError: freezed == lastSyncError ? _self.lastSyncError : lastSyncError // ignore: cast_nullable_to_non_nullable
as String?,studentCourseId: null == studentCourseId ? _self.studentCourseId : studentCourseId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,courseTitle: freezed == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,courseColor: freezed == courseColor ? _self.courseColor : courseColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleEntryEntity].
extension ScheduleEntryEntityPatterns on ScheduleEntryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleEntryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleEntryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleEntryEntity value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleEntryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleEntryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleEntryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? serverId,  String idempotencyKey,  String syncStatus,  String? lastSyncError,  String studentCourseId,  String dayOfWeek,  String startTime,  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color,  bool isRecurring,  DateTime? specificDate,  DateTime createdAt,  DateTime updatedAt,  String? courseTitle,  String? courseCode,  String? courseColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleEntryEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.idempotencyKey,_that.syncStatus,_that.lastSyncError,_that.studentCourseId,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.courseTitle,_that.courseCode,_that.courseColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? serverId,  String idempotencyKey,  String syncStatus,  String? lastSyncError,  String studentCourseId,  String dayOfWeek,  String startTime,  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color,  bool isRecurring,  DateTime? specificDate,  DateTime createdAt,  DateTime updatedAt,  String? courseTitle,  String? courseCode,  String? courseColor)  $default,) {final _that = this;
switch (_that) {
case _ScheduleEntryEntity():
return $default(_that.id,_that.serverId,_that.idempotencyKey,_that.syncStatus,_that.lastSyncError,_that.studentCourseId,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.courseTitle,_that.courseCode,_that.courseColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? serverId,  String idempotencyKey,  String syncStatus,  String? lastSyncError,  String studentCourseId,  String dayOfWeek,  String startTime,  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color,  bool isRecurring,  DateTime? specificDate,  DateTime createdAt,  DateTime updatedAt,  String? courseTitle,  String? courseCode,  String? courseColor)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleEntryEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.idempotencyKey,_that.syncStatus,_that.lastSyncError,_that.studentCourseId,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.courseTitle,_that.courseCode,_that.courseColor);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleEntryEntity implements ScheduleEntryEntity {
  const _ScheduleEntryEntity({required this.id, this.serverId, this.idempotencyKey = '', this.syncStatus = 'synced', this.lastSyncError, required this.studentCourseId, required this.dayOfWeek, required this.startTime, required this.endTime, this.venue, this.campus, this.section, this.label, this.color, this.isRecurring = true, this.specificDate, required this.createdAt, required this.updatedAt, this.courseTitle, this.courseCode, this.courseColor});


@override final  String id;
@override final  String? serverId;
@override@JsonKey() final  String idempotencyKey;
@override@JsonKey() final  String syncStatus;
@override final  String? lastSyncError;
@override final  String studentCourseId;
@override final  String dayOfWeek;
@override final  String startTime;
@override final  String endTime;
@override final  String? venue;
@override final  String? campus;
@override final  String? section;
@override final  String? label;
@override final  String? color;
@override@JsonKey() final  bool isRecurring;
@override final  DateTime? specificDate;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? courseTitle;
@override final  String? courseCode;
@override final  String? courseColor;

/// Create a copy of ScheduleEntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleEntryEntityCopyWith<_ScheduleEntryEntity> get copyWith => __$ScheduleEntryEntityCopyWithImpl<_ScheduleEntryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleEntryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.lastSyncError, lastSyncError) || other.lastSyncError == lastSyncError)&&(identical(other.studentCourseId, studentCourseId) || other.studentCourseId == studentCourseId)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.section, section) || other.section == section)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.courseTitle, courseTitle) || other.courseTitle == courseTitle)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseColor, courseColor) || other.courseColor == courseColor));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,id,serverId,idempotencyKey,syncStatus,lastSyncError,studentCourseId,dayOfWeek,startTime,endTime,venue,campus,section,label,color,isRecurring,specificDate,createdAt,updatedAt,courseTitle,courseCode,courseColor]);
}

@override
String toString() {
    return 'ScheduleEntryEntity(id: $id, serverId: $serverId, idempotencyKey: $idempotencyKey, syncStatus: $syncStatus, lastSyncError: $lastSyncError, studentCourseId: $studentCourseId, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, venue: $venue, campus: $campus, section: $section, label: $label, color: $color, isRecurring: $isRecurring, specificDate: $specificDate, createdAt: $createdAt, updatedAt: $updatedAt, courseTitle: $courseTitle, courseCode: $courseCode, courseColor: $courseColor)';
}


}

/// @nodoc
abstract mixin class _$ScheduleEntryEntityCopyWith<$Res> implements $ScheduleEntryEntityCopyWith<$Res> {
  factory _$ScheduleEntryEntityCopyWith(_ScheduleEntryEntity value, $Res Function(_ScheduleEntryEntity) _then) = __$ScheduleEntryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? serverId, String idempotencyKey, String syncStatus, String? lastSyncError, String studentCourseId, String dayOfWeek, String startTime, String endTime, String? venue, String? campus, String? section, String? label, String? color, bool isRecurring, DateTime? specificDate, DateTime createdAt, DateTime updatedAt, String? courseTitle, String? courseCode, String? courseColor
});




}
/// @nodoc
class __$ScheduleEntryEntityCopyWithImpl<$Res>
    implements _$ScheduleEntryEntityCopyWith<$Res> {
  __$ScheduleEntryEntityCopyWithImpl(this._self, this._then);

  final _ScheduleEntryEntity _self;
  final $Res Function(_ScheduleEntryEntity) _then;

/// Create a copy of ScheduleEntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = freezed,Object? idempotencyKey = null,Object? syncStatus = null,Object? lastSyncError = freezed,Object? studentCourseId = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? venue = freezed,Object? campus = freezed,Object? section = freezed,Object? label = freezed,Object? color = freezed,Object? isRecurring = null,Object? specificDate = freezed,Object? createdAt = null,Object? updatedAt = null,Object? courseTitle = freezed,Object? courseCode = freezed,Object? courseColor = freezed,}) {
  return _then(_ScheduleEntryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as String,lastSyncError: freezed == lastSyncError ? _self.lastSyncError : lastSyncError // ignore: cast_nullable_to_non_nullable
as String?,studentCourseId: null == studentCourseId ? _self.studentCourseId : studentCourseId // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,campus: freezed == campus ? _self.campus : campus // ignore: cast_nullable_to_non_nullable
as String?,section: freezed == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,specificDate: freezed == specificDate ? _self.specificDate : specificDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,courseTitle: freezed == courseTitle ? _self.courseTitle : courseTitle // ignore: cast_nullable_to_non_nullable
as String?,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,courseColor: freezed == courseColor ? _self.courseColor : courseColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
