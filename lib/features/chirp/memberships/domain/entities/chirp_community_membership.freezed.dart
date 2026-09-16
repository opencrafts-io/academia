// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_community_membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChirpCommunityMembership {

 int get id; int get communityID; String get userID; String get role; bool get banned; String? get bannedByID; String? get bannedReason; DateTime? get bannedAt; DateTime get joinedAt;
/// Create a copy of ChirpCommunityMembership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipCopyWith<ChirpCommunityMembership> get copyWith => _$ChirpCommunityMembershipCopyWithImpl<ChirpCommunityMembership>(this as ChirpCommunityMembership, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembership&&(identical(other.id, id) || other.id == id)&&(identical(other.communityID, communityID) || other.communityID == communityID)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.role, role) || other.role == role)&&(identical(other.banned, banned) || other.banned == banned)&&(identical(other.bannedByID, bannedByID) || other.bannedByID == bannedByID)&&(identical(other.bannedReason, bannedReason) || other.bannedReason == bannedReason)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,communityID,userID,role,banned,bannedByID,bannedReason,bannedAt,joinedAt);

@override
String toString() {
  return 'ChirpCommunityMembership(id: $id, communityID: $communityID, userID: $userID, role: $role, banned: $banned, bannedByID: $bannedByID, bannedReason: $bannedReason, bannedAt: $bannedAt, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipCopyWith<$Res>  {
  factory $ChirpCommunityMembershipCopyWith(ChirpCommunityMembership value, $Res Function(ChirpCommunityMembership) _then) = _$ChirpCommunityMembershipCopyWithImpl;
@useResult
$Res call({
 int id, int communityID, String userID, String role, bool banned, String? bannedByID, String? bannedReason, DateTime? bannedAt, DateTime joinedAt
});




}
/// @nodoc
class _$ChirpCommunityMembershipCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipCopyWith<$Res> {
  _$ChirpCommunityMembershipCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembership _self;
  final $Res Function(ChirpCommunityMembership) _then;

/// Create a copy of ChirpCommunityMembership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityID = null,Object? userID = null,Object? role = null,Object? banned = null,Object? bannedByID = freezed,Object? bannedReason = freezed,Object? bannedAt = freezed,Object? joinedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityID: null == communityID ? _self.communityID : communityID // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,banned: null == banned ? _self.banned : banned // ignore: cast_nullable_to_non_nullable
as bool,bannedByID: freezed == bannedByID ? _self.bannedByID : bannedByID // ignore: cast_nullable_to_non_nullable
as String?,bannedReason: freezed == bannedReason ? _self.bannedReason : bannedReason // ignore: cast_nullable_to_non_nullable
as String?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChirpCommunityMembership].
extension ChirpCommunityMembershipPatterns on ChirpCommunityMembership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChirpCommunityMembership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChirpCommunityMembership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChirpCommunityMembership value)  $default,){
final _that = this;
switch (_that) {
case _ChirpCommunityMembership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChirpCommunityMembership value)?  $default,){
final _that = this;
switch (_that) {
case _ChirpCommunityMembership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int communityID,  String userID,  String role,  bool banned,  String? bannedByID,  String? bannedReason,  DateTime? bannedAt,  DateTime joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChirpCommunityMembership() when $default != null:
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int communityID,  String userID,  String role,  bool banned,  String? bannedByID,  String? bannedReason,  DateTime? bannedAt,  DateTime joinedAt)  $default,) {final _that = this;
switch (_that) {
case _ChirpCommunityMembership():
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int communityID,  String userID,  String role,  bool banned,  String? bannedByID,  String? bannedReason,  DateTime? bannedAt,  DateTime joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChirpCommunityMembership() when $default != null:
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ChirpCommunityMembership implements ChirpCommunityMembership {
  const _ChirpCommunityMembership({required this.id, required this.communityID, required this.userID, required this.role, this.banned = false, this.bannedByID, this.bannedReason, this.bannedAt, required this.joinedAt});
  

@override final  int id;
@override final  int communityID;
@override final  String userID;
@override final  String role;
@override@JsonKey() final  bool banned;
@override final  String? bannedByID;
@override final  String? bannedReason;
@override final  DateTime? bannedAt;
@override final  DateTime joinedAt;

/// Create a copy of ChirpCommunityMembership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChirpCommunityMembershipCopyWith<_ChirpCommunityMembership> get copyWith => __$ChirpCommunityMembershipCopyWithImpl<_ChirpCommunityMembership>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChirpCommunityMembership&&(identical(other.id, id) || other.id == id)&&(identical(other.communityID, communityID) || other.communityID == communityID)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.role, role) || other.role == role)&&(identical(other.banned, banned) || other.banned == banned)&&(identical(other.bannedByID, bannedByID) || other.bannedByID == bannedByID)&&(identical(other.bannedReason, bannedReason) || other.bannedReason == bannedReason)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,communityID,userID,role,banned,bannedByID,bannedReason,bannedAt,joinedAt);

@override
String toString() {
  return 'ChirpCommunityMembership(id: $id, communityID: $communityID, userID: $userID, role: $role, banned: $banned, bannedByID: $bannedByID, bannedReason: $bannedReason, bannedAt: $bannedAt, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$ChirpCommunityMembershipCopyWith<$Res> implements $ChirpCommunityMembershipCopyWith<$Res> {
  factory _$ChirpCommunityMembershipCopyWith(_ChirpCommunityMembership value, $Res Function(_ChirpCommunityMembership) _then) = __$ChirpCommunityMembershipCopyWithImpl;
@override @useResult
$Res call({
 int id, int communityID, String userID, String role, bool banned, String? bannedByID, String? bannedReason, DateTime? bannedAt, DateTime joinedAt
});




}
/// @nodoc
class __$ChirpCommunityMembershipCopyWithImpl<$Res>
    implements _$ChirpCommunityMembershipCopyWith<$Res> {
  __$ChirpCommunityMembershipCopyWithImpl(this._self, this._then);

  final _ChirpCommunityMembership _self;
  final $Res Function(_ChirpCommunityMembership) _then;

/// Create a copy of ChirpCommunityMembership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityID = null,Object? userID = null,Object? role = null,Object? banned = null,Object? bannedByID = freezed,Object? bannedReason = freezed,Object? bannedAt = freezed,Object? joinedAt = null,}) {
  return _then(_ChirpCommunityMembership(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityID: null == communityID ? _self.communityID : communityID // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,banned: null == banned ? _self.banned : banned // ignore: cast_nullable_to_non_nullable
as bool,bannedByID: freezed == bannedByID ? _self.bannedByID : bannedByID // ignore: cast_nullable_to_non_nullable
as String?,bannedReason: freezed == bannedReason ? _self.bannedReason : bannedReason // ignore: cast_nullable_to_non_nullable
as String?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
