// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_streaks_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStreaksDto {

 List<UserStreakDto> get streaks; List<UserStreakDto> get results;
/// Create a copy of UserStreaksDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStreaksDtoCopyWith<UserStreaksDto> get copyWith => _$UserStreaksDtoCopyWithImpl<UserStreaksDto>(this as UserStreaksDto, _$identity);

  /// Serializes this UserStreaksDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserStreaksDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStreaksDto&&const DeepCollectionEquality().equals(other.streaks, _this.streaks)&&const DeepCollectionEquality().equals(other.results, _this.results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserStreaksDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.streaks),const DeepCollectionEquality().hash(_this.results));
}

@override
String toString() {
  final _this = this as UserStreaksDto;
  return 'UserStreaksDto(streaks: ${_this.streaks}, results: ${_this.results})';
}


}

/// @nodoc
abstract mixin class $UserStreaksDtoCopyWith<$Res>  {
  factory $UserStreaksDtoCopyWith(UserStreaksDto value, $Res Function(UserStreaksDto) _then) = _$UserStreaksDtoCopyWithImpl;
@useResult
$Res call({
 List<UserStreakDto> streaks, List<UserStreakDto> results
});




}
/// @nodoc
class _$UserStreaksDtoCopyWithImpl<$Res>
    implements $UserStreaksDtoCopyWith<$Res> {
  _$UserStreaksDtoCopyWithImpl(this._self, this._then);

  final UserStreaksDto _self;
  final $Res Function(UserStreaksDto) _then;

/// Create a copy of UserStreaksDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streaks = null,Object? results = null,}) {
  return _then(UserStreaksDto(
streaks: null == streaks ? _self.streaks : streaks // ignore: cast_nullable_to_non_nullable
as List<UserStreakDto>,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<UserStreakDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStreaksDto].
extension UserStreaksDtoPatterns on UserStreaksDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStreaksDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStreaksDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStreaksDto value)  $default,){
final _that = this;
switch (_that) {
case _UserStreaksDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStreaksDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserStreaksDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserStreakDto> streaks,  List<UserStreakDto> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStreaksDto() when $default != null:
return $default(_that.streaks,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserStreakDto> streaks,  List<UserStreakDto> results)  $default,) {final _that = this;
switch (_that) {
case _UserStreaksDto():
return $default(_that.streaks,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserStreakDto> streaks,  List<UserStreakDto> results)?  $default,) {final _that = this;
switch (_that) {
case _UserStreaksDto() when $default != null:
return $default(_that.streaks,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStreaksDto implements UserStreaksDto {
  const _UserStreaksDto({ List<UserStreakDto> streaks = const <UserStreakDto>[],  List<UserStreakDto> results = const <UserStreakDto>[]}): _streaks = streaks,_results = results;
  factory _UserStreaksDto.fromJson(Map<String, dynamic> json) => _$UserStreaksDtoFromJson(json);

 final  List<UserStreakDto> _streaks;
@override@JsonKey() List<UserStreakDto> get streaks {
  if (_streaks is EqualUnmodifiableListView) return _streaks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_streaks);
}

 final  List<UserStreakDto> _results;
@override@JsonKey() List<UserStreakDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of UserStreaksDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStreaksDtoCopyWith<_UserStreaksDto> get copyWith => __$UserStreaksDtoCopyWithImpl<_UserStreaksDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStreaksDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStreaksDto&&const DeepCollectionEquality().equals(other.streaks, _streaks)&&const DeepCollectionEquality().equals(other.results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_streaks),const DeepCollectionEquality().hash(_results));
}

@override
String toString() {
    return 'UserStreaksDto(streaks: $streaks, results: $results)';
}


}

/// @nodoc
abstract mixin class _$UserStreaksDtoCopyWith<$Res> implements $UserStreaksDtoCopyWith<$Res> {
  factory _$UserStreaksDtoCopyWith(_UserStreaksDto value, $Res Function(_UserStreaksDto) _then) = __$UserStreaksDtoCopyWithImpl;
@override @useResult
$Res call({
 List<UserStreakDto> streaks, List<UserStreakDto> results
});




}
/// @nodoc
class __$UserStreaksDtoCopyWithImpl<$Res>
    implements _$UserStreaksDtoCopyWith<$Res> {
  __$UserStreaksDtoCopyWithImpl(this._self, this._then);

  final _UserStreaksDto _self;
  final $Res Function(_UserStreaksDto) _then;

/// Create a copy of UserStreaksDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? streaks = null,Object? results = null,}) {
  return _then(_UserStreaksDto(
streaks: null == streaks ? _self._streaks : streaks // ignore: cast_nullable_to_non_nullable
as List<UserStreakDto>,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<UserStreakDto>,
  ));
}


}

// dart format on
