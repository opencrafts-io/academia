// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_streak.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserStreak {

 String get activityId; int get currentStreak; int get longestStreak; DateTime? get lastActivityDate;
/// Create a copy of UserStreak
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStreakCopyWith<UserStreak> get copyWith => _$UserStreakCopyWithImpl<UserStreak>(this as UserStreak, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserStreak;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStreak&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.currentStreak, _this.currentStreak) || other.currentStreak == _this.currentStreak)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak)&&(identical(other.lastActivityDate, _this.lastActivityDate) || other.lastActivityDate == _this.lastActivityDate));
}


@override
int get hashCode {
  final _this = this as UserStreak;
  return Object.hash(runtimeType,_this.activityId,_this.currentStreak,_this.longestStreak,_this.lastActivityDate);
}

@override
String toString() {
  final _this = this as UserStreak;
  return 'UserStreak(activityId: ${_this.activityId}, currentStreak: ${_this.currentStreak}, longestStreak: ${_this.longestStreak}, lastActivityDate: ${_this.lastActivityDate})';
}


}

/// @nodoc
abstract mixin class $UserStreakCopyWith<$Res>  {
  factory $UserStreakCopyWith(UserStreak value, $Res Function(UserStreak) _then) = _$UserStreakCopyWithImpl;
@useResult
$Res call({
 String activityId, int currentStreak, int longestStreak, DateTime? lastActivityDate
});




}
/// @nodoc
class _$UserStreakCopyWithImpl<$Res>
    implements $UserStreakCopyWith<$Res> {
  _$UserStreakCopyWithImpl(this._self, this._then);

  final UserStreak _self;
  final $Res Function(UserStreak) _then;

/// Create a copy of UserStreak
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastActivityDate = freezed,}) {
  return _then(UserStreak(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastActivityDate: freezed == lastActivityDate ? _self.lastActivityDate : lastActivityDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStreak].
extension UserStreakPatterns on UserStreak {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStreak value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStreak() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStreak value)  $default,){
final _that = this;
switch (_that) {
case _UserStreak():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStreak value)?  $default,){
final _that = this;
switch (_that) {
case _UserStreak() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activityId,  int currentStreak,  int longestStreak,  DateTime? lastActivityDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStreak() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activityId,  int currentStreak,  int longestStreak,  DateTime? lastActivityDate)  $default,) {final _that = this;
switch (_that) {
case _UserStreak():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activityId,  int currentStreak,  int longestStreak,  DateTime? lastActivityDate)?  $default,) {final _that = this;
switch (_that) {
case _UserStreak() when $default != null:
return $default(_that.activityId,_that.currentStreak,_that.longestStreak,_that.lastActivityDate);case _:
  return null;

}
}

}

/// @nodoc


class _UserStreak implements UserStreak {
  const _UserStreak({required this.activityId, required this.currentStreak, required this.longestStreak, this.lastActivityDate});


@override final  String activityId;
@override final  int currentStreak;
@override final  int longestStreak;
@override final  DateTime? lastActivityDate;

/// Create a copy of UserStreak
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStreakCopyWith<_UserStreak> get copyWith => __$UserStreakCopyWithImpl<_UserStreak>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStreak&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.lastActivityDate, lastActivityDate) || other.lastActivityDate == lastActivityDate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,activityId,currentStreak,longestStreak,lastActivityDate);
}

@override
String toString() {
    return 'UserStreak(activityId: $activityId, currentStreak: $currentStreak, longestStreak: $longestStreak, lastActivityDate: $lastActivityDate)';
}


}

/// @nodoc
abstract mixin class _$UserStreakCopyWith<$Res> implements $UserStreakCopyWith<$Res> {
  factory _$UserStreakCopyWith(_UserStreak value, $Res Function(_UserStreak) _then) = __$UserStreakCopyWithImpl;
@override @useResult
$Res call({
 String activityId, int currentStreak, int longestStreak, DateTime? lastActivityDate
});




}
/// @nodoc
class __$UserStreakCopyWithImpl<$Res>
    implements _$UserStreakCopyWith<$Res> {
  __$UserStreakCopyWithImpl(this._self, this._then);

  final _UserStreak _self;
  final $Res Function(_UserStreak) _then;

/// Create a copy of UserStreak
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? currentStreak = null,Object? longestStreak = null,Object? lastActivityDate = freezed,}) {
  return _then(_UserStreak(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,lastActivityDate: freezed == lastActivityDate ? _self.lastActivityDate : lastActivityDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
