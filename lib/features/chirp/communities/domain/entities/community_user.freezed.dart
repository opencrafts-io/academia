// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityUser {

 String get userId; String get userName; String get role;
/// Create a copy of CommunityUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityUserCopyWith<CommunityUser> get copyWith => _$CommunityUserCopyWithImpl<CommunityUser>(this as CommunityUser, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,role);

@override
String toString() {
  return 'CommunityUser(userId: $userId, userName: $userName, role: $role)';
}


}

/// @nodoc
abstract mixin class $CommunityUserCopyWith<$Res>  {
  factory $CommunityUserCopyWith(CommunityUser value, $Res Function(CommunityUser) _then) = _$CommunityUserCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String role
});




}
/// @nodoc
class _$CommunityUserCopyWithImpl<$Res>
    implements $CommunityUserCopyWith<$Res> {
  _$CommunityUserCopyWithImpl(this._self, this._then);

  final CommunityUser _self;
  final $Res Function(CommunityUser) _then;

/// Create a copy of CommunityUser
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


/// Adds pattern-matching-related methods to [CommunityUser].
extension CommunityUserPatterns on CommunityUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityUser value)  $default,){
final _that = this;
switch (_that) {
case _CommunityUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityUser value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityUser() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String role)  $default,) {final _that = this;
switch (_that) {
case _CommunityUser():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String role)?  $default,) {final _that = this;
switch (_that) {
case _CommunityUser() when $default != null:
return $default(_that.userId,_that.userName,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityUser implements CommunityUser {
  const _CommunityUser({required this.userId, required this.userName, required this.role});
  

@override final  String userId;
@override final  String userName;
@override final  String role;

/// Create a copy of CommunityUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityUserCopyWith<_CommunityUser> get copyWith => __$CommunityUserCopyWithImpl<_CommunityUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityUser&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,userId,userName,role);

@override
String toString() {
  return 'CommunityUser(userId: $userId, userName: $userName, role: $role)';
}


}

/// @nodoc
abstract mixin class _$CommunityUserCopyWith<$Res> implements $CommunityUserCopyWith<$Res> {
  factory _$CommunityUserCopyWith(_CommunityUser value, $Res Function(_CommunityUser) _then) = __$CommunityUserCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String role
});




}
/// @nodoc
class __$CommunityUserCopyWithImpl<$Res>
    implements _$CommunityUserCopyWith<$Res> {
  __$CommunityUserCopyWithImpl(this._self, this._then);

  final _CommunityUser _self;
  final $Res Function(_CommunityUser) _then;

/// Create a copy of CommunityUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? role = null,}) {
  return _then(_CommunityUser(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
