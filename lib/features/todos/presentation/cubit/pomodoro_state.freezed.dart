// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pomodoro_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PomodoroState {

 PomodoroPhase get phase; Duration get remaining; bool get isRunning;/// Number of focus sessions completed in the current cycle, reset
/// after every long break.
 int get completedFocusSessions; Duration get focusDuration; Duration get shortBreakDuration; Duration get longBreakDuration;/// How many focus sessions happen before a long break is taken.
 int get sessionsBeforeLongBreak;/// The todo item this session is tracking time against, if any.
 int? get linkedTodoItemLocalId; String? get linkedTodoItemTitle;
/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PomodoroStateCopyWith<PomodoroState> get copyWith => _$PomodoroStateCopyWithImpl<PomodoroState>(this as PomodoroState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PomodoroState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.completedFocusSessions, completedFocusSessions) || other.completedFocusSessions == completedFocusSessions)&&(identical(other.focusDuration, focusDuration) || other.focusDuration == focusDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration)&&(identical(other.sessionsBeforeLongBreak, sessionsBeforeLongBreak) || other.sessionsBeforeLongBreak == sessionsBeforeLongBreak)&&(identical(other.linkedTodoItemLocalId, linkedTodoItemLocalId) || other.linkedTodoItemLocalId == linkedTodoItemLocalId)&&(identical(other.linkedTodoItemTitle, linkedTodoItemTitle) || other.linkedTodoItemTitle == linkedTodoItemTitle));
}


@override
int get hashCode => Object.hash(runtimeType,phase,remaining,isRunning,completedFocusSessions,focusDuration,shortBreakDuration,longBreakDuration,sessionsBeforeLongBreak,linkedTodoItemLocalId,linkedTodoItemTitle);

@override
String toString() {
  return 'PomodoroState(phase: $phase, remaining: $remaining, isRunning: $isRunning, completedFocusSessions: $completedFocusSessions, focusDuration: $focusDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, sessionsBeforeLongBreak: $sessionsBeforeLongBreak, linkedTodoItemLocalId: $linkedTodoItemLocalId, linkedTodoItemTitle: $linkedTodoItemTitle)';
}


}

/// @nodoc
abstract mixin class $PomodoroStateCopyWith<$Res>  {
  factory $PomodoroStateCopyWith(PomodoroState value, $Res Function(PomodoroState) _then) = _$PomodoroStateCopyWithImpl;
@useResult
$Res call({
 PomodoroPhase phase, Duration remaining, bool isRunning, int completedFocusSessions, Duration focusDuration, Duration shortBreakDuration, Duration longBreakDuration, int sessionsBeforeLongBreak, int? linkedTodoItemLocalId, String? linkedTodoItemTitle
});




}
/// @nodoc
class _$PomodoroStateCopyWithImpl<$Res>
    implements $PomodoroStateCopyWith<$Res> {
  _$PomodoroStateCopyWithImpl(this._self, this._then);

  final PomodoroState _self;
  final $Res Function(PomodoroState) _then;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phase = null,Object? remaining = null,Object? isRunning = null,Object? completedFocusSessions = null,Object? focusDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,Object? sessionsBeforeLongBreak = null,Object? linkedTodoItemLocalId = freezed,Object? linkedTodoItemTitle = freezed,}) {
  return _then(_self.copyWith(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as PomodoroPhase,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,completedFocusSessions: null == completedFocusSessions ? _self.completedFocusSessions : completedFocusSessions // ignore: cast_nullable_to_non_nullable
as int,focusDuration: null == focusDuration ? _self.focusDuration : focusDuration // ignore: cast_nullable_to_non_nullable
as Duration,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,sessionsBeforeLongBreak: null == sessionsBeforeLongBreak ? _self.sessionsBeforeLongBreak : sessionsBeforeLongBreak // ignore: cast_nullable_to_non_nullable
as int,linkedTodoItemLocalId: freezed == linkedTodoItemLocalId ? _self.linkedTodoItemLocalId : linkedTodoItemLocalId // ignore: cast_nullable_to_non_nullable
as int?,linkedTodoItemTitle: freezed == linkedTodoItemTitle ? _self.linkedTodoItemTitle : linkedTodoItemTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PomodoroState].
extension PomodoroStatePatterns on PomodoroState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PomodoroState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PomodoroState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PomodoroState value)  $default,){
final _that = this;
switch (_that) {
case _PomodoroState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PomodoroState value)?  $default,){
final _that = this;
switch (_that) {
case _PomodoroState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PomodoroPhase phase,  Duration remaining,  bool isRunning,  int completedFocusSessions,  Duration focusDuration,  Duration shortBreakDuration,  Duration longBreakDuration,  int sessionsBeforeLongBreak,  int? linkedTodoItemLocalId,  String? linkedTodoItemTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PomodoroState() when $default != null:
return $default(_that.phase,_that.remaining,_that.isRunning,_that.completedFocusSessions,_that.focusDuration,_that.shortBreakDuration,_that.longBreakDuration,_that.sessionsBeforeLongBreak,_that.linkedTodoItemLocalId,_that.linkedTodoItemTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PomodoroPhase phase,  Duration remaining,  bool isRunning,  int completedFocusSessions,  Duration focusDuration,  Duration shortBreakDuration,  Duration longBreakDuration,  int sessionsBeforeLongBreak,  int? linkedTodoItemLocalId,  String? linkedTodoItemTitle)  $default,) {final _that = this;
switch (_that) {
case _PomodoroState():
return $default(_that.phase,_that.remaining,_that.isRunning,_that.completedFocusSessions,_that.focusDuration,_that.shortBreakDuration,_that.longBreakDuration,_that.sessionsBeforeLongBreak,_that.linkedTodoItemLocalId,_that.linkedTodoItemTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PomodoroPhase phase,  Duration remaining,  bool isRunning,  int completedFocusSessions,  Duration focusDuration,  Duration shortBreakDuration,  Duration longBreakDuration,  int sessionsBeforeLongBreak,  int? linkedTodoItemLocalId,  String? linkedTodoItemTitle)?  $default,) {final _that = this;
switch (_that) {
case _PomodoroState() when $default != null:
return $default(_that.phase,_that.remaining,_that.isRunning,_that.completedFocusSessions,_that.focusDuration,_that.shortBreakDuration,_that.longBreakDuration,_that.sessionsBeforeLongBreak,_that.linkedTodoItemLocalId,_that.linkedTodoItemTitle);case _:
  return null;

}
}

}

/// @nodoc


class _PomodoroState extends PomodoroState {
  const _PomodoroState({required this.phase, required this.remaining, this.isRunning = false, this.completedFocusSessions = 0, this.focusDuration = const Duration(minutes: 25), this.shortBreakDuration = const Duration(minutes: 5), this.longBreakDuration = const Duration(minutes: 15), this.sessionsBeforeLongBreak = 4, this.linkedTodoItemLocalId, this.linkedTodoItemTitle}): super._();
  

@override final  PomodoroPhase phase;
@override final  Duration remaining;
@override@JsonKey() final  bool isRunning;
/// Number of focus sessions completed in the current cycle, reset
/// after every long break.
@override@JsonKey() final  int completedFocusSessions;
@override@JsonKey() final  Duration focusDuration;
@override@JsonKey() final  Duration shortBreakDuration;
@override@JsonKey() final  Duration longBreakDuration;
/// How many focus sessions happen before a long break is taken.
@override@JsonKey() final  int sessionsBeforeLongBreak;
/// The todo item this session is tracking time against, if any.
@override final  int? linkedTodoItemLocalId;
@override final  String? linkedTodoItemTitle;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PomodoroStateCopyWith<_PomodoroState> get copyWith => __$PomodoroStateCopyWithImpl<_PomodoroState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PomodoroState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.completedFocusSessions, completedFocusSessions) || other.completedFocusSessions == completedFocusSessions)&&(identical(other.focusDuration, focusDuration) || other.focusDuration == focusDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration)&&(identical(other.sessionsBeforeLongBreak, sessionsBeforeLongBreak) || other.sessionsBeforeLongBreak == sessionsBeforeLongBreak)&&(identical(other.linkedTodoItemLocalId, linkedTodoItemLocalId) || other.linkedTodoItemLocalId == linkedTodoItemLocalId)&&(identical(other.linkedTodoItemTitle, linkedTodoItemTitle) || other.linkedTodoItemTitle == linkedTodoItemTitle));
}


@override
int get hashCode => Object.hash(runtimeType,phase,remaining,isRunning,completedFocusSessions,focusDuration,shortBreakDuration,longBreakDuration,sessionsBeforeLongBreak,linkedTodoItemLocalId,linkedTodoItemTitle);

@override
String toString() {
  return 'PomodoroState(phase: $phase, remaining: $remaining, isRunning: $isRunning, completedFocusSessions: $completedFocusSessions, focusDuration: $focusDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, sessionsBeforeLongBreak: $sessionsBeforeLongBreak, linkedTodoItemLocalId: $linkedTodoItemLocalId, linkedTodoItemTitle: $linkedTodoItemTitle)';
}


}

/// @nodoc
abstract mixin class _$PomodoroStateCopyWith<$Res> implements $PomodoroStateCopyWith<$Res> {
  factory _$PomodoroStateCopyWith(_PomodoroState value, $Res Function(_PomodoroState) _then) = __$PomodoroStateCopyWithImpl;
@override @useResult
$Res call({
 PomodoroPhase phase, Duration remaining, bool isRunning, int completedFocusSessions, Duration focusDuration, Duration shortBreakDuration, Duration longBreakDuration, int sessionsBeforeLongBreak, int? linkedTodoItemLocalId, String? linkedTodoItemTitle
});




}
/// @nodoc
class __$PomodoroStateCopyWithImpl<$Res>
    implements _$PomodoroStateCopyWith<$Res> {
  __$PomodoroStateCopyWithImpl(this._self, this._then);

  final _PomodoroState _self;
  final $Res Function(_PomodoroState) _then;

/// Create a copy of PomodoroState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phase = null,Object? remaining = null,Object? isRunning = null,Object? completedFocusSessions = null,Object? focusDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,Object? sessionsBeforeLongBreak = null,Object? linkedTodoItemLocalId = freezed,Object? linkedTodoItemTitle = freezed,}) {
  return _then(_PomodoroState(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as PomodoroPhase,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as Duration,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,completedFocusSessions: null == completedFocusSessions ? _self.completedFocusSessions : completedFocusSessions // ignore: cast_nullable_to_non_nullable
as int,focusDuration: null == focusDuration ? _self.focusDuration : focusDuration // ignore: cast_nullable_to_non_nullable
as Duration,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,sessionsBeforeLongBreak: null == sessionsBeforeLongBreak ? _self.sessionsBeforeLongBreak : sessionsBeforeLongBreak // ignore: cast_nullable_to_non_nullable
as int,linkedTodoItemLocalId: freezed == linkedTodoItemLocalId ? _self.linkedTodoItemLocalId : linkedTodoItemLocalId // ignore: cast_nullable_to_non_nullable
as int?,linkedTodoItemTitle: freezed == linkedTodoItemTitle ? _self.linkedTodoItemTitle : linkedTodoItemTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
