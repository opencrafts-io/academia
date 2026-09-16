// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_user_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityUserApiDto {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String get userName; String get role;
/// Create a copy of CommunityUserApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserApiDtoCopyWith<CommunityUserApiDto> get copyWith => _$CommunityUserApiDtoCopyWithImpl<CommunityUserApiDto>(this as CommunityUserApiDto, _$identity);

  /// Serializes this CommunityUserApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUserApiDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,role);

@override
String toString() {
  return 'CommunityUserApiDto(userId: $userId, userName: $userName, role: $role)';
}


}

/// @nodoc
abstract mixin class $CommunityUserApiDtoCopyWith<$Res>  {
  factory $CommunityUserApiDtoCopyWith(CommunityUserApiDto value, $Res Function(CommunityUserApiDto) _then) = _$CommunityUserApiDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName, String role
});




}
/// @nodoc
class _$CommunityUserApiDtoCopyWithImpl<$Res>
    implements $CommunityUserApiDtoCopyWith<$Res> {
  _$CommunityUserApiDtoCopyWithImpl(this._self, this._then);

  final CommunityUserApiDto _self;
  final $Res Function(CommunityUserApiDto) _then;

/// Create a copy of CommunityUserApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? role = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityUserApiDto].
extension CommunityUserApiDtoPatterns on CommunityUserApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUserApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUserApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUserApiDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUserApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUserApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUserApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUserApiDto() when $default != null:
return $default(_that.userId,_that.userName,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String role)  $default,) {final _that = this;
switch (_that) {
case _CommunityUserApiDto():
return $default(_that.userId,_that.userName,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName,  String role)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUserApiDto() when $default != null:
return $default(_that.userId,_that.userName,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityUserApiDto implements CommunityUserApiDto {
  const _CommunityUserApiDto({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') required this.userName, required this.role});
  factory _CommunityUserApiDto.fromJson(Map<String, dynamic> json) => _$CommunityUserApiDtoFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String userName;
@override final  String role;

/// Create a copy of CommunityUserApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserApiDtoCopyWith<_CommunityUserApiDto> get copyWith => __$CommunityUserApiDtoCopyWithImpl<_CommunityUserApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityUserApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUserApiDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,role);

@override
String toString() {
  return 'CommunityUserApiDto(userId: $userId, userName: $userName, role: $role)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserApiDtoCopyWith<$Res> implements $CommunityUserApiDtoCopyWith<$Res> {
  factory _$CommunityUserApiDtoCopyWith(_CommunityUserApiDto value, $Res Function(_CommunityUserApiDto) _then) = __$CommunityUserApiDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName, String role
});




}
/// @nodoc
class __$CommunityUserApiDtoCopyWithImpl<$Res>
    implements _$CommunityUserApiDtoCopyWith<$Res> {
  __$CommunityUserApiDtoCopyWithImpl(this._self, this._then);

  final _CommunityUserApiDto _self;
  final $Res Function(_CommunityUserApiDto) _then;

/// Create a copy of CommunityUserApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? role = null,}) {
  return _then(_CommunityUserApiDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
