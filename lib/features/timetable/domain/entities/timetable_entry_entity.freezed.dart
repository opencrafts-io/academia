// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_entry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimetableEntryEntity {

/// Local UUID for offline-first identification
 String? get id;/// Unique ID from the remote database
 int? get serverId; String get userId; int get institutionId;/// References Course.id (UUID)
 String get courseId;/// References Timetable.id (UUID)
 String get timetableId;/// Recurrence Rule (e.g., "FREQ=WEEKLY;BYDAY=MO")
 String? get rrule;/// Anchor date for the start of the event/series
 DateTime get startDate;/// Length of the session in minutes
 int get durationMinutes; String? get location; String? get room; String? get building; bool get isSynced; bool get isDeleted; DateTime? get lastUpdated;
/// Create a copy of TimetableEntryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableEntryEntityCopyWith<TimetableEntryEntity> get copyWith => _$TimetableEntryEntityCopyWithImpl<TimetableEntryEntity>(this as TimetableEntryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableEntryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.timetableId, timetableId) || other.timetableId == timetableId)&&(identical(other.rrule, rrule) || other.rrule == rrule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.location, location) || other.location == location)&&(identical(other.room, room) || other.room == room)&&(identical(other.building, building) || other.building == building)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,id,serverId,userId,institutionId,courseId,timetableId,rrule,startDate,durationMinutes,location,room,building,isSynced,isDeleted,lastUpdated);

@override
String toString() {
  return 'TimetableEntryEntity(id: $id, serverId: $serverId, userId: $userId, institutionId: $institutionId, courseId: $courseId, timetableId: $timetableId, rrule: $rrule, startDate: $startDate, durationMinutes: $durationMinutes, location: $location, room: $room, building: $building, isSynced: $isSynced, isDeleted: $isDeleted, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $TimetableEntryEntityCopyWith<$Res>  {
  factory $TimetableEntryEntityCopyWith(TimetableEntryEntity value, $Res Function(TimetableEntryEntity) _then) = _$TimetableEntryEntityCopyWithImpl;
@useResult
$Res call({
 String? id, int? serverId, String userId, int institutionId, String courseId, String timetableId, String? rrule, DateTime startDate, int durationMinutes, String? location, String? room, String? building, bool isSynced, bool isDeleted, DateTime? lastUpdated
});




}
/// @nodoc
class _$TimetableEntryEntityCopyWithImpl<$Res>
    implements $TimetableEntryEntityCopyWith<$Res> {
  _$TimetableEntryEntityCopyWithImpl(this._self, this._then);

  final TimetableEntryEntity _self;
  final $Res Function(TimetableEntryEntity) _then;

/// Create a copy of TimetableEntryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? serverId = freezed,Object? userId = null,Object? institutionId = null,Object? courseId = null,Object? timetableId = null,Object? rrule = freezed,Object? startDate = null,Object? durationMinutes = null,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? isSynced = null,Object? isDeleted = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,timetableId: null == timetableId ? _self.timetableId : timetableId // ignore: cast_nullable_to_non_nullable
as String,rrule: freezed == rrule ? _self.rrule : rrule // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimetableEntryEntity].
extension TimetableEntryEntityPatterns on TimetableEntryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimetableEntryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimetableEntryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimetableEntryEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimetableEntryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimetableEntryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimetableEntryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? serverId,  String userId,  int institutionId,  String courseId,  String timetableId,  String? rrule,  DateTime startDate,  int durationMinutes,  String? location,  String? room,  String? building,  bool isSynced,  bool isDeleted,  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimetableEntryEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.courseId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? serverId,  String userId,  int institutionId,  String courseId,  String timetableId,  String? rrule,  DateTime startDate,  int durationMinutes,  String? location,  String? room,  String? building,  bool isSynced,  bool isDeleted,  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _TimetableEntryEntity():
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.courseId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? serverId,  String userId,  int institutionId,  String courseId,  String timetableId,  String? rrule,  DateTime startDate,  int durationMinutes,  String? location,  String? room,  String? building,  bool isSynced,  bool isDeleted,  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _TimetableEntryEntity() when $default != null:
return $default(_that.id,_that.serverId,_that.userId,_that.institutionId,_that.courseId,_that.timetableId,_that.rrule,_that.startDate,_that.durationMinutes,_that.location,_that.room,_that.building,_that.isSynced,_that.isDeleted,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _TimetableEntryEntity implements TimetableEntryEntity {
  const _TimetableEntryEntity({this.id, this.serverId, required this.userId, required this.institutionId, required this.courseId, required this.timetableId, this.rrule, required this.startDate, required this.durationMinutes, this.location, this.room, this.building, this.isSynced = false, this.isDeleted = false, this.lastUpdated});
  

/// Local UUID for offline-first identification
@override final  String? id;
/// Unique ID from the remote database
@override final  int? serverId;
@override final  String userId;
@override final  int institutionId;
/// References Course.id (UUID)
@override final  String courseId;
/// References Timetable.id (UUID)
@override final  String timetableId;
/// Recurrence Rule (e.g., "FREQ=WEEKLY;BYDAY=MO")
@override final  String? rrule;
/// Anchor date for the start of the event/series
@override final  DateTime startDate;
/// Length of the session in minutes
@override final  int durationMinutes;
@override final  String? location;
@override final  String? room;
@override final  String? building;
@override@JsonKey() final  bool isSynced;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? lastUpdated;

/// Create a copy of TimetableEntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableEntryEntityCopyWith<_TimetableEntryEntity> get copyWith => __$TimetableEntryEntityCopyWithImpl<_TimetableEntryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableEntryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.courseId, courseId) || other.courseId == courseId)&&(identical(other.timetableId, timetableId) || other.timetableId == timetableId)&&(identical(other.rrule, rrule) || other.rrule == rrule)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.location, location) || other.location == location)&&(identical(other.room, room) || other.room == room)&&(identical(other.building, building) || other.building == building)&&(identical(other.isSynced, isSynced) || other.isSynced == isSynced)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,id,serverId,userId,institutionId,courseId,timetableId,rrule,startDate,durationMinutes,location,room,building,isSynced,isDeleted,lastUpdated);

@override
String toString() {
  return 'TimetableEntryEntity(id: $id, serverId: $serverId, userId: $userId, institutionId: $institutionId, courseId: $courseId, timetableId: $timetableId, rrule: $rrule, startDate: $startDate, durationMinutes: $durationMinutes, location: $location, room: $room, building: $building, isSynced: $isSynced, isDeleted: $isDeleted, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$TimetableEntryEntityCopyWith<$Res> implements $TimetableEntryEntityCopyWith<$Res> {
  factory _$TimetableEntryEntityCopyWith(_TimetableEntryEntity value, $Res Function(_TimetableEntryEntity) _then) = __$TimetableEntryEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? serverId, String userId, int institutionId, String courseId, String timetableId, String? rrule, DateTime startDate, int durationMinutes, String? location, String? room, String? building, bool isSynced, bool isDeleted, DateTime? lastUpdated
});




}
/// @nodoc
class __$TimetableEntryEntityCopyWithImpl<$Res>
    implements _$TimetableEntryEntityCopyWith<$Res> {
  __$TimetableEntryEntityCopyWithImpl(this._self, this._then);

  final _TimetableEntryEntity _self;
  final $Res Function(_TimetableEntryEntity) _then;

/// Create a copy of TimetableEntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? serverId = freezed,Object? userId = null,Object? institutionId = null,Object? courseId = null,Object? timetableId = null,Object? rrule = freezed,Object? startDate = null,Object? durationMinutes = null,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? isSynced = null,Object? isDeleted = null,Object? lastUpdated = freezed,}) {
  return _then(_TimetableEntryEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as int?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,courseId: null == courseId ? _self.courseId : courseId // ignore: cast_nullable_to_non_nullable
as String,timetableId: null == timetableId ? _self.timetableId : timetableId // ignore: cast_nullable_to_non_nullable
as String,rrule: freezed == rrule ? _self.rrule : rrule // ignore: cast_nullable_to_non_nullable
as String?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String?,isSynced: null == isSynced ? _self.isSynced : isSynced // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
