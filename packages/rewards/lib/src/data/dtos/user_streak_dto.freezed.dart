// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_streak_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStreakDto {

@JsonKey(name: 'activity_id') String get activityId;@JsonKey(name: 'current_streak') int get currentStreak;@JsonKey(name: 'longest_streak') int get longestStreak;@JsonKey(name: 'last_activity_date') DateTime? get lastActivityDate;
/// Create a copy of UserStreakDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStreakDtoCopyWith<UserStreakDto> get copyWith => _$UserStreakDtoCopyWithImpl<UserStreakDto>(this as UserStreakDto, _$identity);

  /// Serializes this UserStreakDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserStreakDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStreakDto&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.currentStreak, _this.currentStreak) || other.currentStreak == _this.currentStreak)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak)&&(identical(other.lastActivityDate, _this.lastActivityDate) || other.lastActivityDate == _this.lastActivityDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserStreakDto;
  return Object.hash(runtimeType,_this.activityId,_this.currentStreak,_this.longestStreak,_this.lastActivityDate);
}

@override
String toString() {
  final _this = this as UserStreakDto;
  return 'UserStreakDto(activityId: ${_this.activityId}, currentStreak: ${_this.currentStreak}, longestStreak: ${_this.longestStreak}, lastActivityDate: ${_this.lastActivityDate})';
}


}

/// @nodoc
abstract mixin class $UserStreakDtoCopyWith<$Res>  {
  factory $UserStreakDtoCopyWith(UserStreakDto value, $Res Function(UserStreakDto) _then) = _$UserStreakDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'current_streak') int currentStreak,@JsonKey(name: 'longest_streak') int longestStreak,@JsonKey(name: 'last_activity_date') DateTime? lastActivityDate
});




}
/// @nodoc
class _$UserStreakDtoCopyWithImpl<$Res>
    implements $UserStreakDtoCopyWith<$Res> {
  _$UserStreakDtoCopyWithImpl(this._self, this._then);

  final UserStreakDto _self;
  final $Res Function(UserStreakDto) _then;

/// Create a copy of UserStreakDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastActivityDate = freezed,}) {
  return _then(UserStreakDto(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastActivityDate: freezed == lastActivityDate ? _self.lastActivityDate : lastActivityDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStreakDto].
extension UserStreakDtoPatterns on UserStreakDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStreakDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStreakDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStreakDto value)  $default,){
final _that = this;
switch (_that) {
case _UserStreakDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStreakDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserStreakDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'current_streak')  int currentStreak, @JsonKey(name: 'longest_streak')  int longestStreak, @JsonKey(name: 'last_activity_date')  DateTime? lastActivityDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStreakDto() when $default != null:
return $default(_that.activityId,_that.currentStreak,_that.longestStreak,_that.lastActivityDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'current_streak')  int currentStreak, @JsonKey(name: 'longest_streak')  int longestStreak, @JsonKey(name: 'last_activity_date')  DateTime? lastActivityDate)  $default,) {final _that = this;
switch (_that) {
case _UserStreakDto():
return $default(_that.activityId,_that.currentStreak,_that.longestStreak,_that.lastActivityDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'activity_id')  String activityId, @JsonKey(name: 'current_streak')  int currentStreak, @JsonKey(name: 'longest_streak')  int longestStreak, @JsonKey(name: 'last_activity_date')  DateTime? lastActivityDate)?  $default,) {final _that = this;
switch (_that) {
case _UserStreakDto() when $default != null:
return $default(_that.activityId,_that.currentStreak,_that.longestStreak,_that.lastActivityDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStreakDto extends UserStreakDto {
  const _UserStreakDto({@JsonKey(name: 'activity_id') this.activityId = '', @JsonKey(name: 'current_streak') this.currentStreak = 0, @JsonKey(name: 'longest_streak') this.longestStreak = 0, @JsonKey(name: 'last_activity_date') this.lastActivityDate}): super._();
  factory _UserStreakDto.fromJson(Map<String, dynamic> json) => _$UserStreakDtoFromJson(json);

@override@JsonKey(name: 'activity_id') final  String activityId;
@override@JsonKey(name: 'current_streak') final  int currentStreak;
@override@JsonKey(name: 'longest_streak') final  int longestStreak;
@override@JsonKey(name: 'last_activity_date') final  DateTime? lastActivityDate;

/// Create a copy of UserStreakDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStreakDtoCopyWith<_UserStreakDto> get copyWith => __$UserStreakDtoCopyWithImpl<_UserStreakDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStreakDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStreakDto&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastActivityDate, lastActivityDate) || other.lastActivityDate == lastActivityDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activityId,currentStreak,longestStreak,lastActivityDate);
}

@override
String toString() {
    return 'UserStreakDto(activityId: $activityId, currentStreak: $currentStreak, longestStreak: $longestStreak, lastActivityDate: $lastActivityDate)';
}


}

/// @nodoc
abstract mixin class _$UserStreakDtoCopyWith<$Res> implements $UserStreakDtoCopyWith<$Res> {
  factory _$UserStreakDtoCopyWith(_UserStreakDto value, $Res Function(_UserStreakDto) _then) = __$UserStreakDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'activity_id') String activityId,@JsonKey(name: 'current_streak') int currentStreak,@JsonKey(name: 'longest_streak') int longestStreak,@JsonKey(name: 'last_activity_date') DateTime? lastActivityDate
});




}
/// @nodoc
class __$UserStreakDtoCopyWithImpl<$Res>
    implements _$UserStreakDtoCopyWith<$Res> {
  __$UserStreakDtoCopyWithImpl(this._self, this._then);

  final _UserStreakDto _self;
  final $Res Function(_UserStreakDto) _then;

/// Create a copy of UserStreakDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastActivityDate = freezed,}) {
  return _then(_UserStreakDto(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastActivityDate: freezed == lastActivityDate ? _self.lastActivityDate : lastActivityDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
