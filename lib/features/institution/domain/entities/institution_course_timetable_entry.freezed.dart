// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_course_timetable_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InstitutionCourseTimetableEntry implements DiagnosticableTreeMixin {

 int get id; int? get institution; String get courseCode; String get courseName; d.Weekday get dayOfWeek; DateTime get startTime; DateTime get endTime; String? get location; String? get room; String? get building; String? get instructor; bool get isRecurring; String? get recurrencePattern; String? get rawData; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of InstitutionCourseTimetableEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionCourseTimetableEntryCopyWith<InstitutionCourseTimetableEntry> get copyWith => _$InstitutionCourseTimetableEntryCopyWithImpl<InstitutionCourseTimetableEntry>(this as InstitutionCourseTimetableEntry, _$identity);

  /// Serializes this InstitutionCourseTimetableEntry to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InstitutionCourseTimetableEntry'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('institution', institution))..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('courseName', courseName))..add(DiagnosticsProperty('dayOfWeek', dayOfWeek))..add(DiagnosticsProperty('startTime', startTime))..add(DiagnosticsProperty('endTime', endTime))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('room', room))..add(DiagnosticsProperty('building', building))..add(DiagnosticsProperty('instructor', instructor))..add(DiagnosticsProperty('isRecurring', isRecurring))..add(DiagnosticsProperty('recurrencePattern', recurrencePattern))..add(DiagnosticsProperty('rawData', rawData))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionCourseTimetableEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.room, room) || other.room == room)&&(identical(other.building, building) || other.building == building)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrencePattern, recurrencePattern) || other.recurrencePattern == recurrencePattern)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,institution,courseCode,courseName,dayOfWeek,startTime,endTime,location,room,building,instructor,isRecurring,recurrencePattern,rawData,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InstitutionCourseTimetableEntry(id: $id, institution: $institution, courseCode: $courseCode, courseName: $courseName, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, location: $location, room: $room, building: $building, instructor: $instructor, isRecurring: $isRecurring, recurrencePattern: $recurrencePattern, rawData: $rawData, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $InstitutionCourseTimetableEntryCopyWith<$Res>  {
  factory $InstitutionCourseTimetableEntryCopyWith(InstitutionCourseTimetableEntry value, $Res Function(InstitutionCourseTimetableEntry) _then) = _$InstitutionCourseTimetableEntryCopyWithImpl;
@useResult
$Res call({
 int id, int? institution, String courseCode, String courseName, d.Weekday dayOfWeek, DateTime startTime, DateTime endTime, String? location, String? room, String? building, String? instructor, bool isRecurring, String? recurrencePattern, String? rawData, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$InstitutionCourseTimetableEntryCopyWithImpl<$Res>
    implements $InstitutionCourseTimetableEntryCopyWith<$Res> {
  _$InstitutionCourseTimetableEntryCopyWithImpl(this._self, this._then);

  final InstitutionCourseTimetableEntry _self;
  final $Res Function(InstitutionCourseTimetableEntry) _then;

/// Create a copy of InstitutionCourseTimetableEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? institution = freezed,Object? courseCode = null,Object? courseName = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? instructor = freezed,Object? isRecurring = null,Object? recurrencePattern = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int?,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as d.Weekday,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrencePattern: freezed == recurrencePattern ? _self.recurrencePattern : recurrencePattern // ignore: cast_nullable_to_non_nullable
as String?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionCourseTimetableEntry].
extension InstitutionCourseTimetableEntryPatterns on InstitutionCourseTimetableEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionCourseTimetableEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionCourseTimetableEntry value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionCourseTimetableEntry value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? institution,  String courseCode,  String courseName,  d.Weekday dayOfWeek,  DateTime startTime,  DateTime endTime,  String? location,  String? room,  String? building,  String? instructor,  bool isRecurring,  String? recurrencePattern,  String? rawData,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry() when $default != null:
return $default(_that.id,_that.institution,_that.courseCode,_that.courseName,_that.dayOfWeek,_that.startTime,_that.endTime,_that.location,_that.room,_that.building,_that.instructor,_that.isRecurring,_that.recurrencePattern,_that.rawData,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? institution,  String courseCode,  String courseName,  d.Weekday dayOfWeek,  DateTime startTime,  DateTime endTime,  String? location,  String? room,  String? building,  String? instructor,  bool isRecurring,  String? recurrencePattern,  String? rawData,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry():
return $default(_that.id,_that.institution,_that.courseCode,_that.courseName,_that.dayOfWeek,_that.startTime,_that.endTime,_that.location,_that.room,_that.building,_that.instructor,_that.isRecurring,_that.recurrencePattern,_that.rawData,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? institution,  String courseCode,  String courseName,  d.Weekday dayOfWeek,  DateTime startTime,  DateTime endTime,  String? location,  String? room,  String? building,  String? instructor,  bool isRecurring,  String? recurrencePattern,  String? rawData,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionCourseTimetableEntry() when $default != null:
return $default(_that.id,_that.institution,_that.courseCode,_that.courseName,_that.dayOfWeek,_that.startTime,_that.endTime,_that.location,_that.room,_that.building,_that.instructor,_that.isRecurring,_that.recurrencePattern,_that.rawData,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstitutionCourseTimetableEntry with DiagnosticableTreeMixin implements InstitutionCourseTimetableEntry {
  const _InstitutionCourseTimetableEntry({required this.id, this.institution, required this.courseCode, required this.courseName, required this.dayOfWeek, required this.startTime, required this.endTime, this.location, this.room, this.building, this.instructor, this.isRecurring = true, this.recurrencePattern, this.rawData, this.createdAt, this.updatedAt});
  factory _InstitutionCourseTimetableEntry.fromJson(Map<String, dynamic> json) => _$InstitutionCourseTimetableEntryFromJson(json);

@override final  int id;
@override final  int? institution;
@override final  String courseCode;
@override final  String courseName;
@override final  d.Weekday dayOfWeek;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  String? location;
@override final  String? room;
@override final  String? building;
@override final  String? instructor;
@override@JsonKey() final  bool isRecurring;
@override final  String? recurrencePattern;
@override final  String? rawData;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of InstitutionCourseTimetableEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionCourseTimetableEntryCopyWith<_InstitutionCourseTimetableEntry> get copyWith => __$InstitutionCourseTimetableEntryCopyWithImpl<_InstitutionCourseTimetableEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstitutionCourseTimetableEntryToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'InstitutionCourseTimetableEntry'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('institution', institution))..add(DiagnosticsProperty('courseCode', courseCode))..add(DiagnosticsProperty('courseName', courseName))..add(DiagnosticsProperty('dayOfWeek', dayOfWeek))..add(DiagnosticsProperty('startTime', startTime))..add(DiagnosticsProperty('endTime', endTime))..add(DiagnosticsProperty('location', location))..add(DiagnosticsProperty('room', room))..add(DiagnosticsProperty('building', building))..add(DiagnosticsProperty('instructor', instructor))..add(DiagnosticsProperty('isRecurring', isRecurring))..add(DiagnosticsProperty('recurrencePattern', recurrencePattern))..add(DiagnosticsProperty('rawData', rawData))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionCourseTimetableEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.courseCode, courseCode) || other.courseCode == courseCode)&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.room, room) || other.room == room)&&(identical(other.building, building) || other.building == building)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurrencePattern, recurrencePattern) || other.recurrencePattern == recurrencePattern)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,institution,courseCode,courseName,dayOfWeek,startTime,endTime,location,room,building,instructor,isRecurring,recurrencePattern,rawData,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'InstitutionCourseTimetableEntry(id: $id, institution: $institution, courseCode: $courseCode, courseName: $courseName, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, location: $location, room: $room, building: $building, instructor: $instructor, isRecurring: $isRecurring, recurrencePattern: $recurrencePattern, rawData: $rawData, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InstitutionCourseTimetableEntryCopyWith<$Res> implements $InstitutionCourseTimetableEntryCopyWith<$Res> {
  factory _$InstitutionCourseTimetableEntryCopyWith(_InstitutionCourseTimetableEntry value, $Res Function(_InstitutionCourseTimetableEntry) _then) = __$InstitutionCourseTimetableEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, int? institution, String courseCode, String courseName, d.Weekday dayOfWeek, DateTime startTime, DateTime endTime, String? location, String? room, String? building, String? instructor, bool isRecurring, String? recurrencePattern, String? rawData, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$InstitutionCourseTimetableEntryCopyWithImpl<$Res>
    implements _$InstitutionCourseTimetableEntryCopyWith<$Res> {
  __$InstitutionCourseTimetableEntryCopyWithImpl(this._self, this._then);

  final _InstitutionCourseTimetableEntry _self;
  final $Res Function(_InstitutionCourseTimetableEntry) _then;

/// Create a copy of InstitutionCourseTimetableEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? institution = freezed,Object? courseCode = null,Object? courseName = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? room = freezed,Object? building = freezed,Object? instructor = freezed,Object? isRecurring = null,Object? recurrencePattern = freezed,Object? rawData = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_InstitutionCourseTimetableEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int?,courseCode: null == courseCode ? _self.courseCode : courseCode // ignore: cast_nullable_to_non_nullable
as String,courseName: null == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as d.Weekday,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as String?,building: freezed == building ? _self.building : building // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurrencePattern: freezed == recurrencePattern ? _self.recurrencePattern : recurrencePattern // ignore: cast_nullable_to_non_nullable
as String?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
