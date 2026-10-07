// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_around_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaderboardAroundDto {

 List<LeaderboardEntryDto> get entries; List<LeaderboardEntryDto> get results; List<LeaderboardEntryDto> get leaderboard; LeaderboardEntryDto? get user;@JsonKey(name: 'user_position') int? get userPosition;@JsonKey(name: 'total_users') int get totalUsers;
/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardAroundDtoCopyWith<LeaderboardAroundDto> get copyWith => _$LeaderboardAroundDtoCopyWithImpl<LeaderboardAroundDto>(this as LeaderboardAroundDto, _$identity);

  /// Serializes this LeaderboardAroundDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LeaderboardAroundDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardAroundDto&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&const DeepCollectionEquality().equals(other.results, _this.results)&&const DeepCollectionEquality().equals(other.leaderboard, _this.leaderboard)&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.userPosition, _this.userPosition) || other.userPosition == _this.userPosition)&&(identical(other.totalUsers, _this.totalUsers) || other.totalUsers == _this.totalUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LeaderboardAroundDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.entries),const DeepCollectionEquality().hash(_this.results),const DeepCollectionEquality().hash(_this.leaderboard),_this.user,_this.userPosition,_this.totalUsers);
}

@override
String toString() {
  final _this = this as LeaderboardAroundDto;
  return 'LeaderboardAroundDto(entries: ${_this.entries}, results: ${_this.results}, leaderboard: ${_this.leaderboard}, user: ${_this.user}, userPosition: ${_this.userPosition}, totalUsers: ${_this.totalUsers})';
}


}

/// @nodoc
abstract mixin class $LeaderboardAroundDtoCopyWith<$Res>  {
  factory $LeaderboardAroundDtoCopyWith(LeaderboardAroundDto value, $Res Function(LeaderboardAroundDto) _then) = _$LeaderboardAroundDtoCopyWithImpl;
@useResult
$Res call({
 List<LeaderboardEntryDto> entries, List<LeaderboardEntryDto> results, List<LeaderboardEntryDto> leaderboard, LeaderboardEntryDto? user,@JsonKey(name: 'user_position') int? userPosition,@JsonKey(name: 'total_users') int totalUsers
});


$LeaderboardEntryDtoCopyWith<$Res>? get user;

}
/// @nodoc
class _$LeaderboardAroundDtoCopyWithImpl<$Res>
    implements $LeaderboardAroundDtoCopyWith<$Res> {
  _$LeaderboardAroundDtoCopyWithImpl(this._self, this._then);

  final LeaderboardAroundDto _self;
  final $Res Function(LeaderboardAroundDto) _then;

/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? results = null,Object? leaderboard = null,Object? user = freezed,Object? userPosition = freezed,Object? totalUsers = null,}) {
  return _then(LeaderboardAroundDto(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,leaderboard: null == leaderboard ? _self.leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LeaderboardEntryDto?,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as int?,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaderboardEntryDtoCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $LeaderboardEntryDtoCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaderboardAroundDto].
extension LeaderboardAroundDtoPatterns on LeaderboardAroundDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderboardAroundDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderboardAroundDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderboardAroundDto value)  $default,){
final _that = this;
switch (_that) {
case _LeaderboardAroundDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderboardAroundDto value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderboardAroundDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaderboardEntryDto> entries,  List<LeaderboardEntryDto> results,  List<LeaderboardEntryDto> leaderboard,  LeaderboardEntryDto? user, @JsonKey(name: 'user_position')  int? userPosition, @JsonKey(name: 'total_users')  int totalUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderboardAroundDto() when $default != null:
return $default(_that.entries,_that.results,_that.leaderboard,_that.user,_that.userPosition,_that.totalUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaderboardEntryDto> entries,  List<LeaderboardEntryDto> results,  List<LeaderboardEntryDto> leaderboard,  LeaderboardEntryDto? user, @JsonKey(name: 'user_position')  int? userPosition, @JsonKey(name: 'total_users')  int totalUsers)  $default,) {final _that = this;
switch (_that) {
case _LeaderboardAroundDto():
return $default(_that.entries,_that.results,_that.leaderboard,_that.user,_that.userPosition,_that.totalUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaderboardEntryDto> entries,  List<LeaderboardEntryDto> results,  List<LeaderboardEntryDto> leaderboard,  LeaderboardEntryDto? user, @JsonKey(name: 'user_position')  int? userPosition, @JsonKey(name: 'total_users')  int totalUsers)?  $default,) {final _that = this;
switch (_that) {
case _LeaderboardAroundDto() when $default != null:
return $default(_that.entries,_that.results,_that.leaderboard,_that.user,_that.userPosition,_that.totalUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaderboardAroundDto extends LeaderboardAroundDto {
  const _LeaderboardAroundDto({ List<LeaderboardEntryDto> entries = const <LeaderboardEntryDto>[],  List<LeaderboardEntryDto> results = const <LeaderboardEntryDto>[],  List<LeaderboardEntryDto> leaderboard = const <LeaderboardEntryDto>[], this.user, @JsonKey(name: 'user_position') this.userPosition, @JsonKey(name: 'total_users') this.totalUsers = 0}): _entries = entries,_results = results,_leaderboard = leaderboard,super._();
  factory _LeaderboardAroundDto.fromJson(Map<String, dynamic> json) => _$LeaderboardAroundDtoFromJson(json);

 final  List<LeaderboardEntryDto> _entries;
@override@JsonKey() List<LeaderboardEntryDto> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<LeaderboardEntryDto> _results;
@override@JsonKey() List<LeaderboardEntryDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<LeaderboardEntryDto> _leaderboard;
@override@JsonKey() List<LeaderboardEntryDto> get leaderboard {
  if (_leaderboard is EqualUnmodifiableListView) return _leaderboard;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaderboard);
}

@override final  LeaderboardEntryDto? user;
@override@JsonKey(name: 'user_position') final  int? userPosition;
@override@JsonKey(name: 'total_users') final  int totalUsers;

/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardAroundDtoCopyWith<_LeaderboardAroundDto> get copyWith => __$LeaderboardAroundDtoCopyWithImpl<_LeaderboardAroundDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaderboardAroundDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardAroundDto&&const DeepCollectionEquality().equals(other.entries, _entries)&&const DeepCollectionEquality().equals(other.results, _results)&&const DeepCollectionEquality().equals(other.leaderboard, _leaderboard)&&(identical(other.user, user) || other.user == user)&&(identical(other.userPosition, userPosition) || other.userPosition == userPosition)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_leaderboard),user,userPosition,totalUsers);
}

@override
String toString() {
    return 'LeaderboardAroundDto(entries: $entries, results: $results, leaderboard: $leaderboard, user: $user, userPosition: $userPosition, totalUsers: $totalUsers)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardAroundDtoCopyWith<$Res> implements $LeaderboardAroundDtoCopyWith<$Res> {
  factory _$LeaderboardAroundDtoCopyWith(_LeaderboardAroundDto value, $Res Function(_LeaderboardAroundDto) _then) = __$LeaderboardAroundDtoCopyWithImpl;
@override @useResult
$Res call({
 List<LeaderboardEntryDto> entries, List<LeaderboardEntryDto> results, List<LeaderboardEntryDto> leaderboard, LeaderboardEntryDto? user,@JsonKey(name: 'user_position') int? userPosition,@JsonKey(name: 'total_users') int totalUsers
});


@override $LeaderboardEntryDtoCopyWith<$Res>? get user;

}
/// @nodoc
class __$LeaderboardAroundDtoCopyWithImpl<$Res>
    implements _$LeaderboardAroundDtoCopyWith<$Res> {
  __$LeaderboardAroundDtoCopyWithImpl(this._self, this._then);

  final _LeaderboardAroundDto _self;
  final $Res Function(_LeaderboardAroundDto) _then;

/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? results = null,Object? leaderboard = null,Object? user = freezed,Object? userPosition = freezed,Object? totalUsers = null,}) {
  return _then(_LeaderboardAroundDto(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,leaderboard: null == leaderboard ? _self._leaderboard : leaderboard // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntryDto>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LeaderboardEntryDto?,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as int?,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LeaderboardAroundDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaderboardEntryDtoCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $LeaderboardEntryDtoCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
