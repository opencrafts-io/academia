// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChirpUser {

 String get userID; String? get email; String? get phone; String? get username; int get vibePoints; String? get avatarUrl; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ChirpUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpUserCopyWith<ChirpUser> get copyWith => _$ChirpUserCopyWithImpl<ChirpUser>(this as ChirpUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpUser&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,userID,email,phone,username,vibePoints,avatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ChirpUser(userID: $userID, email: $email, phone: $phone, username: $username, vibePoints: $vibePoints, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChirpUserCopyWith<$Res>  {
  factory $ChirpUserCopyWith(ChirpUser value, $Res Function(ChirpUser) _then) = _$ChirpUserCopyWithImpl;
@useResult
$Res call({
 String userID, String? email, String? phone, String? username, int vibePoints, String? avatarUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ChirpUserCopyWithImpl<$Res>
    implements $ChirpUserCopyWith<$Res> {
  _$ChirpUserCopyWithImpl(this._self, this._then);

  final ChirpUser _self;
  final $Res Function(ChirpUser) _then;

/// Create a copy of ChirpUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userID = null,Object? email = freezed,Object? phone = freezed,Object? username = freezed,Object? vibePoints = null,Object? avatarUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChirpUser].
extension ChirpUserPatterns on ChirpUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChirpUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChirpUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChirpUser value)  $default,){
final _that = this;
switch (_that) {
case _ChirpUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChirpUser value)?  $default,){
final _that = this;
switch (_that) {
case _ChirpUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userID,  String? email,  String? phone,  String? username,  int vibePoints,  String? avatarUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChirpUser() when $default != null:
return $default(_that.userID,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userID,  String? email,  String? phone,  String? username,  int vibePoints,  String? avatarUrl,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChirpUser():
return $default(_that.userID,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userID,  String? email,  String? phone,  String? username,  int vibePoints,  String? avatarUrl,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChirpUser() when $default != null:
return $default(_that.userID,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ChirpUser implements ChirpUser {
  const _ChirpUser({required this.userID, this.email, this.phone, this.username, this.vibePoints = 0, this.avatarUrl, required this.createdAt, required this.updatedAt});
  

@override final  String userID;
@override final  String? email;
@override final  String? phone;
@override final  String? username;
@override@JsonKey() final  int vibePoints;
@override final  String? avatarUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ChirpUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChirpUserCopyWith<_ChirpUser> get copyWith => __$ChirpUserCopyWithImpl<_ChirpUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChirpUser&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,userID,email,phone,username,vibePoints,avatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ChirpUser(userID: $userID, email: $email, phone: $phone, username: $username, vibePoints: $vibePoints, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChirpUserCopyWith<$Res> implements $ChirpUserCopyWith<$Res> {
  factory _$ChirpUserCopyWith(_ChirpUser value, $Res Function(_ChirpUser) _then) = __$ChirpUserCopyWithImpl;
@override @useResult
$Res call({
 String userID, String? email, String? phone, String? username, int vibePoints, String? avatarUrl, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ChirpUserCopyWithImpl<$Res>
    implements _$ChirpUserCopyWith<$Res> {
  __$ChirpUserCopyWithImpl(this._self, this._then);

  final _ChirpUser _self;
  final $Res Function(_ChirpUser) _then;

/// Create a copy of ChirpUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userID = null,Object? email = freezed,Object? phone = freezed,Object? username = freezed,Object? vibePoints = null,Object? avatarUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ChirpUser(
userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
