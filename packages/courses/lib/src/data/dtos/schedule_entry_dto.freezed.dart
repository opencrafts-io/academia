// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduleEntryDto {

 String get id;@JsonKey(name: 'day_of_week') String get dayOfWeek;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String get endTime; String? get venue; String? get campus; String? get section; String? get label; String? get color;@JsonKey(name: 'is_recurring') bool get isRecurring;@JsonKey(name: 'specific_date') DateTime? get specificDate;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt; ScheduleCourseDto? get course;
/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleEntryDtoCopyWith<ScheduleEntryDto> get copyWith => _$ScheduleEntryDtoCopyWithImpl<ScheduleEntryDto>(this as ScheduleEntryDto, _$identity);

  /// Serializes this ScheduleEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ScheduleEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleEntryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.dayOfWeek, _this.dayOfWeek) || other.dayOfWeek == _this.dayOfWeek)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.endTime, _this.endTime) || other.endTime == _this.endTime)&&(identical(other.venue, _this.venue) || other.venue == _this.venue)&&(identical(other.campus, _this.campus) || other.campus == _this.campus)&&(identical(other.section, _this.section) || other.section == _this.section)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.isRecurring, _this.isRecurring) || other.isRecurring == _this.isRecurring)&&(identical(other.specificDate, _this.specificDate) || other.specificDate == _this.specificDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.course, _this.course) || other.course == _this.course));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ScheduleEntryDto;
  return Object.hash(runtimeType,_this.id,_this.dayOfWeek,_this.startTime,_this.endTime,_this.venue,_this.campus,_this.section,_this.label,_this.color,_this.isRecurring,_this.specificDate,_this.createdAt,_this.updatedAt,_this.course);
}

@override
String toString() {
  final _this = this as ScheduleEntryDto;
  return 'ScheduleEntryDto(id: ${_this.id}, dayOfWeek: ${_this.dayOfWeek}, startTime: ${_this.startTime}, endTime: ${_this.endTime}, venue: ${_this.venue}, campus: ${_this.campus}, section: ${_this.section}, label: ${_this.label}, color: ${_this.color}, isRecurring: ${_this.isRecurring}, specificDate: ${_this.specificDate}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, course: ${_this.course})';
}


}

/// @nodoc
abstract mixin class $ScheduleEntryDtoCopyWith<$Res>  {
  factory $ScheduleEntryDtoCopyWith(ScheduleEntryDto value, $Res Function(ScheduleEntryDto) _then) = _$ScheduleEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'day_of_week') String dayOfWeek,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime, String? venue, String? campus, String? section, String? label, String? color,@JsonKey(name: 'is_recurring') bool isRecurring,@JsonKey(name: 'specific_date') DateTime? specificDate,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, ScheduleCourseDto? course
});


$ScheduleCourseDtoCopyWith<$Res>? get course;

}
/// @nodoc
class _$ScheduleEntryDtoCopyWithImpl<$Res>
    implements $ScheduleEntryDtoCopyWith<$Res> {
  _$ScheduleEntryDtoCopyWithImpl(this._self, this._then);

  final ScheduleEntryDto _self;
  final $Res Function(ScheduleEntryDto) _then;

/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? venue = freezed,Object? campus = freezed,Object? section = freezed,Object? label = freezed,Object? color = freezed,Object? isRecurring = null,Object? specificDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? course = freezed,}) {
  return _then(ScheduleEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
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
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as ScheduleCourseDto?,
  ));
}
/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleCourseDtoCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $ScheduleCourseDtoCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScheduleEntryDto].
extension ScheduleEntryDtoPatterns on ScheduleEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'specific_date')  DateTime? specificDate, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  ScheduleCourseDto? course)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleEntryDto() when $default != null:
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.course);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'specific_date')  DateTime? specificDate, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  ScheduleCourseDto? course)  $default,) {final _that = this;
switch (_that) {
case _ScheduleEntryDto():
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.course);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'day_of_week')  String dayOfWeek, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String endTime,  String? venue,  String? campus,  String? section,  String? label,  String? color, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'specific_date')  DateTime? specificDate, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt,  ScheduleCourseDto? course)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleEntryDto() when $default != null:
return $default(_that.id,_that.dayOfWeek,_that.startTime,_that.endTime,_that.venue,_that.campus,_that.section,_that.label,_that.color,_that.isRecurring,_that.specificDate,_that.createdAt,_that.updatedAt,_that.course);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleEntryDto implements ScheduleEntryDto {
  const _ScheduleEntryDto({this.id = '', @JsonKey(name: 'day_of_week') required this.dayOfWeek, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') required this.endTime, this.venue, this.campus, this.section, this.label, this.color, @JsonKey(name: 'is_recurring') this.isRecurring = true, @JsonKey(name: 'specific_date') this.specificDate, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, this.course});
  factory _ScheduleEntryDto.fromJson(Map<String, dynamic> json) => _$ScheduleEntryDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey(name: 'day_of_week') final  String dayOfWeek;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String endTime;
@override final  String? venue;
@override final  String? campus;
@override final  String? section;
@override final  String? label;
@override final  String? color;
@override@JsonKey(name: 'is_recurring') final  bool isRecurring;
@override@JsonKey(name: 'specific_date') final  DateTime? specificDate;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override final  ScheduleCourseDto? course;

/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleEntryDtoCopyWith<_ScheduleEntryDto> get copyWith => __$ScheduleEntryDtoCopyWithImpl<_ScheduleEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.campus, campus) || other.campus == campus)&&(identical(other.section, section) || other.section == section)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.specificDate, specificDate) || other.specificDate == specificDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.course, course) || other.course == course));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,dayOfWeek,startTime,endTime,venue,campus,section,label,color,isRecurring,specificDate,createdAt,updatedAt,course);
}

@override
String toString() {
    return 'ScheduleEntryDto(id: $id, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, venue: $venue, campus: $campus, section: $section, label: $label, color: $color, isRecurring: $isRecurring, specificDate: $specificDate, createdAt: $createdAt, updatedAt: $updatedAt, course: $course)';
}


}

/// @nodoc
abstract mixin class _$ScheduleEntryDtoCopyWith<$Res> implements $ScheduleEntryDtoCopyWith<$Res> {
  factory _$ScheduleEntryDtoCopyWith(_ScheduleEntryDto value, $Res Function(_ScheduleEntryDto) _then) = __$ScheduleEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'day_of_week') String dayOfWeek,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String endTime, String? venue, String? campus, String? section, String? label, String? color,@JsonKey(name: 'is_recurring') bool isRecurring,@JsonKey(name: 'specific_date') DateTime? specificDate,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt, ScheduleCourseDto? course
});


@override $ScheduleCourseDtoCopyWith<$Res>? get course;

}
/// @nodoc
class __$ScheduleEntryDtoCopyWithImpl<$Res>
    implements _$ScheduleEntryDtoCopyWith<$Res> {
  __$ScheduleEntryDtoCopyWithImpl(this._self, this._then);

  final _ScheduleEntryDto _self;
  final $Res Function(_ScheduleEntryDto) _then;

/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dayOfWeek = null,Object? startTime = null,Object? endTime = null,Object? venue = freezed,Object? campus = freezed,Object? section = freezed,Object? label = freezed,Object? color = freezed,Object? isRecurring = null,Object? specificDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? course = freezed,}) {
  return _then(_ScheduleEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
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
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as ScheduleCourseDto?,
  ));
}

/// Create a copy of ScheduleEntryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleCourseDtoCopyWith<$Res>? get course {
    if (_self.course == null) {
    return null;
  }

  return $ScheduleCourseDtoCopyWith<$Res>(_self.course!, (value) {
    return _then(_self.copyWith(course: value));
  });
}
}


/// @nodoc
mixin _$ScheduleCourseDto {

 String get id; String get title; String? get code; String? get color;
/// Create a copy of ScheduleCourseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCourseDtoCopyWith<ScheduleCourseDto> get copyWith => _$ScheduleCourseDtoCopyWithImpl<ScheduleCourseDto>(this as ScheduleCourseDto, _$identity);

  /// Serializes this ScheduleCourseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ScheduleCourseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleCourseDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ScheduleCourseDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.code,_this.color);
}

@override
String toString() {
  final _this = this as ScheduleCourseDto;
  return 'ScheduleCourseDto(id: ${_this.id}, title: ${_this.title}, code: ${_this.code}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $ScheduleCourseDtoCopyWith<$Res>  {
  factory $ScheduleCourseDtoCopyWith(ScheduleCourseDto value, $Res Function(ScheduleCourseDto) _then) = _$ScheduleCourseDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? code, String? color
});




}
/// @nodoc
class _$ScheduleCourseDtoCopyWithImpl<$Res>
    implements $ScheduleCourseDtoCopyWith<$Res> {
  _$ScheduleCourseDtoCopyWithImpl(this._self, this._then);

  final ScheduleCourseDto _self;
  final $Res Function(ScheduleCourseDto) _then;

/// Create a copy of ScheduleCourseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? color = freezed,}) {
  return _then(ScheduleCourseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleCourseDto].
extension ScheduleCourseDtoPatterns on ScheduleCourseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleCourseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleCourseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleCourseDto value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleCourseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleCourseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleCourseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleCourseDto() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? code,  String? color)  $default,) {final _that = this;
switch (_that) {
case _ScheduleCourseDto():
return $default(_that.id,_that.title,_that.code,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? code,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleCourseDto() when $default != null:
return $default(_that.id,_that.title,_that.code,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleCourseDto implements ScheduleCourseDto {
  const _ScheduleCourseDto({required this.id, required this.title, this.code, this.color});
  factory _ScheduleCourseDto.fromJson(Map<String, dynamic> json) => _$ScheduleCourseDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? code;
@override final  String? color;

/// Create a copy of ScheduleCourseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCourseDtoCopyWith<_ScheduleCourseDto> get copyWith => __$ScheduleCourseDtoCopyWithImpl<_ScheduleCourseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleCourseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleCourseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.code, code) || other.code == code)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,code,color);
}

@override
String toString() {
    return 'ScheduleCourseDto(id: $id, title: $title, code: $code, color: $color)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCourseDtoCopyWith<$Res> implements $ScheduleCourseDtoCopyWith<$Res> {
  factory _$ScheduleCourseDtoCopyWith(_ScheduleCourseDto value, $Res Function(_ScheduleCourseDto) _then) = __$ScheduleCourseDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? code, String? color
});




}
/// @nodoc
class __$ScheduleCourseDtoCopyWithImpl<$Res>
    implements _$ScheduleCourseDtoCopyWith<$Res> {
  __$ScheduleCourseDtoCopyWithImpl(this._self, this._then);

  final _ScheduleCourseDto _self;
  final $Res Function(_ScheduleCourseDto) _then;

/// Create a copy of ScheduleCourseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? code = freezed,Object? color = freezed,}) {
  return _then(_ScheduleCourseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
