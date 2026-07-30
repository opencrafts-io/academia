// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_user_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChirpUserApiDto {

@JsonKey(name: 'user_id') String get userId; String? get email; String? get phone; String? get username;@JsonKey(name: 'vibe_points') int get vibePoints;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of ChirpUserApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpUserApiDtoCopyWith<ChirpUserApiDto> get copyWith => _$ChirpUserApiDtoCopyWithImpl<ChirpUserApiDto>(this as ChirpUserApiDto, _$identity);

  /// Serializes this ChirpUserApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpUserApiDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,phone,username,vibePoints,avatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ChirpUserApiDto(userId: $userId, email: $email, phone: $phone, username: $username, vibePoints: $vibePoints, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ChirpUserApiDtoCopyWith<$Res>  {
  factory $ChirpUserApiDtoCopyWith(ChirpUserApiDto value, $Res Function(ChirpUserApiDto) _then) = _$ChirpUserApiDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String? email, String? phone, String? username,@JsonKey(name: 'vibe_points') int vibePoints,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$ChirpUserApiDtoCopyWithImpl<$Res>
    implements $ChirpUserApiDtoCopyWith<$Res> {
  _$ChirpUserApiDtoCopyWithImpl(this._self, this._then);

  final ChirpUserApiDto _self;
  final $Res Function(ChirpUserApiDto) _then;

/// Create a copy of ChirpUserApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = freezed,Object? phone = freezed,Object? username = freezed,Object? vibePoints = null,Object? avatarUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ChirpUserApiDto].
extension ChirpUserApiDtoPatterns on ChirpUserApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChirpUserApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChirpUserApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChirpUserApiDto value)  $default,){
final _that = this;
switch (_that) {
case _ChirpUserApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChirpUserApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChirpUserApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String? email,  String? phone,  String? username, @JsonKey(name: 'vibe_points')  int vibePoints, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChirpUserApiDto() when $default != null:
return $default(_that.userId,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId,  String? email,  String? phone,  String? username, @JsonKey(name: 'vibe_points')  int vibePoints, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ChirpUserApiDto():
return $default(_that.userId,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId,  String? email,  String? phone,  String? username, @JsonKey(name: 'vibe_points')  int vibePoints, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChirpUserApiDto() when $default != null:
return $default(_that.userId,_that.email,_that.phone,_that.username,_that.vibePoints,_that.avatarUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChirpUserApiDto implements ChirpUserApiDto {
  const _ChirpUserApiDto({@JsonKey(name: 'user_id') required this.userId, this.email, this.phone, this.username, @JsonKey(name: 'vibe_points') this.vibePoints = 0, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _ChirpUserApiDto.fromJson(Map<String, dynamic> json) => _$ChirpUserApiDtoFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override final  String? email;
@override final  String? phone;
@override final  String? username;
@override@JsonKey(name: 'vibe_points') final  int vibePoints;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of ChirpUserApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChirpUserApiDtoCopyWith<_ChirpUserApiDto> get copyWith => __$ChirpUserApiDtoCopyWithImpl<_ChirpUserApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChirpUserApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChirpUserApiDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.username, username) || other.username == username)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,phone,username,vibePoints,avatarUrl,createdAt,updatedAt);

@override
String toString() {
  return 'ChirpUserApiDto(userId: $userId, email: $email, phone: $phone, username: $username, vibePoints: $vibePoints, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ChirpUserApiDtoCopyWith<$Res> implements $ChirpUserApiDtoCopyWith<$Res> {
  factory _$ChirpUserApiDtoCopyWith(_ChirpUserApiDto value, $Res Function(_ChirpUserApiDto) _then) = __$ChirpUserApiDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId, String? email, String? phone, String? username,@JsonKey(name: 'vibe_points') int vibePoints,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$ChirpUserApiDtoCopyWithImpl<$Res>
    implements _$ChirpUserApiDtoCopyWith<$Res> {
  __$ChirpUserApiDtoCopyWithImpl(this._self, this._then);

  final _ChirpUserApiDto _self;
  final $Res Function(_ChirpUserApiDto) _then;

/// Create a copy of ChirpUserApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = freezed,Object? phone = freezed,Object? username = freezed,Object? vibePoints = null,Object? avatarUrl = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ChirpUserApiDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
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
