// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_rank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaderboardRank implements DiagnosticableTreeMixin {

 String get id; String get avatarUrl; String get email; String get name; String get username; int get vibePoints; int get vibeRank; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of LeaderboardRank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardRankCopyWith<LeaderboardRank> get copyWith => _$LeaderboardRankCopyWithImpl<LeaderboardRank>(this as LeaderboardRank, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LeaderboardRank'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('avatarUrl', avatarUrl))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('vibePoints', vibePoints))..add(DiagnosticsProperty('vibeRank', vibeRank))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardRank&&(identical(other.id, id) || other.id == id)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.vibeRank, vibeRank) || other.vibeRank == vibeRank)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,avatarUrl,email,name,username,vibePoints,vibeRank,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LeaderboardRank(id: $id, avatarUrl: $avatarUrl, email: $email, name: $name, username: $username, vibePoints: $vibePoints, vibeRank: $vibeRank, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LeaderboardRankCopyWith<$Res>  {
  factory $LeaderboardRankCopyWith(LeaderboardRank value, $Res Function(LeaderboardRank) _then) = _$LeaderboardRankCopyWithImpl;
@useResult
$Res call({
 String id, String avatarUrl, String email, String name, String username, int vibePoints, int vibeRank, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$LeaderboardRankCopyWithImpl<$Res>
    implements $LeaderboardRankCopyWith<$Res> {
  _$LeaderboardRankCopyWithImpl(this._self, this._then);

  final LeaderboardRank _self;
  final $Res Function(LeaderboardRank) _then;

/// Create a copy of LeaderboardRank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? avatarUrl = null,Object? email = null,Object? name = null,Object? username = null,Object? vibePoints = null,Object? vibeRank = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,vibeRank: null == vibeRank ? _self.vibeRank : vibeRank // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaderboardRank].
extension LeaderboardRankPatterns on LeaderboardRank {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderboardRank value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderboardRank() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderboardRank value)  $default,){
final _that = this;
switch (_that) {
case _LeaderboardRank():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderboardRank value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderboardRank() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String avatarUrl,  String email,  String name,  String username,  int vibePoints,  int vibeRank,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderboardRank() when $default != null:
return $default(_that.id,_that.avatarUrl,_that.email,_that.name,_that.username,_that.vibePoints,_that.vibeRank,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String avatarUrl,  String email,  String name,  String username,  int vibePoints,  int vibeRank,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LeaderboardRank():
return $default(_that.id,_that.avatarUrl,_that.email,_that.name,_that.username,_that.vibePoints,_that.vibeRank,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String avatarUrl,  String email,  String name,  String username,  int vibePoints,  int vibeRank,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LeaderboardRank() when $default != null:
return $default(_that.id,_that.avatarUrl,_that.email,_that.name,_that.username,_that.vibePoints,_that.vibeRank,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _LeaderboardRank extends LeaderboardRank with DiagnosticableTreeMixin {
  const _LeaderboardRank({required this.id, required this.avatarUrl, required this.email, required this.name, required this.username, required this.vibePoints, required this.vibeRank, required this.createdAt, required this.updatedAt}): super._();
  

@override final  String id;
@override final  String avatarUrl;
@override final  String email;
@override final  String name;
@override final  String username;
@override final  int vibePoints;
@override final  int vibeRank;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of LeaderboardRank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardRankCopyWith<_LeaderboardRank> get copyWith => __$LeaderboardRankCopyWithImpl<_LeaderboardRank>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LeaderboardRank'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('avatarUrl', avatarUrl))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('vibePoints', vibePoints))..add(DiagnosticsProperty('vibeRank', vibeRank))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardRank&&(identical(other.id, id) || other.id == id)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.vibeRank, vibeRank) || other.vibeRank == vibeRank)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,avatarUrl,email,name,username,vibePoints,vibeRank,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LeaderboardRank(id: $id, avatarUrl: $avatarUrl, email: $email, name: $name, username: $username, vibePoints: $vibePoints, vibeRank: $vibeRank, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardRankCopyWith<$Res> implements $LeaderboardRankCopyWith<$Res> {
  factory _$LeaderboardRankCopyWith(_LeaderboardRank value, $Res Function(_LeaderboardRank) _then) = __$LeaderboardRankCopyWithImpl;
@override @useResult
$Res call({
 String id, String avatarUrl, String email, String name, String username, int vibePoints, int vibeRank, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$LeaderboardRankCopyWithImpl<$Res>
    implements _$LeaderboardRankCopyWith<$Res> {
  __$LeaderboardRankCopyWithImpl(this._self, this._then);

  final _LeaderboardRank _self;
  final $Res Function(_LeaderboardRank) _then;

/// Create a copy of LeaderboardRank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? avatarUrl = null,Object? email = null,Object? name = null,Object? username = null,Object? vibePoints = null,Object? vibeRank = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_LeaderboardRank(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,vibeRank: null == vibeRank ? _self.vibeRank : vibeRank // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
