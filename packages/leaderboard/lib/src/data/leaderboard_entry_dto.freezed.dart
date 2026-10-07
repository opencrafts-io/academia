// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaderboardEntryDto {

 String get id;@JsonKey(name: 'account_id') String? get accountId; String? get username;@JsonKey(name: 'avatar_url') String? get avatarUrl; int get position;@JsonKey(name: 'vibe_rank') int get vibeRank;@JsonKey(name: 'vibe_points') int get vibePoints;
/// Create a copy of LeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardEntryDtoCopyWith<LeaderboardEntryDto> get copyWith => _$LeaderboardEntryDtoCopyWithImpl<LeaderboardEntryDto>(this as LeaderboardEntryDto, _$identity);

  /// Serializes this LeaderboardEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LeaderboardEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardEntryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.vibeRank, _this.vibeRank) || other.vibeRank == _this.vibeRank)&&(identical(other.vibePoints, _this.vibePoints) || other.vibePoints == _this.vibePoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LeaderboardEntryDto;
  return Object.hash(runtimeType,_this.id,_this.accountId,_this.username,_this.avatarUrl,_this.position,_this.vibeRank,_this.vibePoints);
}

@override
String toString() {
  final _this = this as LeaderboardEntryDto;
  return 'LeaderboardEntryDto(id: ${_this.id}, accountId: ${_this.accountId}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl}, position: ${_this.position}, vibeRank: ${_this.vibeRank}, vibePoints: ${_this.vibePoints})';
}


}

/// @nodoc
abstract mixin class $LeaderboardEntryDtoCopyWith<$Res>  {
  factory $LeaderboardEntryDtoCopyWith(LeaderboardEntryDto value, $Res Function(LeaderboardEntryDto) _then) = _$LeaderboardEntryDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'account_id') String? accountId, String? username,@JsonKey(name: 'avatar_url') String? avatarUrl, int position,@JsonKey(name: 'vibe_rank') int vibeRank,@JsonKey(name: 'vibe_points') int vibePoints
});




}
/// @nodoc
class _$LeaderboardEntryDtoCopyWithImpl<$Res>
    implements $LeaderboardEntryDtoCopyWith<$Res> {
  _$LeaderboardEntryDtoCopyWithImpl(this._self, this._then);

  final LeaderboardEntryDto _self;
  final $Res Function(LeaderboardEntryDto) _then;

/// Create a copy of LeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = freezed,Object? username = freezed,Object? avatarUrl = freezed,Object? position = null,Object? vibeRank = null,Object? vibePoints = null,}) {
  return _then(LeaderboardEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,vibeRank: null == vibeRank ? _self.vibeRank : vibeRank // ignore: cast_nullable_to_non_nullable
as int,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaderboardEntryDto].
extension LeaderboardEntryDtoPatterns on LeaderboardEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderboardEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderboardEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderboardEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _LeaderboardEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderboardEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderboardEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'account_id')  String? accountId,  String? username, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int position, @JsonKey(name: 'vibe_rank')  int vibeRank, @JsonKey(name: 'vibe_points')  int vibePoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderboardEntryDto() when $default != null:
return $default(_that.id,_that.accountId,_that.username,_that.avatarUrl,_that.position,_that.vibeRank,_that.vibePoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'account_id')  String? accountId,  String? username, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int position, @JsonKey(name: 'vibe_rank')  int vibeRank, @JsonKey(name: 'vibe_points')  int vibePoints)  $default,) {final _that = this;
switch (_that) {
case _LeaderboardEntryDto():
return $default(_that.id,_that.accountId,_that.username,_that.avatarUrl,_that.position,_that.vibeRank,_that.vibePoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'account_id')  String? accountId,  String? username, @JsonKey(name: 'avatar_url')  String? avatarUrl,  int position, @JsonKey(name: 'vibe_rank')  int vibeRank, @JsonKey(name: 'vibe_points')  int vibePoints)?  $default,) {final _that = this;
switch (_that) {
case _LeaderboardEntryDto() when $default != null:
return $default(_that.id,_that.accountId,_that.username,_that.avatarUrl,_that.position,_that.vibeRank,_that.vibePoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaderboardEntryDto extends LeaderboardEntryDto {
  const _LeaderboardEntryDto({this.id = '', @JsonKey(name: 'account_id') this.accountId, this.username, @JsonKey(name: 'avatar_url') this.avatarUrl, this.position = 0, @JsonKey(name: 'vibe_rank') this.vibeRank = 0, @JsonKey(name: 'vibe_points') this.vibePoints = 0}): super._();
  factory _LeaderboardEntryDto.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryDtoFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey(name: 'account_id') final  String? accountId;
@override final  String? username;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey() final  int position;
@override@JsonKey(name: 'vibe_rank') final  int vibeRank;
@override@JsonKey(name: 'vibe_points') final  int vibePoints;

/// Create a copy of LeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardEntryDtoCopyWith<_LeaderboardEntryDto> get copyWith => __$LeaderboardEntryDtoCopyWithImpl<_LeaderboardEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaderboardEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardEntryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.position, position) || other.position == position)&&(identical(other.vibeRank, vibeRank) || other.vibeRank == vibeRank)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,accountId,username,avatarUrl,position,vibeRank,vibePoints);
}

@override
String toString() {
    return 'LeaderboardEntryDto(id: $id, accountId: $accountId, username: $username, avatarUrl: $avatarUrl, position: $position, vibeRank: $vibeRank, vibePoints: $vibePoints)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardEntryDtoCopyWith<$Res> implements $LeaderboardEntryDtoCopyWith<$Res> {
  factory _$LeaderboardEntryDtoCopyWith(_LeaderboardEntryDto value, $Res Function(_LeaderboardEntryDto) _then) = __$LeaderboardEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'account_id') String? accountId, String? username,@JsonKey(name: 'avatar_url') String? avatarUrl, int position,@JsonKey(name: 'vibe_rank') int vibeRank,@JsonKey(name: 'vibe_points') int vibePoints
});




}
/// @nodoc
class __$LeaderboardEntryDtoCopyWithImpl<$Res>
    implements _$LeaderboardEntryDtoCopyWith<$Res> {
  __$LeaderboardEntryDtoCopyWithImpl(this._self, this._then);

  final _LeaderboardEntryDto _self;
  final $Res Function(_LeaderboardEntryDto) _then;

/// Create a copy of LeaderboardEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = freezed,Object? username = freezed,Object? avatarUrl = freezed,Object? position = null,Object? vibeRank = null,Object? vibePoints = null,}) {
  return _then(_LeaderboardEntryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,vibeRank: null == vibeRank ? _self.vibeRank : vibeRank // ignore: cast_nullable_to_non_nullable
as int,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
