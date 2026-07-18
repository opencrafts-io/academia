// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'magnet_course_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MagnetCourseScheduleDto implements DiagnosticableTreeMixin {

 dynamic get id;@JsonKey(name: 'server_id') dynamic get serverId;@JsonKey(name: 'user_id') dynamic get userId;@JsonKey(name: 'institution_id') dynamic get institutionId;@JsonKey(name: 'timetable_id') dynamic get timetableId; dynamic get rrule;@JsonKey(name: 'start_date') String? get startDate;@JsonKey(name: 'duration_minutes') dynamic get durationMinutes; dynamic get location; dynamic get room; dynamic get building;@JsonKey(name: 'is_synced') bool? get isSynced;@JsonKey(name: 'is_deleted') bool? get isDeleted;@JsonKey(name: 'last_updated') String? get lastUpdated;
/// Create a copy of MagnetCourseScheduleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MagnetCourseScheduleDtoCopyWith<MagnetCourseScheduleDto> get copyWith => _$MagnetCourseScheduleDtoCopyWithImpl<MagnetCourseScheduleDto>(this as MagnetCourseScheduleDto, _$identity);

  /// Serializes this MagnetCourseScheduleDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MagnetCourseScheduleDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('serverId', serverId))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('institutionId', institutionId))..add(DiagnosticsProperty('timetableId', timetableId))..add(DiagnosticsProperty('rrule', rrule))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('durationMinutes', durationMinutes))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('room', room))..add(DiagnosticsProperty('building', building))..add(DiagnosticsProperty('isSynced', isSynced))..add(DiagnosticsProperty('isDeleted', isDeleted))..add(DiagnosticsProperty('lastUpdated', lastUpdated));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnetCourseScheduleDto&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.serverId, serverId)&&const DeepCollectionEquality().equals(other.userId, userId)&&const DeepCollectionEquality().equals(other.institutionId, institutionId)&&const DeepCollectionEquality().equals(other.timetableId, timetableId)&&const DeepCollectionEquality().equals(other.rrule, rrule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&const DeepCollectionEquality().equals(other.durationMinutes, durationMinutes)&&const DeepCollectionEquality().equals(other.location, location)&&const DeepCollectionEquality().equals(other.room, room)&&const DeepCollectionEquality().equals(other.building, building)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(serverId),const DeepCollectionEquality().hash(userId),const DeepCollectionEquality().hash(institutionId),const DeepCollectionEquality().hash(timetableId),const DeepCollectionEquality().hash(rrule),startDate,const DeepCollectionEquality().hash(durationMinutes),const DeepCollectionEquality().hash(location),const DeepCollectionEquality().hash(room),const DeepCollectionEquality().hash(building),isSynced,isDeleted,lastUpdated);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MagnetCourseScheduleDto(id: $id, serverId: $serverId, userId: $userId, institutionId: $institutionId, timetableId: $timetableId, rrule: $rrule, startDate: $startDate, durationMinutes: $durationMinutes, location: $location, room: $room, building: $building, isSynced: $isSynced, isDeleted: $isDeleted, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $MagnetCourseScheduleDtoCopyWith<$Res>  {
  factory $MagnetCourseScheduleDtoCopyWith(MagnetCourseScheduleDto value, $Res Function(MagnetCourseScheduleDto) _then) = _$MagnetCourseScheduleDtoCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'server_id') dynamic serverId,@JsonKey(name: 'user_id') dynamic userId,@JsonKey(name: 'institution_id') dynamic institutionId,@JsonKey(name: 'timetable_id') dynamic timetableId, dynamic rrule,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'duration_minutes') dynamic durationMinutes, dynamic location, dynamic room, dynamic building,@JsonKey(name: 'is_synced') bool? isSynced,@JsonKey(name: 'is_deleted') bool? isDeleted,@JsonKey(name: 'last_updated') String? lastUpdated
});




}
/// @nodoc
class _$MagnetCourseScheduleDtoCopyWithImpl<$Res>
    implements $MagnetCourseScheduleDtoCopyWith<$Res> {
  _$MagnetCourseScheduleDtoCopyWithImpl(this._self, this._then);

  final MagnetCourseScheduleDto _self;
  final $Res Function(MagnetCourseScheduleDto) _then;

/// Create a copy of MagnetCourseScheduleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? serverId = freezed,Object? userId = freezed,Object? institutionId = freezed,Object? timetableId = freezed,Object? rrule = freezed,Object? startDate = freezed,Object? durationMinutes = freezed,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? isSynced = freezed,Object? isDeleted = freezed,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as dynamic,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as dynamic,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as dynamic,timetableId: freezed == timetableId ? _self.timetableId : timetableId // ignore: cast_nullable_to_non_nullable
as dynamic,rrule: freezed == rrule ? _self.rrule : rrule // ignore: cast_nullable_to_non_nullable
as dynamic,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as dynamic,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as dynamic,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as dynamic,isSynced: freezed == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MagnetCourseScheduleDto].
extension MagnetCourseScheduleDtoPatterns on MagnetCourseScheduleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MagnetCourseScheduleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MagnetCourseScheduleDto value)  $default,){
final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MagnetCourseScheduleDto value)?  $default,){
final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'user_id')  dynamic userId, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'timetable_id')  dynamic timetableId,  dynamic rrule, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'duration_minutes')  dynamic durationMinutes,  dynamic location,  dynamic room,  dynamic building, @JsonKey(name: 'is_synced')  bool? isSynced, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'last_updated')  String? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto() when $default != null:
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'user_id')  dynamic userId, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'timetable_id')  dynamic timetableId,  dynamic rrule, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'duration_minutes')  dynamic durationMinutes,  dynamic location,  dynamic room,  dynamic building, @JsonKey(name: 'is_synced')  bool? isSynced, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'last_updated')  String? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto():
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'user_id')  dynamic userId, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'timetable_id')  dynamic timetableId,  dynamic rrule, @JsonKey(name: 'start_date')  String? startDate, @JsonKey(name: 'duration_minutes')  dynamic durationMinutes,  dynamic location,  dynamic room,  dynamic building, @JsonKey(name: 'is_synced')  bool? isSynced, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'last_updated')  String? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _MagnetCourseScheduleDto() when $default != null:
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MagnetCourseScheduleDto with DiagnosticableTreeMixin implements MagnetCourseScheduleDto {
  const _MagnetCourseScheduleDto({this.id, @JsonKey(name: 'server_id') this.serverId, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'institution_id') this.institutionId, @JsonKey(name: 'timetable_id') this.timetableId, this.rrule, @JsonKey(name: 'start_date') this.startDate, @JsonKey(name: 'duration_minutes') this.durationMinutes, this.location, this.room, this.building, @JsonKey(name: 'is_synced') this.isSynced, @JsonKey(name: 'is_deleted') this.isDeleted, @JsonKey(name: 'last_updated') this.lastUpdated});
  factory _MagnetCourseScheduleDto.fromJson(Map<String, dynamic> json) => _$MagnetCourseScheduleDtoFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'server_id') final  dynamic serverId;
@override@JsonKey(name: 'user_id') final  dynamic userId;
@override@JsonKey(name: 'institution_id') final  dynamic institutionId;
@override@JsonKey(name: 'timetable_id') final  dynamic timetableId;
@override final  dynamic rrule;
@override@JsonKey(name: 'start_date') final  String? startDate;
@override@JsonKey(name: 'duration_minutes') final  dynamic durationMinutes;
@override final  dynamic location;
@override final  dynamic room;
@override final  dynamic building;
@override@JsonKey(name: 'is_synced') final  bool? isSynced;
@override@JsonKey(name: 'is_deleted') final  bool? isDeleted;
@override@JsonKey(name: 'last_updated') final  String? lastUpdated;

/// Create a copy of MagnetCourseScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MagnetCourseScheduleDtoCopyWith<_MagnetCourseScheduleDto> get copyWith => __$MagnetCourseScheduleDtoCopyWithImpl<_MagnetCourseScheduleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MagnetCourseScheduleDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MagnetCourseScheduleDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('serverId', serverId))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('institutionId', institutionId))..add(DiagnosticsProperty('timetableId', timetableId))..add(DiagnosticsProperty('rrule', rrule))..add(DiagnosticsProperty('startDate', startDate))..add(DiagnosticsProperty('durationMinutes', durationMinutes))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('room', room))..add(DiagnosticsProperty('building', building))..add(DiagnosticsProperty('isSynced', isSynced))..add(DiagnosticsProperty('isDeleted', isDeleted))..add(DiagnosticsProperty('lastUpdated', lastUpdated));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MagnetCourseScheduleDto&&const DeepCollectionEquality().equals(other.id, id)&&const DeepCollectionEquality().equals(other.serverId, serverId)&&const DeepCollectionEquality().equals(other.userId, userId)&&const DeepCollectionEquality().equals(other.institutionId, institutionId)&&const DeepCollectionEquality().equals(other.timetableId, timetableId)&&const DeepCollectionEquality().equals(other.rrule, rrule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&const DeepCollectionEquality().equals(other.durationMinutes, durationMinutes)&&const DeepCollectionEquality().equals(other.location, location)&&const DeepCollectionEquality().equals(other.room, room)&&const DeepCollectionEquality().equals(other.building, building)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(id),const DeepCollectionEquality().hash(serverId),const DeepCollectionEquality().hash(userId),const DeepCollectionEquality().hash(institutionId),const DeepCollectionEquality().hash(timetableId),const DeepCollectionEquality().hash(rrule),startDate,const DeepCollectionEquality().hash(durationMinutes),const DeepCollectionEquality().hash(location),const DeepCollectionEquality().hash(room),const DeepCollectionEquality().hash(building),isSynced,isDeleted,lastUpdated);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MagnetCourseScheduleDto(id: $id, serverId: $serverId, userId: $userId, institutionId: $institutionId, timetableId: $timetableId, rrule: $rrule, startDate: $startDate, durationMinutes: $durationMinutes, location: $location, room: $room, building: $building, isSynced: $isSynced, isDeleted: $isDeleted, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$MagnetCourseScheduleDtoCopyWith<$Res> implements $MagnetCourseScheduleDtoCopyWith<$Res> {
  factory _$MagnetCourseScheduleDtoCopyWith(_MagnetCourseScheduleDto value, $Res Function(_MagnetCourseScheduleDto) _then) = __$MagnetCourseScheduleDtoCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'server_id') dynamic serverId,@JsonKey(name: 'user_id') dynamic userId,@JsonKey(name: 'institution_id') dynamic institutionId,@JsonKey(name: 'timetable_id') dynamic timetableId, dynamic rrule,@JsonKey(name: 'start_date') String? startDate,@JsonKey(name: 'duration_minutes') dynamic durationMinutes, dynamic location, dynamic room, dynamic building,@JsonKey(name: 'is_synced') bool? isSynced,@JsonKey(name: 'is_deleted') bool? isDeleted,@JsonKey(name: 'last_updated') String? lastUpdated
});




}
/// @nodoc
class __$MagnetCourseScheduleDtoCopyWithImpl<$Res>
    implements _$MagnetCourseScheduleDtoCopyWith<$Res> {
  __$MagnetCourseScheduleDtoCopyWithImpl(this._self, this._then);

  final _MagnetCourseScheduleDto _self;
  final $Res Function(_MagnetCourseScheduleDto) _then;

/// Create a copy of MagnetCourseScheduleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? serverId = freezed,Object? userId = freezed,Object? institutionId = freezed,Object? timetableId = freezed,Object? rrule = freezed,Object? startDate = freezed,Object? durationMinutes = freezed,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? isSynced = freezed,Object? isDeleted = freezed,Object? lastUpdated = freezed,}) {
  return _then(_MagnetCourseScheduleDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as dynamic,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as dynamic,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as dynamic,timetableId: freezed == timetableId ? _self.timetableId : timetableId // ignore: cast_nullable_to_non_nullable
as dynamic,rrule: freezed == rrule ? _self.rrule : rrule // ignore: cast_nullable_to_non_nullable
as dynamic,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as dynamic,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as dynamic,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as dynamic,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as dynamic,isSynced: freezed == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MagnetCourseDto implements DiagnosticableTreeMixin {

 dynamic get id;@JsonKey(name: 'course_code') String? get courseCode;@JsonKey(name: 'course_name') String? get courseName; String? get instructor;@JsonKey(name: 'is_synced') bool? get isSynced; dynamic get color;@JsonKey(name: 'is_deleted') bool? get isDeleted;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'institution_id') dynamic get institutionId;@JsonKey(name: 'server_id') dynamic get serverId;@JsonKey(name: 'semester_id') dynamic get semesterId;@JsonKey(name: 'course_schedules') List<MagnetCourseScheduleDto> get courseSchedules;
/// Create a copy of MagnetCourseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MagnetCourseDtoCopyWith<MagnetCourseDto> get copyWith => _$MagnetCourseDtoCopyWithImpl<MagnetCourseDto>(this as MagnetCourseDto, _$identity);

  /// Serializes this MagnetCourseDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MagnetCourseDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('courseName', courseName))..add(DiagnosticsProperty('instructor', instructor))..add(DiagnosticsProperty('isSynced', isSynced))..add(DiagnosticsProperty('color', color))..add(DiagnosticsProperty('isDeleted', isDeleted))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('institutionId', institutionId))..add(DiagnosticsProperty('serverId', serverId))..add(DiagnosticsProperty('semesterId', semesterId))..add(DiagnosticsProperty('courseSchedules', courseSchedules));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnetCourseDto&&const DeepCollectionEquality().equals(other.id, id)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&const DeepCollectionEquality().equals(other.color, color)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.institutionId, institutionId)&&const DeepCollectionEquality().equals(other.serverId, serverId)&&const DeepCollectionEquality().equals(other.semesterId, semesterId)&&const DeepCollectionEquality().equals(other.courseSchedules, courseSchedules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(id),courseCode,courseName,instructor,isSynced,const DeepCollectionEquality().hash(color),isDeleted,createdAt,updatedAt,const DeepCollectionEquality().hash(institutionId),const DeepCollectionEquality().hash(serverId),const DeepCollectionEquality().hash(semesterId),const DeepCollectionEquality().hash(courseSchedules));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MagnetCourseDto(id: $id, courseCode: $courseCode, courseName: $courseName, instructor: $instructor, isSynced: $isSynced, color: $color, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, institutionId: $institutionId, serverId: $serverId, semesterId: $semesterId, courseSchedules: $courseSchedules)';
}


}

/// @nodoc
abstract mixin class $MagnetCourseDtoCopyWith<$Res>  {
  factory $MagnetCourseDtoCopyWith(MagnetCourseDto value, $Res Function(MagnetCourseDto) _then) = _$MagnetCourseDtoCopyWithImpl;
@useResult
$Res call({
 dynamic id,@JsonKey(name: 'course_code') String? courseCode,@JsonKey(name: 'course_name') String? courseName, String? instructor,@JsonKey(name: 'is_synced') bool? isSynced, dynamic color,@JsonKey(name: 'is_deleted') bool? isDeleted,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'institution_id') dynamic institutionId,@JsonKey(name: 'server_id') dynamic serverId,@JsonKey(name: 'semester_id') dynamic semesterId,@JsonKey(name: 'course_schedules') List<MagnetCourseScheduleDto> courseSchedules
});




}
/// @nodoc
class _$MagnetCourseDtoCopyWithImpl<$Res>
    implements $MagnetCourseDtoCopyWith<$Res> {
  _$MagnetCourseDtoCopyWithImpl(this._self, this._then);

  final MagnetCourseDto _self;
  final $Res Function(MagnetCourseDto) _then;

/// Create a copy of MagnetCourseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? courseCode = freezed,Object? courseName = freezed,Object? instructor = freezed,Object? isSynced = freezed,Object? color = freezed,Object? isDeleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? institutionId = freezed,Object? serverId = freezed,Object? semesterId = freezed,Object? courseSchedules = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isSynced: freezed == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as dynamic,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as dynamic,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as dynamic,semesterId: freezed == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as dynamic,courseSchedules: null == courseSchedules ? _self.courseSchedules : courseSchedules // ignore: cast_nullable_to_non_nullable
as List<MagnetCourseScheduleDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [MagnetCourseDto].
extension MagnetCourseDtoPatterns on MagnetCourseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MagnetCourseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MagnetCourseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MagnetCourseDto value)  $default,){
final _that = this;
switch (_that) {
case _MagnetCourseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MagnetCourseDto value)?  $default,){
final _that = this;
switch (_that) {
case _MagnetCourseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'course_code')  String? courseCode, @JsonKey(name: 'course_name')  String? courseName,  String? instructor, @JsonKey(name: 'is_synced')  bool? isSynced,  dynamic color, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'semester_id')  dynamic semesterId, @JsonKey(name: 'course_schedules')  List<MagnetCourseScheduleDto> courseSchedules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MagnetCourseDto() when $default != null:
return $default(_that.id,_that.courseCode,_that.courseName,_that.instructor,_that.isSynced,_that.color,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.institutionId,_that.serverId,_that.semesterId,_that.courseSchedules);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic id, @JsonKey(name: 'course_code')  String? courseCode, @JsonKey(name: 'course_name')  String? courseName,  String? instructor, @JsonKey(name: 'is_synced')  bool? isSynced,  dynamic color, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'semester_id')  dynamic semesterId, @JsonKey(name: 'course_schedules')  List<MagnetCourseScheduleDto> courseSchedules)  $default,) {final _that = this;
switch (_that) {
case _MagnetCourseDto():
return $default(_that.id,_that.courseCode,_that.courseName,_that.instructor,_that.isSynced,_that.color,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.institutionId,_that.serverId,_that.semesterId,_that.courseSchedules);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic id, @JsonKey(name: 'course_code')  String? courseCode, @JsonKey(name: 'course_name')  String? courseName,  String? instructor, @JsonKey(name: 'is_synced')  bool? isSynced,  dynamic color, @JsonKey(name: 'is_deleted')  bool? isDeleted, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'institution_id')  dynamic institutionId, @JsonKey(name: 'server_id')  dynamic serverId, @JsonKey(name: 'semester_id')  dynamic semesterId, @JsonKey(name: 'course_schedules')  List<MagnetCourseScheduleDto> courseSchedules)?  $default,) {final _that = this;
switch (_that) {
case _MagnetCourseDto() when $default != null:
return $default(_that.id,_that.courseCode,_that.courseName,_that.instructor,_that.isSynced,_that.color,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.institutionId,_that.serverId,_that.semesterId,_that.courseSchedules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MagnetCourseDto with DiagnosticableTreeMixin implements MagnetCourseDto {
  const _MagnetCourseDto({this.id, @JsonKey(name: 'course_code') this.courseCode, @JsonKey(name: 'course_name') this.courseName, this.instructor, @JsonKey(name: 'is_synced') this.isSynced, this.color, @JsonKey(name: 'is_deleted') this.isDeleted, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'institution_id') this.institutionId, @JsonKey(name: 'server_id') this.serverId, @JsonKey(name: 'semester_id') this.semesterId, @JsonKey(name: 'course_schedules') final  List<MagnetCourseScheduleDto> courseSchedules = const []}): _courseSchedules = courseSchedules;
  factory _MagnetCourseDto.fromJson(Map<String, dynamic> json) => _$MagnetCourseDtoFromJson(json);

@override final  dynamic id;
@override@JsonKey(name: 'course_code') final  String? courseCode;
@override@JsonKey(name: 'course_name') final  String? courseName;
@override final  String? instructor;
@override@JsonKey(name: 'is_synced') final  bool? isSynced;
@override final  dynamic color;
@override@JsonKey(name: 'is_deleted') final  bool? isDeleted;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'institution_id') final  dynamic institutionId;
@override@JsonKey(name: 'server_id') final  dynamic serverId;
@override@JsonKey(name: 'semester_id') final  dynamic semesterId;
 final  List<MagnetCourseScheduleDto> _courseSchedules;
@override@JsonKey(name: 'course_schedules') List<MagnetCourseScheduleDto> get courseSchedules {
  if (_courseSchedules is EqualUnmodifiableListView) return _courseSchedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courseSchedules);
}


/// Create a copy of MagnetCourseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MagnetCourseDtoCopyWith<_MagnetCourseDto> get copyWith => __$MagnetCourseDtoCopyWithImpl<_MagnetCourseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MagnetCourseDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MagnetCourseDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('courseName', courseName))..add(DiagnosticsProperty('instructor', instructor))..add(DiagnosticsProperty('isSynced', isSynced))..add(DiagnosticsProperty('color', color))..add(DiagnosticsProperty('isDeleted', isDeleted))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('institutionId', institutionId))..add(DiagnosticsProperty('serverId', serverId))..add(DiagnosticsProperty('semesterId', semesterId))..add(DiagnosticsProperty('courseSchedules', courseSchedules));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MagnetCourseDto&&const DeepCollectionEquality().equals(other.id, id)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&const DeepCollectionEquality().equals(other.color, color)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.institutionId, institutionId)&&const DeepCollectionEquality().equals(other.serverId, serverId)&&const DeepCollectionEquality().equals(other.semesterId, semesterId)&&const DeepCollectionEquality().equals(other._courseSchedules, _courseSchedules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(id),courseCode,courseName,instructor,isSynced,const DeepCollectionEquality().hash(color),isDeleted,createdAt,updatedAt,const DeepCollectionEquality().hash(institutionId),const DeepCollectionEquality().hash(serverId),const DeepCollectionEquality().hash(semesterId),const DeepCollectionEquality().hash(_courseSchedules));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MagnetCourseDto(id: $id, courseCode: $courseCode, courseName: $courseName, instructor: $instructor, isSynced: $isSynced, color: $color, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, institutionId: $institutionId, serverId: $serverId, semesterId: $semesterId, courseSchedules: $courseSchedules)';
}


}

/// @nodoc
abstract mixin class _$MagnetCourseDtoCopyWith<$Res> implements $MagnetCourseDtoCopyWith<$Res> {
  factory _$MagnetCourseDtoCopyWith(_MagnetCourseDto value, $Res Function(_MagnetCourseDto) _then) = __$MagnetCourseDtoCopyWithImpl;
@override @useResult
$Res call({
 dynamic id,@JsonKey(name: 'course_code') String? courseCode,@JsonKey(name: 'course_name') String? courseName, String? instructor,@JsonKey(name: 'is_synced') bool? isSynced, dynamic color,@JsonKey(name: 'is_deleted') bool? isDeleted,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'institution_id') dynamic institutionId,@JsonKey(name: 'server_id') dynamic serverId,@JsonKey(name: 'semester_id') dynamic semesterId,@JsonKey(name: 'course_schedules') List<MagnetCourseScheduleDto> courseSchedules
});




}
/// @nodoc
class __$MagnetCourseDtoCopyWithImpl<$Res>
    implements _$MagnetCourseDtoCopyWith<$Res> {
  __$MagnetCourseDtoCopyWithImpl(this._self, this._then);

  final _MagnetCourseDto _self;
  final $Res Function(_MagnetCourseDto) _then;

/// Create a copy of MagnetCourseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? courseCode = freezed,Object? courseName = freezed,Object? instructor = freezed,Object? isSynced = freezed,Object? color = freezed,Object? isDeleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? institutionId = freezed,Object? serverId = freezed,Object? semesterId = freezed,Object? courseSchedules = null,}) {
  return _then(_MagnetCourseDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as dynamic,courseCode: freezed == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String?,courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isSynced: freezed == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as dynamic,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as dynamic,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as dynamic,semesterId: freezed == semesterId ? _self.semesterId : semesterId // ignore: cast_nullable_to_non_nullable
as dynamic,courseSchedules: null == courseSchedules ? _self._courseSchedules : courseSchedules // ignore: cast_nullable_to_non_nullable
as List<MagnetCourseScheduleDto>,
  ));
}


}

// dart format on
